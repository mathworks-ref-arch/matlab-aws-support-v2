classdef Object < handle
    % OBJECT Shared base class for MATLAB AWS SDK wrappers.
    %
    % Syntax
    %   obj = aws.Object();
    %
    % Description
    %   Provides logging and proxy-configuration helpers that are reused by
    %   all service clients and model objects. Users typically do not
    %   instantiate this class directly; it exists so subclasses inherit a
    %   consistent logger and proxy behavior.

    % Copyright 2025 The MathWorks, Inc.

    properties(Hidden)
        Handle
        ProxyConfiguration = struct('host', '', 'port', [], 'password', '', 'username', '');
        logObj
    end


    methods
        function obj = Object(~, varargin) %#ok<INUSD>
            % OBJECT Construct the base AWS helper.
            %
            % Syntax
            %   obj = aws.Object();
            %
            % Notes
            %   Subclasses call this constructor to receive a configured
            %   logger. Any input arguments are ignored intentionally so
            %   derived classes can pass varargin without errors.
            obj.logObj = Logger.getLogger();
        end

        function initializeLogger(obj, clientPrefix)
            % INITIALIZELOGGER Configure the shared logger prefix.
            %
            % Syntax
            %   obj.initializeLogger("Amazon:S3:Client");
            %
            % Inputs
            %   clientPrefix - (string) Text prefixed to every log message.
            %
            arguments
                obj
                clientPrefix (1,1) string {mustBeTextScalar} = ""
            end

            obj.logObj = Logger.getLogger();
            if strlength(clientPrefix) > 0
                obj.logObj.MsgPrefix = char(clientPrefix);
            end
        end
    end

end
