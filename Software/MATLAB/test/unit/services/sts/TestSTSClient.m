classdef TestSTSClient < matlab.unittest.TestCase
    % Test Class for AWS STS service

    % Copyright 2025 The MathWorks, Inc.

    properties
        logObj
        sts
        isOnGitlab
    end

    methods(TestClassSetup)
        function testSetup(testCase)
            testCase.logObj = Logger.getLogger();
            testCase.logObj.DisplayLogLevel = 'verbose';

        end
        function checkGitlab(testCase)
            host=getenv('CI_RUNNER_DESCRIPTION');
            testCase.isOnGitlab = ~isempty(host);
        end
        function initializeSTSClient(testCase)

            if testCase.isOnGitlab
                credentials = loadConfigurationSettings('credentials.json');
                credentialProvider = aws.auth.CredentialProvider.getSessionCredentialProvider( ...
                    credentials.aws_access_key_id, credentials.aws_secret_access_key, ...
                    credentials.aws_session_token);
                testCase.sts = aws.sts.Client('credentialsprovider', credentialProvider);

            else
                testCase.sts = aws.sts.Client();
            end

        end
    end

    methods(Test, TestTags = {'Unit'})
        % Test methods

        function testConstructor(testCase)
            write(testCase.logObj,'debug','Testing testConstructor');
            testCase.verifyClass(testCase.sts,'aws.sts.Client');
        end
        function testGetCallerIdentity(testCase)
            write(testCase.logObj,'debug','Testing testGetCallerIdentity');
            callerIdentity = testCase.sts.getCallerIdentity();
            testCase.verifyNotEmpty(callerIdentity.accountId);
        end
    end

end