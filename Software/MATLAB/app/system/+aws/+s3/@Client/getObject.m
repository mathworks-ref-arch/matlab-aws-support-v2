function [getObjectResponse, inputStream] = getObject(obj, options)
% GETOBJECT Download an object from Amazon S3.
%
% Syntax
%   [resp, stream] = s3.getObject(bucket="<bucket>", key="<key>");
%
% Name-Value Arguments
%   bucket - (string, required) Bucket name.
%   key    - (string, required) Object key inside the bucket.
%
% Returns
%   getObjectResponse - aws.s3.model.GetObjectResponse containing metadata (ETag, size, etc.).
%   inputStream       - software.amazon.awssdk.core.ResponseInputStream for reading the body.
%
% Example
%   s3 = aws.s3.Client();
%   [resp, stream] = s3.getObject(bucket="matlab-demo-bucket", key="docs/readme.txt");
%   bytes = com.mathworks.mlwidgets.io.InterruptibleStreamCopier.getInterruptibleStreamCopier();
%   byteArrayOutputStream = java.io.ByteArrayOutputStream();
%   bytes.copyStream(stream, byteArrayOutputStream);
%   disp(char(byteArrayOutputStream.toByteArray()));

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.key (1,1) string {mustBeTextScalar, mustBeNonempty}

    % Add more optional arguments as needed
end

write(obj.logObj, 'info', 'Downloading object from Simple Storage Service');

% Create a GetObjectRequest builder
getObjectRequestBuilder = software.amazon.awssdk.services.s3.model.GetObjectRequest.builder();

% Build the request using internal builder utility
getObjectRequest = aws.internal.builder.build(getObjectRequestBuilder,options);

% Call the getObject method from the AWS SDK
% Returns a ResponseInputStream<GetObjectResponse>
responseInputStreamJ = obj.Handle.getObject(getObjectRequest);

% Extract the GetObjectResponse metadata
getObjectResponseJ = responseInputStreamJ.response();

% Wrap the Java response in a MATLAB GetObjectResponse object
getObjectResponse = aws.s3.model.GetObjectResponse(getObjectResponseJ);

% Return the Java InputStream for reading the object's body
inputStream = responseInputStreamJ;

write(obj.logObj, 'info', 'Downloaded object from Simple Storage Service');

end