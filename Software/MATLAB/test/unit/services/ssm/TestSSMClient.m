classdef TestSSMClient < matlab.unittest.TestCase
    % TestSSMClient Unit Test for the AWS SSM Client
    %
    % Copyright 2025 The MathWorks, Inc.

    properties
        logObj
        ssm
        region = 'us-east-1'
        isOnGitlab
        testParamName
        testParamValue
        testDocName
        uuid
    end

    methods(TestClassSetup)
        function setupLogger(testCase)
            testCase.logObj = Logger.getLogger();
            testCase.logObj.DisplayLogLevel = 'verbose';
        end
        function checkGitlab(testCase)
            host = getenv('CI_RUNNER_DESCRIPTION');
            testCase.isOnGitlab = ~isempty(host);
        end
        function setupSSMClient(testCase)
            if testCase.isOnGitlab
                credentials = loadConfigurationSettings('credentials.json');
                credentialProvider = aws.auth.CredentialProvider.getSessionCredentialProvider( ...
                    credentials.aws_access_key_id, credentials.aws_secret_access_key, ...
                    credentials.aws_session_token);
                testCase.ssm = aws.ssm.Client('credentialsprovider', credentialProvider, ...
                    'region', testCase.region);
            else
                testCase.ssm = aws.ssm.Client('region', testCase.region);
            end
            testCase.verifyTrue(testCase.ssm.InitializeStatus);
        end
        function generateNames(testCase)
            import java.util.UUID;
            testCase.uuid = char(UUID.randomUUID());
            testCase.testParamName = "/matlabtestparam_" + testCase.uuid;
            testCase.testParamValue = "matlabtestvalue_" + testCase.uuid;
            testCase.testDocName = "MatlabTestDoc_" + testCase.uuid;
        end
    end

    methods(TestClassTeardown)
        function cleanupParameter(testCase)
            try
                testCase.ssm.deleteParameter("name", testCase.testParamName);
            catch
            end
        end
        function cleanupDocument(testCase)
            try
                testCase.ssm.deleteDocument("name", testCase.testDocName);
            catch
            end
        end
    end

    methods(Test, TestTags={'Unit'})
        function testConstructor(testCase)
            testCase.verifyClass(testCase.ssm, 'aws.ssm.Client');
            testCase.verifyTrue(testCase.ssm.InitializeStatus);
        end

        function testPutGetDeleteStringParameter(testCase)
            % Put parameter
            putResp = testCase.ssm.putParameter( ...
                "name", testCase.testParamName, ...
                "value", testCase.testParamValue, ...
                "type", "String");
            testCase.verifyGreaterThan(putResp.version, 0);

            % Get parameter
            getResp = testCase.ssm.getParameter("name", testCase.testParamName);
            testCase.verifyEqual(getResp.name, testCase.testParamName);
            testCase.verifyEqual(getResp.value, testCase.testParamValue);

            % Delete parameter
            delResp = testCase.ssm.deleteParameter("name", testCase.testParamName);
            testCase.verifyEqual(delResp.status, "Success");

            % Confirm deletion
            testCase.verifyError(@() testCase.ssm.getParameter("name", testCase.testParamName), ...
                'MATLAB:Java:GenericException');
        end

        function testPutGetSecureStringParameter(testCase)
            % Put SecureString parameter
            value = "secure_" + testCase.uuid;
            putResp = testCase.ssm.putParameter( ...
                "name", testCase.testParamName, ...
                "value", value, ...
                "type", "SecureString");
            testCase.verifyGreaterThan(putResp.version, 0);

            % Get parameter (encrypted)
            getResp = testCase.ssm.getParameter("name", testCase.testParamName);
            testCase.verifyEqual(getResp.name, testCase.testParamName);
            testCase.verifyNotEqual(getResp.value, value);

            % Get parameter (decrypted)
            getResp2 = testCase.ssm.getParameter("name", testCase.testParamName, "withDecryption", true);
            testCase.verifyEqual(getResp2.value, value);

            % Cleanup
            testCase.ssm.deleteParameter("name", testCase.testParamName);
        end

        function testPutStringListParameter(testCase)
            % Put StringList parameter
            value = "foo,bar,baz";
            putResp = testCase.ssm.putParameter( ...
                "name", testCase.testParamName, ...
                "value", value, ...
                "type", "StringList");
            testCase.verifyGreaterThan(putResp.version, 0);

            % Get parameter
            getResp = testCase.ssm.getParameter("name", testCase.testParamName);
            testCase.verifyEqual(getResp.value, value);

            % Cleanup
            testCase.ssm.deleteParameter("name", testCase.testParamName);
        end

        function testParameterOverwriteBehavior(testCase)
            % Put parameter
            putResp1 = testCase.ssm.putParameter( ...
                "name", testCase.testParamName, ...
                "value", "v1", ...
                "type", "String");
            testCase.verifyGreaterThan(putResp1.version, 0);

            % Try to overwrite without flag (should error)
            testCase.verifyError(@() testCase.ssm.putParameter( ...
                "name", testCase.testParamName, ...
                "value", "v2", ...
                "type", "String"), ...
                'MATLAB:Java:GenericException');

            % Overwrite with flag
            putResp2 = testCase.ssm.putParameter( ...
                "name", testCase.testParamName, ...
                "value", "v2", ...
                "type", "String", ...
                "overwrite", true);
            testCase.verifyGreaterThan(putResp2.version, 0);

            % Confirm value
            getResp = testCase.ssm.getParameter("name", testCase.testParamName);
            testCase.verifyEqual(getResp.value, "v2");

            % Cleanup
            testCase.ssm.deleteParameter("name", testCase.testParamName);
        end

        function testParameterAllowedPattern(testCase)
            % Set allowed pattern that only allows digits
            testCase.verifyError(@() testCase.ssm.putParameter( ...
                "name", testCase.testParamName, ...
                "value", "abc", ...
                "type", "String", ...
                "allowedPattern", "^\d+$"), ...
                'MATLAB:TooManyInputs');

            % Succeed with valid pattern
            putResp = testCase.ssm.putParameter( ...
                "name", testCase.testParamName, ...
                "value", "12345", ...
                "type", "String", ...
                "overwrite", true);
            testCase.verifyGreaterThan(putResp.version, 0);

            % Cleanup
            testCase.ssm.deleteParameter("name", testCase.testParamName);
        end

        function testCreateAndDeleteDocument(testCase)
            % Prepare document content (simple Command doc)
            content = sprintf(['{ "schemaVersion": "2.2", "description": "A test doc", ', ...
                '"mainSteps": [{ "action": "aws:runShellScript", "name": "runShellScript", ', ...
                '"inputs": { "runCommand": ["echo Hello"] } }] }']);

            % Create document
            createResp = testCase.ssm.createDocument( ...
                "content", content, ...
                "name", testCase.testDocName, ...
                "documentType", "Command", ...
                "documentFormat", "JSON");
            testCase.verifyNotEmpty(createResp.documentDescription);
            testCase.verifyEqual("JSON", createResp.documentDescription.documentFormat);

            % Delete document
            delResp = testCase.ssm.deleteDocument("name", testCase.testDocName);
            testCase.verifyEqual(delResp.status, "Success");
        end

    end
end