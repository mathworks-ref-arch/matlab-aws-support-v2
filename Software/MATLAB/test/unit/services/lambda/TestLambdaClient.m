classdef TestLambdaClient < matlab.unittest.TestCase
    % TESTCLIENT Unit Test for the Amazon Lambda Client
    % The test suite exercises the basic operations on the Amazon Lambda Client.

    % Copyright 2025 The MathWorks, Inc.

    properties
        logObj
        lambda
        isOnGitlab
        runtimeZipFile
        functionName
    end
    methods(TestClassSetup)
        % Shared setup for the entire test class
        function testSetup(testCase)
            testCase.logObj = Logger.getLogger();
            testCase.logObj.DisplayLogLevel = 'verbose';

        end
        function checkGitlab(testCase)
            host=getenv('CI_RUNNER_DESCRIPTION');
            testCase.isOnGitlab = ~isempty(host);
        end

        function initializeLambdaClient(testCase)
            %overriding the region
            region = 'us-east-1';
            if testCase.isOnGitlab
                credentials = loadConfigurationSettings('credentials.json');
                credentialProvider = aws.auth.CredentialProvider.getSessionCredentialProvider( ...
                    credentials.aws_access_key_id, credentials.aws_secret_access_key, ...
                    credentials.aws_session_token);
                testCase.lambda = aws.lambda.Client( ...
                    'credentialsprovider', credentialProvider, 'region', region);

            else
                testCase.lambda = aws.lambda.Client('region', region);
            end

            filePath = mfilename('fullpath');

            testDataFolder = fileparts(fileparts(fileparts(filePath)));

            testCase.runtimeZipFile = fullfile(testDataFolder, 'data', 'lambda', ...
                'coder', 'matlab-ci-mMod-lambda.zip');
            [~, fileName, ~] = fileparts(testCase.runtimeZipFile);
            testCase.functionName = [fileName char(matlabRelease.Release)];

        end
    end

    methods(Test, TestTags = {'Unit'})
        % Test methods
        function testConstructor(testCase)
            write(testCase.logObj,'debug','Testing testConstructor');
            testCase.verifyClass(testCase.lambda,'aws.lambda.Client');
        end
        function testCreateLambdaFunction(testCase)
            zipFile = aws.core.model.SdkBytes(testCase.runtimeZipFile);

            codeSource = struct('zipFile', zipFile);
            functionCode = aws.lambda.model.FunctionCode(codeSource);

            runtime = 'provided.al2';
            role = 'arn:aws:iam::171626478215:role/sivab-lambda-test';
            handler = 'function.handler';
            code = functionCode;
            timeout = 10;

            try
                % Call the createFunction method with the function name and options
                response = testCase.lambda.createFunction(functionName=testCase.functionName, ...
                    runtime = runtime, ...
                    role = role, ...
                    handler = handler, ...
                    code = code, ...
                    timeout = timeout);
                testCase.verifyEqual(char(response.Handle.functionName), testCase.functionName);
            catch exception
                rethrow(exception);
            end
        end

        function testInvokeLambdaFunction(testCase)
            inputJSONPayload = jsonencode(struct('input', '15,4'));
            expectedOutput = mod(15,4);
            payload = aws.core.model.SdkBytes(inputJSONPayload);

            % Pause execution for 5 seconds for Lambda to be available
            pause(5);

            functionResponse = testCase.lambda.invokeFunction(functionName=testCase.functionName, ...
                payload=payload, logType='Tail', invocationType='RequestResponse');

            % Get the payload from the response
            responsePayload = functionResponse.getPayload();
            testCase.verifyEqual(str2double(responsePayload), expectedOutput);
        end

        function testDeleteLambdaFunction(testCase)

            % Call the deleteFunction method
            response = testCase.lambda.deleteFunction(functionName=testCase.functionName);
            testCase.verifyNotEmpty(response.Handle);
        end

    end
end

