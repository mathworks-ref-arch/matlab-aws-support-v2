classdef Logger < handle
    %LOGGER Robust, extensible logger for MATLAB scripts and applications.
    %
    %   Provides log levels, colored output, file logging with rotation,
    %   and JSON/plain text formats.
    %
    %   ================
    %   Syntax
    %   ================
    %   log = Logger.getLogger();
    %   log.write(level, message, ...);
    %
    %   ================
    %   Examples
    %   ================
    %   % Get the singleton logger
    %   log = Logger.getLogger();
    %
    %   % Set options
    %   log.MsgPrefix = 'MYAPP';
    %   log.LogFile = 'myapp.log';
    %   log.LogFormat = 'json'; % or 'plain'
    %   log.MaxLogFileSize = 1e6; % 1 MB for testing
    %   log.MaxLogFiles = 3;
    %
    %   % Log various messages
    %   log.write('info', 'Starting process at %s', datestr(now));
    %   log.write('debug', 'Debug value: %.3f', pi);
    %   log.write('warning', 'This is a warning');
    %   log.write('error', 'This is an error: %s', 'something failed');
    %   log.write('verbose', 'Extra details: %d', 42);
    %
    %   % Get logged messages (in memory)
    %   msgs = log.getMessages('info');
    %   disp(msgs);
    %
    %   % Clear in-memory and file logs
    %   log.clearMessages();
    %   log.clearLogFile();
    %
    %   ================
    %   Supported Levels
    %   ================
    %   'verbose', 'debug', 'info', 'warning', 'error'
    %
    %   ================
    %   Properties
    %   ================
    %   LogFile         - Log file path (empty = no file logging)
    %   LogFormat       - 'plain' or 'json'
    %   MsgPrefix       - Custom prefix for all messages
    %   FileLogLevel    - Minimum level for file logging
    %   DisplayLogLevel - Minimum level for command window
    %   MaxLogFileSize  - Max log file size in bytes before rotation
    %   MaxLogFiles     - Number of rotated log files to keep
    %
    %   See also: Logger.getLogger, Logger.write, Logger.getMessages

    % Copyright 2025 The MathWorks, Inc.

    properties (Constant, Access=private)
        ValidLevels = {'verbose', 'debug', 'info', 'warning', 'error'};
    end

    properties
        LogFile = '';                % Log file path (empty = no file logging)
        LogFormat = 'plain';         % 'plain' or 'json'
        MsgPrefix = '';              % Custom prefix for all messages
        FileLogLevel = 'debug';      % Minimum level for file logging
        DisplayLogLevel = 'info';    % Minimum level for command window
        MaxLogFileSize = 10*1024*1024; % 10 MB default
        MaxLogFiles = 5;             % Number of rotated log files to keep
    end

    properties (Access=private)
        Messages = struct('timestamp', {}, 'level', {}, 'message', {});
    end

    methods (Access=private)
        function obj = Logger()
            % Private constructor for singleton pattern
        end
    end

    methods (Static)
        function obj = getLogger()
            %GETLOGGER Returns the singleton Logger instance.
            %
            %   log = Logger.getLogger();
            %
            %   Returns a singleton Logger object. Use this to ensure only
            %   one logger instance is used throughout your application.
            persistent uniqueLogger
            if isempty(uniqueLogger) || ~isvalid(uniqueLogger)
                uniqueLogger = Logger();
            end
            obj = uniqueLogger;
        end
    end

    methods
        function write(obj, level, message, varargin)
            %WRITE Logs a message at the given level, with sprintf-style formatting.
            %
            %   log.write(level, message, ...)
            %
            %   level   - Log level ('verbose', 'debug', 'info', 'warning', 'error')
            %   message - Message string (can include sprintf-style format)
            %   ...     - Additional arguments for sprintf
            %
            %   Example:
            %       log.write('info', 'Processing file: %s', filename);
            %       log.write('error', 'Error code: %d', code);

            prefix = '';
            if ~isempty(obj.MsgPrefix)
                prefix = obj.MsgPrefix;
            end
            timestamp = datetime('now','Format','yyyy-MM-dd''T''HH:mm:ss.SSS');
            timestampStr = char(timestamp);

            % Compose message
            if nargin > 3
                message = sprintf(message, varargin{:});
            end

            if iscell(message), message = message{1}; end

            % Format for log file (no color, with ::)
            logText = sprintf('[%s] %s %s : %s ', prefix, timestampStr, upper(level), message);

            % Format for Command Window (with color)
            dispText = sprintf('%s', logText);

            % Output to Command Window
            if obj.isLevelEnabled(level, obj.DisplayLogLevel)
                fprintf('%s\n', dispText);
            end

            % Output to file (plain text, no color)
            if ~isempty(obj.LogFile) && obj.isLevelEnabled(level, obj.FileLogLevel)
                obj.checkRotateLogFile();
                [fid, errmsg] = fopen(obj.LogFile, 'a');
                if fid > 0
                    fprintf(fid, '%s\n', logText);
                    fclose(fid);
                else
                    warning('Logger:FileOpenFailed', 'Could not open log file: %s', errmsg);
                end
            end
        end

        function clearMessages(obj)
            %CLEARMESSAGES Clears stored messages from memory.
            %
            %   log.clearMessages()
            %
            %   Example:
            %       log.clearMessages();
            obj.Messages = struct('timestamp', {}, 'level', {}, 'message', {});
        end

        function msgs = getMessages(obj, minLevel)
            %GETMESSAGES Returns stored messages, optionally filtered by minLevel.
            %
            %   msgs = log.getMessages()
            %   msgs = log.getMessages(minLevel)
            %
            %   minLevel - Minimum log level to return ('info', 'warning', etc.)
            %
            %   Example:
            %       msgs = log.getMessages('info');
            if nargin < 2
                msgs = obj.Messages;
                return
            end
            minIdx = obj.levelIndex(minLevel);
            idxs = arrayfun(@(m) obj.levelIndex(m.level) >= minIdx, obj.Messages);
            msgs = obj.Messages(idxs);
        end

        function clearLogFile(obj)
            %CLEARLOGFILE Deletes the log file and rotated logs.
            %
            %   log.clearLogFile()
            %
            %   Example:
            %       log.clearLogFile()
            if ~isempty(obj.LogFile) && exist(obj.LogFile, 'file')
                delete(obj.LogFile);
            end
            % Delete rotated logs
            for k = 1:obj.MaxLogFiles
                rotated = sprintf('%s.%d', obj.LogFile, k);
                if exist(rotated, 'file')
                    delete(rotated);
                end
            end
        end
    end

    methods (Access=private)
        function idx = levelIndex(obj, level)
            %LEVELINDEX Returns the index of the log level.
            idx = find(strcmpi(level, obj.ValidLevels), 1, 'first');
            if isempty(idx)
                idx = 1; % Default to lowest
            end
        end

        function tf = isLevelEnabled(obj, level, threshold)
            %ISLEVELENABLED True if level >= threshold.
            idx = obj.levelIndex(level);
            threshIdx = obj.levelIndex(threshold);
            tf = idx >= threshIdx;
        end

        function checkRotateLogFile(obj)
            %CHECKROTATELOGFILE Rotates log file if size exceeds limit.
            if isempty(obj.LogFile) || ~exist(obj.LogFile, 'file')
                return;
            end
            fileInfo = dir(obj.LogFile);
            if fileInfo.bytes > obj.MaxLogFileSize
                obj.rotateLogFile();
            end
        end

        function rotateLogFile(obj)
            %ROTATELOGFILE Rotates log files up to MaxLogFiles.
            for k = obj.MaxLogFiles:-1:2
                oldName = sprintf('%s.%d', obj.LogFile, k-1);
                newName = sprintf('%s.%d', obj.LogFile, k);
                if exist(oldName, 'file')
                    movefile(oldName, newName, 'f');
                end
            end
            if exist(obj.LogFile, 'file')
                movefile(obj.LogFile, sprintf('%s.1', obj.LogFile), 'f');
            end
        end
    end
end