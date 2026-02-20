function getBucketLocationResponse = getBucketLocation(obj, options)
% GETBUCKETLOCATION Retrieve the Region constraint for an S3 bucket.
%
% Syntax
%   resp = s3.getBucketLocation(bucket="<name>");
%
% Name-Value Arguments
%   bucket              - (string, required) Bucket whose Region will be returned.
%   expectedBucketOwner - (string) AWS account ID you expect to own the bucket.
%
% Returns
%   getBucketLocationResponse - aws.s3.model.GetBucketLocationResponse exposing the
%                               bucket's regional constraint.
%
% Example
%   s3 = aws.s3.Client();
%   resp = s3.getBucketLocation(bucket="matlab-demo-bucket");
%   disp(resp.locationConstraint);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.expectedBucketOwner (1,1) string {mustBeTextScalar}
end

write(obj.logObj, 'info', 'Retrieving bucket location from Simple Storage Service');

% Build the GetBucketLocationRequest
getBucketLocationRequestBuilder = software.amazon.awssdk.services.s3.model.GetBucketLocationRequest.builder();
getBucketLocationRequest = aws.internal.builder.build(getBucketLocationRequestBuilder, options);

% Call the getBucketLocation method from the AWS SDK
responseJ = obj.Handle.getBucketLocation(getBucketLocationRequest);

% Wrap the Java response in a MATLAB BucketAclResponse object
getBucketLocationResponse = aws.s3.model.GetBucketLocationResponse(responseJ);
write(obj.logObj, 'info', 'Retrieved bucket location from Simple Storage Service');

end
