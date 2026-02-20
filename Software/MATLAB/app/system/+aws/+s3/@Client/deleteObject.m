function deleteObjectResponse = deleteObject(obj, options)
% DELETEOBJECT Remove an object (or version) from Amazon S3.
%
% Syntax
%   resp = s3.deleteObject(bucket="<bucket>", key="<key>");
%   resp = s3.deleteObject(bucket="<bucket>", key="<key>", versionId="abc");
%
% Name-Value Arguments
%   bucket                   - (string, required) Bucket name that owns the object.
%   key                      - (string, required) Object key to delete.
%   versionId                - (string) Explicit version to remove (versioned buckets).
%   mfa                      - (string) MFA token for deleting MFA-protected objects.
%   bypassGovernanceRetention - (logical) Set true to bypass governance retention.
%   requestPayer             - (string) Specify `"requester"` when requester pays.
%   expectedBucketOwner      - (string) AWS account ID expected to own the bucket.
%
% Returns
%   deleteObjectResponse - aws.s3.model.DeleteObjectResponse describing delete marker,
%                          version ID, and request charge state.
%
% Example
%   s3 = aws.s3.Client();
%   resp = s3.deleteObject(bucket="matlab-demo-bucket", key="logs/output.json");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.key (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.versionId string                      % Optional
    options.mfa string                            % Optional
    options.bypassGovernanceRetention (1,1) logical  % Optional
    options.requestPayer string                   % Optional
    options.expectedBucketOwner string            % Optional
end

write(obj.logObj, 'info', 'Deleting Object in Simple Storage Service');

% Create a delete object request builder
deleteObjectRequestBuilder = software.amazon.awssdk.services.s3.model.DeleteObjectRequest.builder();

% Build the request using a generic builder utility
deleteObjectRequest = aws.internal.builder.build(deleteObjectRequestBuilder, options);

% Call the deleteObject method from the AWS SDK
responseJ = obj.Handle.deleteObject(deleteObjectRequest);

% Wrap the Java response in a MATLAB DeleteObjectResponse object
deleteObjectResponse = aws.s3.model.DeleteObjectResponse(responseJ);
write(obj.logObj, 'info', 'Deleted Object in Simple Storage Service');

end
