function putBucketPolicyResponse = putBucketPolicy(obj, options)
% PUTBUCKETPOLICY Set or replace the bucket policy for an S3 bucket.
%
% Syntax
%   resp = s3.putBucketPolicy(bucket="<bucket>", policy="<json>");
%
% Name-Value Arguments
%   bucket                       - (string, required) Bucket name.
%   policy                       - (string, required) Policy JSON document.
%   confirmRemoveSelfBucketAccess - (logical) Confirm removal of the caller's permissions (default false).
%   expectedBucketOwner          - (string) AWS account ID expected to own the bucket.
%   contentMD5                   - (string) Base64-encoded MD5 checksum of the policy body.
%
% Returns
%   putBucketPolicyResponse - aws.s3.model.PutBucketPolicyResponse containing HTTP status info.
%
% Example
%   s3 = aws.s3.Client();
%   policyStruct = struct("Version","2012-10-17", ...
%       "Statement", struct("Effect","Allow","Principal","*","Action","s3:GetObject", ...
%       "Resource","arn:aws:s3:::my-bucket/*"));
%   resp = s3.putBucketPolicy(bucket="my-bucket", policy=jsonencode(policyStruct));

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.policy (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.confirmRemoveSelfBucketAccess (1,1) logical
    options.expectedBucketOwner (1,1) string {mustBeTextScalar}
    options.contentMD5 (1,1) string {mustBeTextScalar}
end

write(obj.logObj, 'info', 'Setting bucket policy in Simple Storage Service');

% Create a put bucket policy request builder
putBucketPolicyRequestBuilder = software.amazon.awssdk.services.s3.model.PutBucketPolicyRequest.builder();
putBucketPolicyRequest = aws.internal.builder.build(putBucketPolicyRequestBuilder, options);

% Call the putBucketPolicy method from the AWS SDK
responseJ = obj.Handle.putBucketPolicy(putBucketPolicyRequest);

% Wrap the Java response in a MATLAB PutBucketPolicyResponse object
putBucketPolicyResponse = aws.s3.model.PutBucketPolicyResponse(responseJ);
write(obj.logObj, 'info', 'Set bucket policy in Simple Storage Service');

end
