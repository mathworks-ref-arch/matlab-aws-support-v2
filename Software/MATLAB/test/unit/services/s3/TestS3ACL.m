classdef TestS3ACL < matlab.unittest.TestCase
    % TESTS3CLIENT ACL Unit Tests for the Amazon S3 Client

    % Copyright 2025 The MathWorks, Inc.

    properties
        s3client
        bucketAclOn      % OwnershipControls = ObjectWriter (ACLs allowed)
        bucketAclOff     % OwnershipControls = BucketOwnerEnforced (ACLs disabled)
        key
        region
    end

    methods (TestClassSetup)
        function initializeS3Client(testCase)
            % Client
            testCase.s3client = aws.s3.Client();

            % Fresh bucket name
            testCase.bucketAclOn  = "matlab-s3test-acl-on-"  + string(datetime('now','Format','yyyyMMddHHmmssSSS'));
            testCase.bucketAclOff = "matlab-s3test-acl-off-" + string(datetime('now','Format','yyyyMMddHHmmssSSS'));
            testCase.key    = "CI-Test.txt";

            % 1) Create bucket
            createResp = testCase.s3client.createBucket(bucket=testCase.bucketAclOn);
            testCase.verifyTrue(contains(createResp.location, testCase.bucketAclOn), "Bucket Not Created");
            createResp = testCase.s3client.createBucket(bucket=testCase.bucketAclOff);
            testCase.verifyTrue(contains(createResp.location, testCase.bucketAclOff), "Bucket Not Created");

            % 2) ENABLE ACLs on bucket (so GET/PUT ACL operations are allowed)
            % Many accounts default to Object Ownership: BucketOwnerEnforced (ACLs disabled).
            % Switch to BucketOwnerPreferred (or ObjectWriter) to enable ACLs for this test.

            % Set OwnershipControls:
            % 1) ACLs allowed
            testCase.s3client.putBucketOwnershipControls( ...
                bucket = testCase.bucketAclOn, objectOwnership = "ObjectWriter");

            % 2) ACLs disabled
            testCase.s3client.putBucketOwnershipControls( ...
                bucket = testCase.bucketAclOff, objectOwnership = "BucketOwnerEnforced");

            % 3) Put an object so getObjectAcl has something to read
            requestBody = aws.core.model.RequestBody("CI Pipeline Test");

            % Put object into ACL-disabled bucket (existing)
            putObjectResponse = testCase.s3client.putObject( ...
                bucket=testCase.bucketAclOff, key=testCase.key, body=requestBody);
            testCase.verifyNotEmpty(putObjectResponse.eTag, "Failed to put test object (ACL-off).");

            % Put the same object into ACL-enabled bucket (NEW)
            putObjectResponseOn = testCase.s3client.putObject( ...
                bucket=testCase.bucketAclOn, key=testCase.key, body=requestBody);
            testCase.verifyNotEmpty(putObjectResponseOn.eTag, "Failed to put test object (ACL-on).");

        end
    end

    methods (TestClassTeardown)
        function cleanup(testCase)
            % Best-effort cleanup

            % Remove bucket policy if present (avoid policy blocking delete)
            deleteBucketPolicy = testCase.s3client.deleteBucketPolicy(bucket=testCase.bucketAclOff);
            testCase.verifyEqual(deleteBucketPolicy.statusCode, 204);
            deleteBucketPolicy = testCase.s3client.deleteBucketPolicy(bucket=testCase.bucketAclOn);
            testCase.verifyEqual(deleteBucketPolicy.statusCode, 204);

            % Delete the test object(s)
            deleteObjectResponseOff = testCase.s3client.deleteObject( ...
                bucket=testCase.bucketAclOff, key=testCase.key);
            testCase.verifyNotEmpty(deleteObjectResponseOff);

            % Delete the object in ACL-enabled bucket
            deleteObjectResponseOn = testCase.s3client.deleteObject( ...
                bucket=testCase.bucketAclOn, key=testCase.key);
            testCase.verifyNotEmpty(deleteObjectResponseOn);

            % Delete the bucket (after it's empty)
            deleteBucketResponse = testCase.s3client.deleteBucket(bucket=testCase.bucketAclOn);
            testCase.verifyEqual(deleteBucketResponse.status, "Success");
            deleteBucketResponse = testCase.s3client.deleteBucket(bucket=testCase.bucketAclOff);
            testCase.verifyEqual(deleteBucketResponse.status, "Success");

        end
    end

    methods (Test, TestTags={'Unit'})
        function testGrant(testCase)
            % Pure model test; doesn't call AWS
            grantee1 = aws.s3.model.Grantee(struct(id="123", displayName="CITest_Grantee"));
            grant1   = aws.s3.model.Grant(struct(grantee=grantee1, permission="FULL_CONTROL"));
            testCase.verifyEqual(string(grant1.Handle.grantee().id()), "123");
            owner1   = aws.s3.model.Owner(struct(id="456", displayName="Owner"));
            acp      = aws.s3.model.AccessControlPolicy(owner=owner1, grants={grant1});
        end

        function testGetObjectAcl(testCase)
            % Ensure call succeeded before dereferencing
            resp = testCase.s3client.getObjectAcl(bucket=testCase.bucketAclOff, key=testCase.key);
            testCase.verifyNotEmpty(resp.owner.id, "Failed to get object ACL");
        end

        function testGetBucketAcl(testCase)
            resp = testCase.s3client.getBucketAcl(bucket=testCase.bucketAclOff);
            testCase.verifyNotEmpty(resp.owner, "Failed to get bucket ACL");
        end

        function testPutBucketPolicy(testCase)
            % Use correct partition if you're in GovCloud/China; default is "aws"
            part    = "aws";
            policy1 = testCase.buildTlsOnlyBucketPolicy(string(testCase.bucketAclOff), part);

            resp = testCase.s3client.putBucketPolicy(bucket=testCase.bucketAclOff, policy=policy1);
            testCase.verifyEqual(resp.statusCode, 204, ...
                sprintf("Failed update policy (status=%s)", string(resp.statusCode)));
        end

        function testPutBucketAcl_AllowsWhenOwnershipObjectWriter(testCase)
            objResp = testCase.s3client.getObjectAcl(bucket=testCase.bucketAclOff, key=testCase.key);
            testCase.verifyNotEmpty(objResp.owner.id, "Failed to get object ACL");
            grantRead = sprintf('id="%s"', objResp.owner.id);

            resp = testCase.s3client.putBucketAcl( ...
                bucket = testCase.bucketAclOn, ...
                grantRead = grantRead);

            testCase.verifyGreaterThanOrEqual(resp.statusCode, 200);
            testCase.verifyLessThan(resp.statusCode, 300);

            % GET ACL should also work
            acl = testCase.s3client.getBucketAcl(bucket = testCase.bucketAclOn);
            testCase.verifyNotEmpty(acl.owner.id, "Failed to get object ACL");
        end

        function testPutObjectAcl_AllowsWhenOwnershipObjectWriter(testCase)
            % Get the object owner ID from the ACL-disabled bucket's object
            % (any valid canonical user ID will work to construct the grant).
            objResp = testCase.s3client.getObjectAcl( ...
                bucket=testCase.bucketAclOff, key=testCase.key);
            testCase.verifyNotEmpty(objResp.owner.id, "Failed to get object owner id for grant construction.");

            grantRead = sprintf('id="%s"', objResp.owner.id);

            % Apply ACL to the object in the ACL-enabled bucket
            resp = testCase.s3client.putObjectAcl( ...
                bucket = testCase.bucketAclOn, ...
                key    = testCase.key, ...
                grantRead = grantRead);

            testCase.verifyEqual(resp.statusCode, 200);

            % Verify that GET object ACL still works and returns an owner
            acl = testCase.s3client.getObjectAcl(bucket=testCase.bucketAclOn, key=testCase.key);
            testCase.verifyNotEmpty(acl.owner.id, "Failed to get object ACL after putObjectAcl.");
        end

        function testPutObjectAcl_FailsWhenOwnershipBucketOwnerEnforced(testCase)
            % Build a valid grant (reuse owner from the ACL-enabled object)
            objResp = testCase.s3client.getObjectAcl( ...
                bucket=testCase.bucketAclOn, key=testCase.key);
            testCase.verifyNotEmpty(objResp.owner.id, "Failed to get object owner id for grant construction.");

            grantRead = sprintf('id="%s"', objResp.owner.id);

            % Attempt to set ACL on the ACL-disabled bucket's object; should fail
            f = @() testCase.s3client.putObjectAcl( ...
                bucket = testCase.bucketAclOff, ...
                key    = testCase.key, ...
                grantRead = grantRead);

            % Verify an exception is thrown. If your client surfaces a response
            % object with statusCode instead, adapt accordingly.
            testCase.verifyError(f, ?MException); % Use your package-specific identifier if available

            % OPTIONAL: If your client returns a response instead of throwing:
            % resp = testCase.s3client.putObjectAcl( ...
            %     bucket = testCase.bucketAclOff, key = testCase.key, grantRead = grantRead);
            % testCase.verifyGreaterThanOrEqual(resp.statusCode, 400);
            % testCase.verifyLessThan(resp.statusCode, 500);

        end

    end

    methods (Access=private)

        function policyJson = buildTlsOnlyBucketPolicy(~, bucketName, partition)
            arguments
                ~
                bucketName (1,1) string {mustBeTextScalar, mustBeNonempty}
                partition  (1,1) string {mustBeMember(partition, ["aws","aws-us-gov","aws-cn"])} = "aws"
            end
            b = strtrim(lower(bucketName));
            bucketArn  = "arn:" + partition + ":s3:::" + b;
            objectsArn = bucketArn + "/*";
            policyJson = sprintf([ ...
                '{' ...
                '"Version":"2012-10-17",' ...
                '"Statement":[{' ...
                '  "Sid":"RestrictToTLSRequestsOnly",' ...
                '  "Effect":"Deny",' ...
                '  "Action":"s3:*",' ...
                '  "Principal":"*", ' ...
                '  "Resource":["%s","%s"],' ...
                '  "Condition":{"Bool":{"aws:SecureTransport":"false"}}' ...
                '}]' ...
                '}' ], bucketArn, objectsArn);
        end
    end
end