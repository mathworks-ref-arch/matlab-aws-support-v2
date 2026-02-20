classdef TestLogger < matlab.unittest.TestCase
    % TESTLOGGER test class for Logger class

    % Copyright 2025 The MathWorks, Inc.

    methods(Test, TestTags = {'Unit'})
        function testSingletonInstance(testCase)
            log1 = Logger.getLogger();
            log2 = Logger.getLogger();
            testCase.verifyEqual(log1, log2); % Singleton check
        end

        function testWriteToConsoleOnly(testCase)
            log = Logger.getLogger();
            log.DisplayLogLevel = 'info';
            log.FileLogLevel = 'error'; % Suppress file logging
            log.LogFile = '';           % No file
            log.MsgPrefix = '[TEST]';
            log.write('info', 'This is a test message');
        end

        function testWriteToFile(testCase)
            log = Logger.getLogger();
            tempFile = [tempname, '.log'];
            log.LogFile = tempFile;
            log.FileLogLevel = 'debug';
            log.DisplayLogLevel = 'error'; % Suppress console
            log.write('debug', 'File logging test');
            testCase.verifyTrue(isfile(tempFile));
            delete(tempFile);
        end

        function testLogRotation(testCase)
            log = Logger.getLogger();
            tempFile = [tempname, '.log'];
            log.LogFile = tempFile;
            log.MaxLogFileSize = 1; % Force rotation
            log.MaxLogFiles = 2;
            log.write('debug', 'Trigger rotation');
            log.write('debug', 'Trigger rotation again');
            testCase.verifyTrue(isfile([tempFile, '.1']));
            delete(tempFile);
            delete([tempFile, '.1']);
        end

        function testClearMessages(testCase)
            log = Logger.getLogger();
            log.clearMessages();
            msgs = log.getMessages();
            testCase.verifyEmpty(msgs);
        end

        function testGetMessagesWithFilter(testCase)
            log = Logger.getLogger();
            log.clearMessages();
            log.write('info', 'Info message');
            log.write('debug', 'Debug message');
            msgs = log.getMessages('info');
            testCase.verifyTrue(all(strcmp({msgs.level}, 'info')));
        end

        function testClearLogFile(testCase)
            log = Logger.getLogger();
            tempFile = [tempname, '.log'];
            log.LogFile = tempFile;
            log.write('info', 'Log file test');
            log.clearLogFile();
            testCase.verifyFalse(isfile(tempFile));
        end

        function testWriteWithInvalidLevel(~)
            log = Logger.getLogger();
            log.DisplayLogLevel = 'info';
            log.write('notalevel', 'This should fallback to lowest level');
            % No error should occur, and message should be printed if fallback works
        end

        function testWriteLevelFiltering(~)
            log = Logger.getLogger();
            log.DisplayLogLevel = 'error'; % Only 'error' and above should print
            log.write('debug', 'This should not appear'); % Should be filtered out
            log.write('error', 'This should appear');     % Should be printed
        end

    end
end