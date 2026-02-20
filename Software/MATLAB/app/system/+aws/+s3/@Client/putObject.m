function putObjectResponse = putObject(obj, options)
% PUTOBJECT Upload an object to Amazon S3.
%
% Syntax
%   resp = s3.putObject(bucket="<bucket>", key="<key>", body=rb);
%   resp = s3.putObject(bucket="<bucket>", key="<key>", body=rb, acl="public-read");
%
% Name-Value Arguments
%   bucket      - (string, required) Bucket name.
%   key         - (string, required) Destination object key.
%   body        - (aws.core.model.RequestBody, required) Payload wrapper created with
%                 `aws.core.model.RequestBody` (string, file, or bytes).
%   acl         - (string) Canned ACL to apply to the uploaded object.
%   contentType - (string) MIME type stored with the object.
%
% Returns
%   putObjectResponse - aws.s3.model.PutObjectResponse containing request metadata.
%
% Example
%   s3 = aws.s3.Client();
%   payload = aws.core.model.RequestBody("hello from MATLAB");
%   resp = s3.putObject(bucket="matlab-demo-bucket", key="greetings.txt", body=payload);
%   resp = s3.putObject(bucket="matlab-demo-bucket", key="public.txt", body=payload, acl="public-read");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.body (1,1) aws.core.model.RequestBody
    options.key (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.acl string  % Optional
    options.contentType string % Optional

end

write(obj.logObj, 'info', 'Uploading object to Simple Storage Service');

% Create a PutObjectRequest builder
putObjectRequestBuilder = software.amazon.awssdk.services.s3.model.PutObjectRequest.builder();

% Extract the body to upload
requestBodyJ = options.body.Handle;
% remove body from options
options = rmfield(options,"body");
% Build the request
putObjectRequest = aws.internal.builder.build(putObjectRequestBuilder,options);

% Call the putObject method from the AWS SDK
responseJ = obj.Handle.putObject(putObjectRequest, requestBodyJ);

% Wrap the Java response in a MATLAB PutObjectResponse object
putObjectResponse = aws.s3.model.PutObjectResponse(responseJ);
write(obj.logObj, 'info', 'Uploaded object to Simple Storage Service');

end
