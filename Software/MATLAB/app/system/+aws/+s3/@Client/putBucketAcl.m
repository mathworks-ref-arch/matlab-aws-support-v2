function putBucketAclResponse = putBucketAcl(obj, options)
% PUTBUCKETACL Configure the ACL for an S3 bucket.
%
% Syntax
%   resp = s3.putBucketAcl(bucket="<name>", acl="public-read");
%   resp = s3.putBucketAcl(bucket="<name>", accessControlPolicy=policyObj);
%
% Name-Value Arguments
%   bucket              - (string, required) Bucket name.
%   acl                 - (string) Canned ACL (for example, "private").
%   accessControlPolicy - (aws.s3.model.AccessControlPolicy) Explicit ACL grants/owner.
%   grantFullControl    - (string) Grant header string.
%   grantRead           - (string) Grant header string.
%   grantReadACP        - (string) Grant header string.
%   grantWrite          - (string) Grant header string.
%   grantWriteACP       - (string) Grant header string.
%   contentMD5          - (string) Base64-encoded MD5 of the ACL payload.
%   expectedBucketOwner - (string) AWS account ID expected to own the bucket.
%
% Returns
%   putBucketAclResponse - aws.s3.model.PutBucketAclResponse containing HTTP status info.
%
% Example
%   s3 = aws.s3.Client();
%   resp = s3.putBucketAcl(bucket="my-bucket", acl="public-read");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.acl string
    options.accessControlPolicy aws.s3.model.AccessControlPolicy
    options.grantFullControl string
    options.grantRead string
    options.grantReadACP string
    options.grantWrite string
    options.grantWriteACP string
    options.contentMD5 string
    options.expectedBucketOwner string
end

write(obj.logObj, 'info', 'Setting bucket ACL in Simple Storage Service');

% Create a put bucket ACL request builder
putBucketAclRequestBuilder = software.amazon.awssdk.services.s3.model.PutBucketAclRequest.builder();
putBucketAclRequest = aws.internal.builder.build(putBucketAclRequestBuilder, options);

% Call the putBucketAcl method from the AWS SDK
responseJ = obj.Handle.putBucketAcl(putBucketAclRequest);

% Wrap the Java response in a MATLAB PutBucketAclResponse object
putBucketAclResponse = aws.s3.model.PutBucketAclResponse(responseJ);
write(obj.logObj, 'info', 'Set bucket ACL in Simple Storage Service');

end
