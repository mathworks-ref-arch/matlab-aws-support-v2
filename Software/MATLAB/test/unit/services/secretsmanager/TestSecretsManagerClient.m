classdef TestSecretsManagerClient < matlab.unittest.TestCase
    % TESTSECRETSMANAGERCLIENT Unit Test for the Amazon Secrets Manager Client
    %
    % The assertions that you can use in test cases:
    %
    %    verifyClass
    %    verifyNotEmpty
    %    verifyEqual
    %
    % The test suite exercises the basic operations on the Secrets Manager Client.

    % Copyright 2025 The MathWorks, Inc.

    properties
        logObj
        sm                                      % aws.secretsmanager.Client
        isOnGitlab logical = false
        region = 'us-east-1'

        % Secrets created in setup
        secretNameStr string
        secretArnStr  string

        secretNameBin string
        secretArnBin  string
    end

    %% -------------------- Class Setup --------------------
    methods(TestClassSetup)
        function testSetup(testCase)
            testCase.logObj = Logger.getLogger();
            testCase.logObj.DisplayLogLevel = 'verbose';
        end

        function checkGitlab(testCase)
            host = getenv('CI_RUNNER_DESCRIPTION');
            testCase.isOnGitlab = ~isempty(host);
        end

        function initializeSecretsManagerClient(testCase)
            if testCase.isOnGitlab
                creds = loadConfigurationSettings('credentials.json');
                cp = aws.auth.CredentialProvider.getSessionCredentialProvider( ...
                        creds.aws_access_key_id, creds.aws_secret_access_key, creds.aws_session_token);
                testCase.sm = aws.secretsmanager.Client('credentialsprovider', cp, 'region', testCase.region);
            else
                testCase.sm = aws.secretsmanager.Client('region', testCase.region);
            end
        end

        function createBaselineSecrets(testCase)
            rel = matlabRelease.Release;
            ts  = string(datetime('now','Format','yyyyMMddHHmmssSSS'));

            % --- Create a STRING secret ---
            testCase.secretNameStr = "matlab-ci-sm-str-" + ts + "-" + rel;
            doTags = dictionary("env","test","team","platform");
            createStr = testCase.sm.createSecret( ...
                name          = testCase.secretNameStr, ...
                secretString  = '{"k":"v"}', ...
                tag = doTags, ...
                description   = "created by TestSecretsManagerClient");
            testCase.verifyClass(createStr, 'aws.secretsmanager.model.CreateSecretResponse');
            testCase.secretArnStr = createStr.arn;
            testCase.verifyNotEmpty(testCase.secretArnStr);

            % --- Create a BINARY secret ---
            testCase.secretNameBin = "matlab-ci-sm-bin-" + ts + "-" + rel;
            binPayload = aws.core.model.SdkBytes(uint8(randi([0,255],1,32)));
            createBin = testCase.sm.createSecret( ...
                name          = testCase.secretNameBin, ...
                secretBinary  = binPayload, ...
                description   = "binary secret by TestSecretsManagerClient");
            testCase.verifyClass(createBin, 'aws.secretsmanager.model.CreateSecretResponse');
            testCase.secretArnBin = createBin.arn;
            testCase.verifyNotEmpty(testCase.secretArnBin);
        end
    end

    %% -------------------- Class Teardown --------------------
    methods(TestClassTeardown)
        function cleanupSecrets(testCase)

            dsResponse = testCase.sm.deleteSecret(secretId = testCase.secretArnStr, forceDeleteWithoutRecovery=true);
            testCase.verifyEqual(dsResponse.arn, testCase.secretArnStr);

            dsResponse = testCase.sm.deleteSecret(secretId = testCase.secretArnBin, forceDeleteWithoutRecovery=true);
            testCase.verifyEqual(dsResponse.arn, testCase.secretArnBin);
        end
    end

    %% -------------------- Tests --------------------
    methods(Test, TestTags = {'Unit'})

        function testCreateSecret_BothStringAndBinary_Errors(testCase)
            name = testCase.secretNameStr + "-bad-both";
            payload = aws.core.model.SdkBytes(uint8(1:10));

            f = @() testCase.sm.createSecret( ...
                name          = name, ...
                secretString  = "abc", ...
                secretBinary  = payload, ...
                description   = "invalid both provided");

            % AWS SDK v2 exceptions typically surface as MATLAB:Java:GenericException
            testCase.verifyError(f, 'MATLAB:Java:GenericException');
        end


        function testGetSecretValue_InvalidVersion_Throws_AfterFix(testCase)

            f = @() testCase.sm.getSecretValue( ...
                secretId=testCase.secretArnStr, versionId="ver-does-not-exist");
            testCase.verifyError(f, 'MATLAB:Java:GenericException');
        end

        function testListSecrets_NoArgs_Succeeds(testCase)
            resp = testCase.sm.listSecrets();
            testCase.verifyClass(resp, 'aws.secretsmanager.model.ListSecretsResponse');
            % Not asserting non-empty due to account variance, but usually not empty
        end

        function testListSecrets_WithArgs_Succeeds(testCase)
            % Request pagination-friendly size (1) and an order string.
            resp1 = testCase.sm.listSecrets(maxResults = int32(1), sortOrder = "asc");
            testCase.verifyClass(resp1, 'aws.secretsmanager.model.ListSecretsResponse');

            % If service returned a nextToken, call again to exercise builder w/ token
            if ~isempty(resp1.nextToken)
                resp2 = testCase.sm.listSecrets(nextToken = string(resp1.nextToken), maxResults = int32(1));
                testCase.verifyClass(resp2, 'aws.secretsmanager.model.ListSecretsResponse');
            end
        end

        function testListSecrets_WithArgs_Pagination(tc)
            resp1 = tc.sm.listSecrets(maxResults=int32(1), sortOrder="asc");
            tc.verifyClass(resp1, 'aws.secretsmanager.model.ListSecretsResponse');

            if ~isempty(resp1.nextToken)
                resp2 = tc.sm.listSecrets(nextToken=string(resp1.nextToken), maxResults=int32(1));
                tc.verifyClass(resp2, 'aws.secretsmanager.model.ListSecretsResponse');
            end
        end

        function testUpdateSecret_ByName_Binary_Succeeds(testCase)
            newBytes = aws.core.model.SdkBytes(uint8(200:220));
            resp = testCase.sm.updateSecret( ...
                secretId = testCase.secretArnBin, ...
                secretBinary = newBytes, ...
                clientRequestToken = "req-token-1234-req-token-1234-req-token-1234-req-token-1234");
            testCase.verifyClass(resp, 'aws.secretsmanager.model.UpdateSecretResponse');
        end


        function testUpdateSecret_InvalidclientRequestToken_Throws_AfterFix(testCase)

            newBytes = aws.core.model.SdkBytes(uint8(200:220));
            f = @() testCase.sm.updateSecret( ...
                secretId = testCase.secretArnBin, ...
                secretBinary = newBytes, ...
                clientRequestToken = "req-token-1234");

            testCase.verifyError(f, 'MATLAB:Java:GenericException');
        end

        function testDeleteSecret_CurrentBugExpected(testCase)
            % Implementation references 'secretId' var before defining it.

            bogus = "arn:aws:secretsmanager:us-east-1:111122223333:secret:does-not-exist-abc123";
            f = @() testCase.sm.deleteSecret( ...
                secretId = bogus, ...
                recoveryWindowInDays = double(7));

            testCase.verifyError(f, 'MATLAB:Java:GenericException'); % undefined variable in builder line
        end

        function testRestoreSecret_AfterScheduledDelete_Succeeds(testCase)
            % 1) Schedule deletion with 7-day window
            delResp = testCase.sm.deleteSecret(secretId= testCase.secretArnBin, ...
                recoveryWindowInDays = int64(7));
            testCase.verifyEqual(delResp.arn, testCase.secretArnBin);

            % 2) Call wrapper restoreSecret to bring it back
            resp = testCase.sm.restoreSecret(secretId = testCase.secretNameBin);
            testCase.verifyClass(resp, 'aws.secretsmanager.model.RestoreSecretResponse');
            testCase.verifyNotEmpty(resp.arn);
        end

        function testRestoreSecret_Nonexistent_Throws(tc)
            bogus = "arn:aws:secretsmanager:" + tc.region + ":111122223333:secret:nope-" + char(java.util.UUID.randomUUID());
            f = @() tc.sm.restoreSecret(secretId=bogus);
            tc.verifyError(f, 'MATLAB:Java:GenericException');
        end

    end
end
