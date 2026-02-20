function getObjectAclResponse = getObjectAcl(obj, options)
% GETOBJECTACL Retrieve the ACL for an S3 object.
%
% Syntax
%   resp = s3.getObjectAcl(bucket="<bucket>", key="<key>");
%
% Name-Value Arguments
%   bucket             - (string, required) Bucket containing the object.
%   key                - (string, required) Object key.
%   versionId          - (string) Specific version to inspect.
%   requestPayer       - (string) Specify `"requester"` for requester-pays buckets.
%   expectedBucketOwner - (string) AWS account ID expected to own the bucket.
%
% Returns
%   getObjectAclResponse - aws.s3.model.GetObjectAclResponse containing owner and grant entries.
%
% Example
%   s3 = aws.s3.Client();
%   resp = s3.getObjectAcl(bucket="my-bucket", key="my-object.txt");
%   disp(resp.owner.displayName);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.key (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.versionId (1,1) string {mustBeTextScalar}
    options.requestPayer (1,1) string {mustBeTextScalar}
    options.expectedBucketOwner (1,1) string {mustBeTextScalar}
end

write(obj.logObj, 'info', 'Retrieving object ACL in Simple Storage Service');

% Create a GetObjectAclRequest builder
getObjectAclRequestBuilder = software.amazon.awssdk.services.s3.model.GetObjectAclRequest.builder();

% Build the request using the internal builder utility
getObjectAclRequest = aws.internal.builder.build(getObjectAclRequestBuilder, options);

% Call the getObjectAcl method from the AWS SDK
responseJ = obj.Handle.getObjectAcl(getObjectAclRequest);

% Wrap the Java response in a MATLAB GetObjectAclResponse object
getObjectAclResponse = aws.s3.model.GetObjectAclResponse(responseJ);
write(obj.logObj, 'info', 'Retrieved object ACL from Simple Storage Service');

end
