function createBucketResponse = createBucket(obj, options)
% CREATEBUCKET Create a new Amazon S3 bucket.
%
% Syntax
%   resp = s3.createBucket(bucket="<name>");
%   resp = s3.createBucket(bucket="<name>", createBucketConfiguration=myCfg);
%
% Name-Value Arguments
%   bucket                    - (string, required) Bucket name.
%   acl                       - (string) Canned ACL to apply (for example, "private").
%   createBucketConfiguration - (aws.s3.model.CreateBucketConfiguration | struct | dictionary)
%                               Region configuration passed to the AWS SDK builder.
%
% Returns
%   createBucketResponse - aws.s3.model.CreateBucketResponse containing bucket metadata.
%
% Example
%   s3 = aws.s3.Client();
%   resp = s3.createBucket(bucket="matlab-demo-bucket");
%   cfg = aws.s3.model.CreateBucketConfiguration(locationConstraint="us-west-2");
%   resp = s3.createBucket(bucket="matlab-demo-west", createBucketConfiguration=cfg);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.acl string  % Optional
    options.createBucketConfiguration % Optional
end

write(obj.logObj, 'info', 'Creating Bucket in Simple Storage Service');

% Create a bucket request builder
createBucketRequestBuilder = software.amazon.awssdk.services.s3.model.CreateBucketRequest.builder();
% Build the request
createBucketRequest = aws.internal.builder.build(createBucketRequestBuilder,options);

% Call the createBucket method from the AWS SDK
responseJ = obj.Handle.createBucket(createBucketRequest);

% Wrap the Java response in a MATLAB CreateBucketResponse object
createBucketResponse = aws.s3.model.CreateBucketResponse(responseJ);
write(obj.logObj, 'info', 'Created Bucket in Simple Storage Service');

end
