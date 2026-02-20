function deleteBucketResponse = deleteBucket(obj, options)
% DELETEBUCKET Delete an empty Amazon S3 bucket.
%
% Syntax
%   resp = s3.deleteBucket(bucket="<name>");
%
% Name-Value Arguments
%   bucket - (string, required) Bucket name to delete.
%
% Returns
%   deleteBucketResponse - aws.s3.model.DeleteBucketResponse with request metadata.
%
% Example
%   s3 = aws.s3.Client();
%   resp = s3.deleteBucket(bucket="matlab-demo-bucket");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
end

write(obj.logObj, 'info', 'Deleting Bucket in Simple Storage Service');

% Create a delete bucket request builder
deleteBucketRequestBuilder = software.amazon.awssdk.services.s3.model.DeleteBucketRequest.builder();
% Set the bucket name
deleteBucketRequest = aws.internal.builder.build(deleteBucketRequestBuilder,options);

% Call the deleteBucket method from the AWS SDK
responseJ = obj.Handle.deleteBucket(deleteBucketRequest);

% Wrap the Java response in a MATLAB DeleteBucketResponse object
deleteBucketResponse = aws.s3.model.DeleteBucketResponse(responseJ);
write(obj.logObj, 'info', 'Deleted Bucket in Simple Storage Service');

end