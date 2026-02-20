function copyObject = copy(obj, options)
% COPY Copy an object between S3 locations using TransferManager.
%
% Syntax
%   resp = tm.copy(sourceBucket="src", sourceKey="doc.txt", ...
%       destinationBucket="dest", destinationKey="doc.txt");
%
% Name-Value Arguments
%   sourceBucket      - (string, required) Source bucket name.
%   sourceKey         - (string, required) Source object key.
%   destinationBucket - (string, required) Destination bucket name.
%   destinationKey    - (string, required) Destination object key.
%   acl               - (string) Optional canned ACL applied to the copy.
%   metadata          - (dictionary) Optional metadata key/value pairs.
%
% Returns
%   copyObject - aws.s3.model.Transfer representing the asynchronous job.
%
% Example
%   tm = aws.s3.transfer.TransferManager();
%   resp = tm.copy(sourceBucket="inbound", sourceKey="data.csv", ...
%       destinationBucket="archive", destinationKey="2024/data.csv");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.sourceBucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.sourceKey (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.destinationBucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.destinationKey (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.aclAsString (1,1) string
    options.metadata dictionary
end

write(obj.logObj, 'verbose', 'Copying object in Amazon S3 using TransferManager');

% Build the CopyRequest
copyRequestBuilder = software.amazon.awssdk.transfer.s3.model.CopyRequest.builder();

% Build the CopyObjectRequest
copyObjectRequestBuilder = software.amazon.awssdk.services.s3.model.CopyObjectRequest.builder();
copyObjectRequest = aws.internal.builder.build(copyObjectRequestBuilder, options);

% Build the CopyRequest
copyRequestOptions.copyObjectRequest = copyObjectRequest;
copyRequest = aws.internal.builder.build(copyRequestBuilder, copyRequestOptions);

% Call the copy method from the AWS SDK TransferManager
copyJob = obj.Handle.copy(copyRequest);

% Wait for the copy to complete (blocking)
copyJob.completionFuture().join();

% Wrap the Java Copy object in a MATLAB CopyObjectResponse object
copyObject = aws.s3.model.Transfer(copyJob);

write(obj.logObj, 'verbose', 'Object copied in Amazon S3 successfully');

end
