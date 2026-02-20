classdef TestS3CrtClient < matlab.unittest.TestCase
    % TESTS3CLIENT Unit Test for the Amazon S3 Client
    %
    % The assertions that you can use in test cases:
    %
    %    verifyClass
    %    verifyNotEmpty
    %    verifyEqual
    %
    % The test suite exercises the basic operations on the S3 Client.

    % Copyright 2025 The MathWorks, Inc.

    properties
        logObj
        s3Crt
        isOnGitlab
        bucketName
    end

    methods(TestClassSetup)
        % Shared setup for the entire test class
        function testSetup(testCase)
            testCase.logObj = Logger.getLogger();
            testCase.logObj.DisplayLogLevel = 'verbose';
        end

        function checkGitlab(testCase)
            host = getenv('CI_RUNNER_DESCRIPTION');
            testCase.isOnGitlab = ~isempty(host);
        end

        function initializeS3Client(testCase)
            region = 'us-east-1';
            if testCase.isOnGitlab
                credentials = loadConfigurationSettings('credentials.json');
                credentialProvider = aws.auth.CredentialProvider.getSessionCredentialProvider(...
                    credentials.aws_access_key_id, credentials.aws_secret_access_key, ...
                    credentials.aws_session_token);
                testCase.s3Crt = aws.s3.Client('credentialsprovider', credentialProvider, ...
                    'region', region, 'isCrt', true);
            else
                testCase.s3Crt = aws.s3.Client('region', region, 'isCrt', true);
            end
        end
    end

    methods(TestMethodSetup)
        function createS3Bucket(testCase)
            % Create a test bucket and store its name
            testCase.bucketName = strcat("matlab-s3test-bucket-", ...
                string(datetime('now', 'Format', 'yyyyMMddHHmmssSSS')));
            createBucketResponse = testCase.s3Crt.createBucket(bucket=testCase.bucketName);
            testCase.verifyNotEmpty(createBucketResponse.location, 'Bucket location should not be empty after creation.');
        end
    end

    methods(TestMethodTeardown)
        function deleteTestBucket(testCase)
            % To-Do Delete Objects in test bucket
            %
            % Delete the test bucket after tests
            deleteBucketResponse = testCase.s3Crt.deleteBucket(bucket=testCase.bucketName);
            % Delete bucket retun 204 for successful deletion request
            testCase.verifyEqual(deleteBucketResponse.status, "Success");
        end
    end

    methods(Test, TestTags = {'Unit'})

        function testListBuckets(testCase)
            % Test listing S3 buckets
            listBucketsResponse = testCase.s3Crt.listBuckets();
            buckets = listBucketsResponse.buckets;
            testCase.verifyNotEmpty(buckets, "Bucket list should not be empty.");
            write(testCase.logObj, "verbose", "Buckets listed successfully.");
        end

        function testDeleteNonExistentBucket(testCase)
            % Test deleting a non-existent bucket
            nonExistentBucketName = 'non-existent-bucket';
            try
                testCase.s3Crt.deleteBucket(bucketName=nonExistentBucketName);
                testCase.verifyFail('Expected an error when deleting a non-existent bucket.');
            catch
                write(testCase.logObj, 'verbose', 'Caught expected error for non-existent bucket deletion.');
            end
        end
    end

    methods(Test, TestTags = {'Unit', 'Object'})

        function testObject(testCase)
            % Put Object
            requestBody = aws.core.model.RequestBody("I am here to upload xxx");
            putObjectResponse = testCase.s3Crt.putObject(bucket=testCase.bucketName, key="hello2.txt",body=requestBody);
            testCase.verifyNotEmpty(putObjectResponse.eTag);

            % Get Object
            [getObjectResponse, inputStream] = testCase.s3Crt.getObject(bucket=testCase.bucketName,key="hello2.txt");
            testCase.verifyNotEmpty(getObjectResponse.eTag);
            write(testCase.logObj,"verbose",inputStream);
            % Save the inputStream to a file
            localFile = "C:\\Temp\\file1.txt";
            testCase.s3Crt.saveS3ResponseInputStreamToFile(inputStream,localFile);

            %Head Object to test an object exists
            [~,doesExist] = testCase.s3Crt.headObject(bucket=testCase.bucketName,key="hello2.txt");
            testCase.verifyTrue(doesExist);

            % List object from the bucket
            listObjectResponse = testCase.s3Crt.listObjects(bucket=testCase.bucketName);
            testCase.verifyEqual(listObjectResponse.name, testCase.bucketName);

            % Copy object
            copyObjectResponse = testCase.s3Crt.copyObject(sourceBucket=testCase.bucketName, sourceKey="hello2.txt",destinationBucket="matlab-s3test-bucket-20250826224322515",destinationKey="hello2Copy.txt");
            testCase.verifyNotEmpty(copyObjectResponse.eTag,"Not copied");


            % Delete Object
            deleteObjectResponse = testCase.s3Crt.deleteObject(bucket=testCase.bucketName,key="hello2.txt");
            testCase.verifyNotEmpty(deleteObjectResponse);

        end

    end

end