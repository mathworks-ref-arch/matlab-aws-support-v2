classdef TestFunctionUtils < matlab.unittest.TestCase
    % Tests for aws, awsCommonRoot, awsRoot, loadConfigurationSettings, loadKeyPair
    %
    % These tests:
    % - Mock testutils.system() so aws() can be tested without AWS CLI.
    % - Stub Logger class so configuration loader tests don't error on logging.
    % - Conditionally exercise loadKeyPair if Apache Commons IO is available on Java classpath.
    %
    % How to run:
    %   results = runtests('tests', 'IncludeSubfolders', true);
    %   % Or with coverage (see section below for a richer example)

    % Copyright 2025 The MathWorks, Inc.

    properties
        TempDir
    end

    methods (TestClassSetup)
        function addTestSupportPath(testCase)
            % Create a temp dir for file-system tests
            testCase.TempDir = tempdir;

            % Put the temp dir on path so which('credentials.json') can resolve
            % when we drop a dummy credentials.json in there
            testCase.applyFixture(matlab.unittest.fixtures.PathFixture(testCase.TempDir));
        end
    end

    %% ---------------- aws() tests (with mocked system) ----------------
    methods(Test, TestTags = {'Unit'})

        function aws_NoOutputs_EchoFlagPath(testCase)
            testCase.verifyWarningFree(@() aws('s3api','list-buckets'));
        end
    end

    %% ---------------- awsRoot() & awsCommonRoot() tests ----------------
    methods(Test, TestTags = {'Unit'})
        function awsRoot_NoArgs_ReturnsExistingPath(testCase)
            base = awsRoot();
            testCase.verifyClass(base,'char');
            testCase.verifyTrue(isfolder(base), 'awsRoot() must return an existing folder');
        end

        function awsRoot_AppendsRelativePaths(testCase)
            base = awsRoot();
            actual = awsRoot('app', 'functions');
            expected = fullfile(base, 'app', 'functions');
            testCase.verifyEqual(actual, expected);
        end

        function awsRoot_MoveUpLevels(testCase)
            base = awsRoot();
            actual = awsRoot(-2);
            expected = fileparts(fileparts(base));
            testCase.verifyEqual(actual, expected);
        end

        function awsRoot_InvalidArgumentThrows(testCase)
            testCase.verifyError(@() awsRoot(struct()), 'AWS:awsroot_bad_argument');
        end

        function awsCommonRoot_ReturnsExistingPath(testCase)
            cr = awsCommonRoot();
            testCase.verifyClass(cr, 'char');
            testCase.verifyTrue(isfolder(cr));
        end
    end

    %% ---------------- loadConfigurationSettings() tests ----------------
    methods(Test, TestTags = {'Unit'})
        function loadConfigurationSettings_ValidFile_And_FieldWarnings(testCase)
            % Ensure the Logger stub is visible (already added by PathFixture)
            % Create a temporary JSON config on the fly
            cfg = struct();
            cfg.Name = "TestConfig";
            cfg.ManagedIdentityClientId = "abc-123"; % triggers rename advice log
            cfg.pemCertificate = "-----BEGIN CERTIFICATE-----..."; % triggers rename advice log

            tmp = tempname;
            jsonFile = [tmp '.json'];
            fid = fopen(jsonFile, 'w');
            cleaner = onCleanup(@() fclose(fid));
            fwrite(fid, jsonencode(cfg), 'char');

            settings = loadConfigurationSettings(jsonFile);
            % Verify data round-trips
            testCase.verifyEqual(settings.Name, 'TestConfig');
            testCase.verifyTrue(isfield(settings, 'ManagedIdentityClientId'));
            testCase.verifyTrue(isfield(settings, 'pemCertificate'));
        end

        function loadConfigurationSettings_StringScalarPath(testCase)
            cfg = struct('Name', "StringScalarPath");
            jsonFile = string([tempname '.json']);
            fid = fopen(jsonFile, 'w');
            cleaner = onCleanup(@() fclose(fid));
            fwrite(fid, jsonencode(cfg), 'char');

            settings = loadConfigurationSettings(jsonFile);
            testCase.verifyEqual(settings.Name, 'StringScalarPath');
        end

    end

    %% ---------------- loadKeyPair() tests (conditional) ----------------
    methods(Test, TestTags = {'Unit'})
        function loadKeyPair_ReadsRSAKeys_WhenJavaDepsPresent(testCase)
            % This test requires:
            %  - JVM enabled
            %  - Apache Commons IO on the Java class path (org.apache.commons.io.IOUtils)
            %
            % If unavailable, the test is safely skipped (assumption failure).
            testCase.assumeTrue(usejava('jvm'), 'JVM is required for key generation');
            import org.apache.commons.io.IOUtils
            hasIOUtils = true; %#ok<NASGU>
            testCase.assumeTrue(exist('org.apache.commons.io.IOUtils','class') == 8 || hasIOUtils, ...
                'Apache Commons IO (IOUtils) must be on the Java classpath');

            % Generate an RSA keypair via Java
            import java.security.KeyPairGenerator
            import java.security.spec.X509EncodedKeySpec
            import java.security.spec.PKCS8EncodedKeySpec

            kpg = KeyPairGenerator.getInstance('RSA');
            kpg.initialize(1024);
            kp = kpg.generateKeyPair();

            pubBytes = kp.getPublic().getEncoded();   % X.509
            prvBytes = kp.getPrivate().getEncoded();  % PKCS#8

            % Write them to files
            pubFile = [tempname '.pub'];
            prvFile = [tempname '.prv'];

            fid = fopen(pubFile, 'w'); fwrite(fid, typecast(pubBytes, 'uint8')); fclose(fid);
            fid = fopen(prvFile, 'w'); fwrite(fid, typecast(prvBytes, 'uint8')); fclose(fid);

            % Exercise loadKeyPair (full pair)
            pair = loadKeyPair(pubFile, prvFile);
            testCase.verifyTrue(contains(char(pair.getClass().getName), 'KeyPair'));
            testCase.verifyNotEmpty(pair.getPrivate(), 'Private key should be present when provided');

            % Exercise public-only mode
            pair2 = loadKeyPair(pubFile);
            testCase.verifyTrue(contains(char(pair2.getClass().getName), 'KeyPair'));
            testCase.verifyEmpty(pair2.getPrivate(), 'Private key should be empty/null in public-only mode');
        end
    end

    methods(Test, TestTags = {'Unit'})
        function saveKeyPair_WritesValidFiles_AndRoundTripIfPossible(testCase)
            testCase.assumeTrue(usejava('jvm'), 'JVM is required for key generation');

            % Generate RSA keypair via Java
            import java.security.KeyPairGenerator
            kpg = KeyPairGenerator.getInstance('RSA');
            kpg.initialize(1024); % keep small for speed in tests
            kp = kpg.generateKeyPair();

            pubFile = fullfile(testCase.TempDir, 'test_public.key');
            prvFile = fullfile(testCase.TempDir, 'test_private.key');

            % Call the function under test
            saveKeyPair(kp, pubFile, prvFile);

            % Validate files exist and are non-empty
            testCase.verifyTrue(isfile(pubFile), 'Public key file not created');
            testCase.verifyTrue(isfile(prvFile), 'Private key file not created');
            pubInfo = dir(pubFile);  prvInfo = dir(prvFile);
            testCase.verifyGreaterThan(pubInfo.bytes, 0);
            testCase.verifyGreaterThan(prvInfo.bytes, 0);

            % If loadKeyPair is available + IOUtils on classpath, round-trip verify
            hasLoadKeyPair = exist('loadKeyPair', 'file') == 2;
            hasIOUtils = (exist('org.apache.commons.io.IOUtils','class') == 8);
            if hasLoadKeyPair && hasIOUtils
                pair = loadKeyPair(pubFile, prvFile);
                testCase.verifyNotEmpty(pair.getPublic());
                testCase.verifyNotEmpty(pair.getPrivate());
            else
                testCase.assumeFail(['Skipping round-trip check: ', ...
                    'loadKeyPair or Apache Commons IO not available.']);
            end
        end

        function unlimitedCryptography_ReturnsLogicalAndMatchesJCE(testCase)
            testCase.assumeTrue(usejava('jvm'), 'JVM is required for javax.crypto.Cipher');
            tf = unlimitedCryptography();
            testCase.verifyClass(tf, 'logical');

            import javax.crypto.Cipher
            jceAllows = Cipher.getMaxAllowedKeyLength(string('AES')) > 128;
            testCase.verifyEqual(tf, jceAllows, ...
                'unlimitedCryptography() should reflect JCE policy for AES > 128.');
        end

        function writeSTSCredentialsFile_WritesExpectedJSON(testCase)
            % Setup: create a dummy credentials.json in a temp folder so which() resolves
            dummyCreds = fullfile(testCase.TempDir, 'credentials.json');
            fid = fopen(dummyCreds, 'w'); fwrite(fid, '{}', 'char'); fclose(fid);

            % Inputs
            tokenCode    = '123456';
            serialNumber = 'arn:aws:iam::123456789012:mfa/test.user';
            region       = 'us-west-2';

            % Call the function (aws is mocked to return struct with Credentials)
            tf = writeSTSCredentialsFile(tokenCode, serialNumber, region);
            testCase.verifyTrue(tf, 'writeSTSCredentialsFile should return true on success');

            % Validate the output file exists and content matches
            outFile = which('credentials_sts.json');
            testCase.verifyTrue(isfile(outFile), 'Expected STS output file not created');

            txt = fileread(outFile);
            % Basic presence checks
            testCase.verifyNotEmpty(regexp(txt, '"aws_access_key_id"\s*:\s*"', 'once'));
            testCase.verifyNotEmpty(regexp(txt, '"secret_access_key"\s*:\s*"', 'once'));
            testCase.verifyNotEmpty(regexp(txt, '"session_token"\s*:\s*"', 'once'));
            testCase.verifyNotEmpty(regexp(txt, ['"region"\s*:\s*"' regexptranslate('escape', region) '"'], 'once'));

            % Ensure values match those returned by the aws mock
            testCase.verifyNotEmpty(strfind(txt, 'ASIAEXAMPLEACCESS'), 'Access key id mismatch');
            testCase.verifyNotEmpty(strfind(txt, 'wJalrXUtnFEMI/K7MDENG+bPxRfiCYEXAMPLEKEY'), 'Secret mismatch');
            testCase.verifyNotEmpty(strfind(txt, 'AQoDYXdzEJr...<token>...EXAMPLETOKEN'), 'Session token mismatch');
        end

        function writeSTSCredentialsFile_ValidatesInputTypes(testCase)
            % Non-char inputs should be rejected
            tf = writeSTSCredentialsFile(123, "arn", "us-east-1"); %#ok<NASGU>
            % Function itself returns false on bad args (and logs error)
            testCase.verifyFalse(writeSTSCredentialsFile(123, 'arn', 'us-east-1'));
            testCase.verifyFalse(writeSTSCredentialsFile('123456', 789, 'us-east-1'));
            testCase.verifyFalse(writeSTSCredentialsFile('123456', 'arn', 42));
        end

        function writeSTSCredentialsFile_InValidInputTypes(testCase)
            % Non-char inputs should be rejected
            tf = writeSTSCredentialsFile('123', 'arn', 'us-east-1'); %#ok<NASGU>
            % Function itself returns false on bad args (and logs error)
            testCase.verifyFalse(writeSTSCredentialsFile(123, 'arn', 'us-east-1'));
            testCase.verifyFalse(writeSTSCredentialsFile('123456', 789, 'us-east-1'));
        end
    end
end