function copyObjectResponse = copyObject(obj, options)
% COPYOBJECT Copy an object between S3 locations.
%
% Syntax
%   resp = s3.copyObject( ...
%       sourceBucket="src-bucket", sourceKey="path/data.csv", ...
%       destinationBucket="dest-bucket", destinationKey="archive/data.csv");
%
% Name-Value Arguments
%   sourceBucket      - (string, required) Source bucket that owns the object.
%   sourceKey         - (string, required) Key of the source object.
%   destinationBucket - (string, required) Destination bucket.
%   destinationKey    - (string, required) Destination key (new object name).
%   acl               - (string) Canned ACL to apply to the copied object.
%
% Returns
%   copyObjectResponse - aws.s3.model.CopyObjectResponse with metadata (ETag, version ID, etc.).
%
% Example
%   s3 = aws.s3.Client();
%   resp = s3.copyObject( ...
%       sourceBucket="my-source-bucket", sourceKey="src.txt", ...
%       destinationBucket="my-dest-bucket", destinationKey="dst.txt");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.sourceBucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.sourceKey (1,1) string {mustBeTextScalar}
    options.destinationBucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.destinationKey (1,1) string {mustBeTextScalar}
    options.acl string  % Optional
end

write(obj.logObj, 'info', 'Copying object in Simple Storage Service');

% Create a copy object request builder
copyObjectRequestBuilder = software.amazon.awssdk.services.s3.model.CopyObjectRequest.builder();

% Build the request
copyObjectRequest = aws.internal.builder.build(copyObjectRequestBuilder,options);

% Call the copyObject method from the AWS SDK
responseJ = obj.Handle.copyObject(copyObjectRequest);

% Wrap the Java response in a MATLAB CopyObjectResponse object
copyObjectResponse = aws.s3.model.CopyObjectResponse(responseJ);
write(obj.logObj, 'info', 'Copied object in Simple Storage Service');

end


