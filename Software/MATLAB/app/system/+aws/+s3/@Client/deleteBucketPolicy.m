function deleteBucketPolicyResponse = deleteBucketPolicy(obj, options)
% DELETEBUCKETPOLICY Remove the bucket policy attached to an S3 bucket.
%
% Syntax
%   resp = s3.deleteBucketPolicy(bucket="<bucket>");
%
% Name-Value Arguments
%   bucket              - (string, required) Bucket name.
%   expectedBucketOwner - (string) AWS account ID you expect to own the bucket.
%
% Returns
%   deleteBucketPolicyResponse - aws.s3.model.DeleteBucketPolicyResponse containing HTTP status info.
%
% Example
%   s3 = aws.s3.Client();
%   resp = s3.deleteBucketPolicy(bucket="my-bucket");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    % Optional fields supported by AWS SDK v2 request:
    % expectedBucketOwner is a common one; add others if your builder supports them
    options.expectedBucketOwner (0,1) string {mustBeTextScalar}
end

write(obj.logObj, 'info', 'Deleting bucket policy in Simple Storage Service');

% Create a DeleteBucketPolicyRequest builder
deleteBucketPolicyRequestBuilder = ...
    software.amazon.awssdk.services.s3.model.DeleteBucketPolicyRequest.builder();

% Build request via your internal builder helper.
% The helper should ignore empty optional fields gracefully.
deleteBucketPolicyRequest = aws.internal.builder.build( ...
    deleteBucketPolicyRequestBuilder, options);

% Invoke the SDK
responseJ = obj.Handle.deleteBucketPolicy(deleteBucketPolicyRequest);

% Wrap Java response into MATLAB model
deleteBucketPolicyResponse = aws.s3.model.DeleteBucketPolicyResponse(responseJ);

write(obj.logObj, 'info', 'Deleted bucket policy in Simple Storage Service');

end
