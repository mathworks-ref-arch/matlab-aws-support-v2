classdef TestS3TransferManager < matlab.unittest.TestCase
    % TESTS3TRANSFERMANAGER Integration tests for aws.s3.transfer.TransferManager
    %
    %   - Per-test ephemeral bucket in TestMethodSetup
    %   - Cleanup in TestMethodTeardown
    %
    % Tags: Unit, TransferManager

    % Copyright 2025 The MathWorks, Inc.

    properties
        logObj
        s3                  % aws.s3.Client (for bucket mgmt and validations)
        tm                  % aws.s3.transfer.TransferManager
        isOnGitlab logical
        bucketName string
        tmpRoot string
        endpointOverride (1,1) string = ""
    end

    properties (Constant)
        Region = "us-east-1"                % align with your S3 test
        % Default file size for single-file tests (MB). Can be overridden via env.
        DefaultFileSizeMB = TestS3TransferManager.getenvNum('AWSS3_TEST_FILE_MB', 10)
    end

    %% Test Class Setup
    methods (TestClassSetup)
        function testSetup(testCase)
            testCase.logObj = Logger.getLogger();
            testCase.logObj.DisplayLogLevel = 'verbose';
        end
        function checkGitlab(testCase)
            host = getenv('CI_RUNNER_DESCRIPTION');
            testCase.isOnGitlab = ~isempty(host);
            write(testCase.logObj, 'verbose', "CI detection (GitLab): " + string(testCase.isOnGitlab));
        end
        function loadEndpointOverride(testCase)
            eo = strtrim(getenv('S3_ENDPOINT_OVERRIDE'));
            if ~isempty(eo)
                testCase.endpointOverride = string(eo);
            else
                testCase.endpointOverride = "https://s3.us-east-1.amazonaws.com";
            end
        end

        function initializeClients(testCase)
            % Initialize S3 client and TransferManager.
            % Use session credentials if on CI.
            region = char(testCase.Region);
            if testCase.isOnGitlab
                creds = loadConfigurationSettings('credentials.json');
                cp = aws.auth.CredentialProvider.getSessionCredentialProvider( ...
                    creds.aws_access_key_id, creds.aws_secret_access_key, ...
                    creds.aws_session_token);
                testCase.s3 = aws.s3.Client('credentialsprovider', cp, 'region', region, 'isCrt', true);
                testCase.tm = aws.s3.transfer.TransferManager('credentialsprovider', cp, ...
                    'region', region, 'endpointOverride', testCase.endpointOverride);
            else
                testCase.s3 = aws.s3.Client('region', region, 'isCrt', true);
                testCase.tm = aws.s3.transfer.TransferManager('region', region, ...
                    'endpointOverride', testCase.endpointOverride);
            end

            % Sanity: ensure TM is initialized
            testCase.verifyTrue(testCase.tm.InitializeStatus, 'TransferManager did not initialize successfully');
            write(testCase.logObj, 'verbose', 'Initialized S3 Client and TransferManager.');
        end

        function createS3Bucket(testCase)
            % Fresh unique bucket per test
            testCase.bucketName = "matlab-s3test-bucket-" + string(datetime('now','Format','yyyyMMddHHmmssSSS'));
            resp = testCase.s3.createBucket(bucket=testCase.bucketName);
            testCase.verifyNotEmpty(resp.location, 'Bucket location should not be empty after creation.');
            write(testCase.logObj, 'verbose', "Created bucket: " + testCase.bucketName);

            % Create an isolated temp folder for this test
            fix = testCase.applyFixture(matlab.unittest.fixtures.TemporaryFolderFixture);
            testCase.tmpRoot = string(fix.Folder);
        end
    end

    %% Test Method Setup / Teardown

    methods (TestClassTeardown)
        function deleteTestBucket(testCase)

            listObjectResponse = testCase.s3.listObjects(bucket=testCase.bucketName);

            delResp = testCase.s3.deleteObjects( ...
                bucket = testCase.bucketName, ...
                objects = listObjectResponse.s3Objects);
            testCase.verifyTrue(delResp.hasDeleted, "Bulk Object delete Failed.");
            testCase.verifyFalse(delResp.hasErrors, "Bulk Object delete Failed.");

            % Finally delete the (now-empty) bucket
            del = testCase.s3.deleteBucket(bucket=testCase.bucketName);
            testCase.verifyEqual(del.status, "Success", ...
                "Bucket delete did not report Success.");
            write(testCase.logObj, 'verbose', "Deleted bucket: " + testCase.bucketName);
        end
    end

    %% Tests
    methods (Test, TestTags = {'Unit','TransferManager'})
        function testInitialization(testCase)
            testCase.verifyTrue(testCase.tm.InitializeStatus, 'TransferManager did not initialize successfully');
        end

        function testUpload(testCase)
            key = "tmtest/" + TestS3TransferManager.uuid() + ".bin";
            src = fullfile(testCase.tmpRoot, 'uploadSrc.bin');
            TestS3TransferManager.createRandomFile(src, testCase.DefaultFileSizeMB * 1024^2);

            up = testCase.tm.uploadFile(bucket=testCase.bucketName, key=key, file=src);
            testCase.verifyTrue(up.status, 'Upload failed');
            write(testCase.logObj, 'verbose', "Uploaded: " + key);

            % Verify object exists
            [~, exists] = testCase.s3.headObject(bucket=testCase.bucketName, key=key);
            testCase.verifyTrue(exists, 'Uploaded object not found by headObject');

        end

        function testDownload(testCase)
            % Arrange: ensure object exists
            key = "tmtest/" + TestS3TransferManager.uuid() + ".bin";
            src = fullfile(testCase.tmpRoot, 'downloadSrc.bin');
            dst = fullfile(testCase.tmpRoot, 'downloadDst.bin');

            TestS3TransferManager.createRandomFile(src, testCase.DefaultFileSizeMB * 1024^2);

            up = testCase.tm.uploadFile(bucket=testCase.bucketName, key=key, file=src);
            testCase.verifyTrue(up.status, 'Upload (precondition) failed');

            % Act: download
            down = testCase.tm.downloadFile(bucket=testCase.bucketName, key=key, file=dst);
            testCase.verifyTrue(down.status, 'Download failed');

            % Assert: content identical
            testCase.verifyEqual(TestS3TransferManager.fileSize(dst), TestS3TransferManager.fileSize(src), ...
                'Downloaded file size does not match uploaded file');
            testCase.verifyTrue(TestS3TransferManager.filesEqual(src,dst), ...
                'Downloaded file contents do not match uploaded file');
        end

        function testCopy(testCase)
            % Create src object in this test's bucket
            srcKey = "tmcopy/" + TestS3TransferManager.uuid() + ".bin";
            srcFile = fullfile(testCase.tmpRoot, 'copySrc.bin');
            TestS3TransferManager.createRandomFile(srcFile, 2 * 1024^2);
            up = testCase.tm.uploadFile(bucket=testCase.bucketName, key=srcKey, file=srcFile);
            testCase.verifyTrue(up.status, 'Upload (precondition) failed');

            % Create a destination bucket just for this test
            destBucket = "matlab-s3test-bucket-" + string(datetime('now','Format','yyyyMMddHHmmssSSS')) + "-dst";
            cbr = testCase.s3.createBucket(bucket=destBucket);
            testCase.verifyNotEmpty(cbr.location, 'Destination bucket creation failed');
            write(testCase.logObj, 'verbose', "Created destination bucket: " + destBucket);

            % Copy
            destKey = "tmcopy/" + TestS3TransferManager.uuid() + ".bin";
            cp = testCase.tm.copy( ...
                sourceBucket=testCase.bucketName, sourceKey=srcKey, ...
                destinationBucket=destBucket, destinationKey=destKey);
            testCase.verifyTrue(cp.status, 'Copy failed');

            % Verify copy exists
            [~, exists] = testCase.s3.headObject(bucket=destBucket, key=destKey);
            testCase.verifyTrue(exists, 'Destination object not found after copy');

            % Cleanup dest bucket immediately (objects then bucket)
            try
                testCase.s3.deleteObject(bucket=destBucket, key=destKey);
            catch
                % best effort only
            end
            delDst = testCase.s3.deleteBucket(bucket=destBucket);
            testCase.verifyEqual(string(delDst.status), "Success", 'Destination bucket delete failed');
        end

        function testUploadDirectory(testCase)
            % Create local source tree
            srcDir = fullfile(testCase.tmpRoot, 'srcDir');
            mkdir(srcDir);
            mkdir(fullfile(srcDir,'sub'));

            TestS3TransferManager.createRandomFile(fullfile(srcDir,'a.bin'), 512*1024);
            TestS3TransferManager.createRandomFile(fullfile(srcDir,'sub','b.bin'), 256*1024);

            prefix = "dirtest/" + TestS3TransferManager.uuid();

            res = testCase.tm.uploadDirectory(bucket=testCase.bucketName, sourceDir=srcDir, prefix=prefix);
            testCase.verifyTrue(res.status, "Upload Directory Failed");
        end

        function testDownloadDirectory(testCase)
            % Arrange: build a local source, upload, then download & compare
            srcDir = fullfile(testCase.tmpRoot, 'srcTree');
            dstDir = fullfile(testCase.tmpRoot, 'dstTree');
            mkdir(srcDir); mkdir(fullfile(srcDir,'sub'));
            TestS3TransferManager.createRandomFile(fullfile(srcDir,'x.bin'), 400*1024);
            TestS3TransferManager.createRandomFile(fullfile(srcDir,'sub','y.bin'), 300*1024);

            prefix = "dirtest/" + TestS3TransferManager.uuid();

            up = testCase.tm.uploadDirectory(bucket=testCase.bucketName, sourceDir=srcDir, prefix=prefix);
            testCase.verifyTrue(up.status, "Upload Directory Failed");

            down = testCase.tm.downloadDirectory(bucket=testCase.bucketName, targetDir=dstDir, prefix=prefix);
            testCase.verifyTrue(down.status, "Download Directory Failed");

            % Compare
            dstBase = TestS3TransferManager.expectedDownloadBase(dstDir, prefix);
            TestS3TransferManager.verifyTreesEqual(testCase, srcDir, dstBase);
        end
    end

    %% Helpers (static)
    methods (Static, Access=private)
        function n = getenvNum(name, defaultNum)
            v = getenv(name);
            if isempty(v), n = defaultNum; else, n = str2double(v); end
            if isnan(n) || n <= 0, n = defaultNum; end
        end

        function u = uuid()
            u = char(java.util.UUID.randomUUID);
        end

        function createRandomFile(filePath, nBytes)
            % Streaming binary writer to control size without big memory spikes
            fid = fopen(filePath, 'Wb');
            assert(fid > 0, "Failed to open file for writing: " + filePath);
            c = onCleanup(@() fclose(fid));

            chunk = 8*1024*1024; % 8 MB
            left = nBytes;
            while left > 0
                m = min(left, chunk);
                buf = randi([0,255], 1, m, 'uint8');
                fwrite(fid, buf, 'uint8');
                left = left - m;
            end
        end

        function n = fileSize(filePath)
            d = dir(filePath);
            assert(~isempty(d), "File not found: " + filePath);
            n = d.bytes;
        end

        function tf = filesEqual(a, b)
            if TestS3TransferManager.fileSize(a) ~= TestS3TransferManager.fileSize(b)
                tf = false; return;
            end
            fa = fopen(a,'rb'); fb = fopen(b,'rb');
            assert(fa>0 && fb>0, 'Failed to open files for comparison.');
            ca = onCleanup(@() fclose(fa)); cb = onCleanup(@() fclose(fb));
            chunk = 4*1024*1024;
            tf = true;
            while true
                ba = fread(fa, chunk, '*uint8');
                bb = fread(fb, chunk, '*uint8');
                if isempty(ba) && isempty(bb), break; end
                if ~isequal(ba, bb), tf = false; break; end
            end
        end

        function keys = localDirKeys(localRoot, prefix)
            files = dir(fullfile(localRoot, '**', '*'));
            files = files(~[files.isdir]);
            keys = strings(numel(files),1);
            for idx = 1:numel(files)
                rel = erase(string(fullfile(files(idx).folder, files(idx).name)), string(localRoot) + filesep);
                rel = strrep(rel, filesep, '/'); % S3 uses forward slashes
                keys(idx) = prefix + "/" + rel;
            end
        end

        function base = expectedDownloadBase(dstDir, prefix)
            % Heuristic: if a folder with the prefix exists directly under dstDir,
            % then the download included the prefix folder.
            % Normalize prefix → folder name (first segment is usually enough).
            p = char(prefix);
            if contains(p, "/"); pTop = extractBefore(p, "/"); else; pTop = p; end
            if isfolder(fullfile(dstDir, pTop))
                base = fullfile(dstDir, p);  % Behavior B: includes prefix
                % Normalize possible nested dirs for multi-segment prefix
                base = strrep(base, '/', filesep);
            else
                base = dstDir;               % Behavior A: no prefix top folder
            end
        end

        function verifyTreesEqual(testCase, src, dst)
            srcFiles = dir(fullfile(src,'**','*'));
            srcFiles = srcFiles(~[srcFiles.isdir]);
            for f = srcFiles'
                rel = erase(string(fullfile(f.folder, f.name)), string(src) + filesep);
                tgt = fullfile(dst, rel);
                testCase.assertTrue(isfile(tgt), "Missing file after download: " + tgt);
                testCase.verifyEqual(TestS3TransferManager.fileSize(tgt), f.bytes, ...
                    "Size mismatch for: " + tgt);
                testCase.verifyTrue(TestS3TransferManager.filesEqual(fullfile(f.folder, f.name), tgt), ...
                    "Content mismatch for: " + tgt);
            end
        end
    end
end

