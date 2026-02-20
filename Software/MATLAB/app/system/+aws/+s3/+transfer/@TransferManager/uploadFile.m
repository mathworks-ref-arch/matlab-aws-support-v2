function uploadFile = uploadFile(obj, options)
% UPLOADFILE Upload a local file to Amazon S3 using TransferManager.
%
% Syntax
%   resp = tm.uploadFile(bucket="mybucket", key="file.txt", file="file.txt");
%
% Name-Value Arguments
%   bucket   - (string, required) Destination bucket.
%   key      - (string, required) Destination object key.
%   file     - (string, required) Source file path.
%   acl      - (string) Optional canned ACL applied to the upload.
%   metadata - (dictionary) Optional metadata key/value pairs.
%   contentType - (string) Optional MIME type for the object.
%
% Returns
%   uploadFile - aws.s3.model.FileUpload describing the transfer job.
%
% Example
%   tm = aws.s3.transfer.TransferManager();
%   resp = tm.uploadFile(bucket="logs", key="2024/summary.txt", file="summary.txt");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.key    (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.file   (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.aclAsString (1,1) string
    options.metadata dictionary
    options.contentType (1,1) string

end

write(obj.logObj, 'verbose', 'Uploading file to Amazon S3 using TransferManager');

uploadFileRequestBuilder = software.amazon.awssdk.transfer.s3.model.UploadFileRequest.builder();
fileToUpload = java.io.File(options.file);
uploadFileOptions.source=fileToUpload;

% Build the PutObjectRequest
options = rmfield(options, 'file');
putObjectRequestBuilder = software.amazon.awssdk.services.s3.model.PutObjectRequest.builder();
putObjectRequest = aws.internal.builder.build(putObjectRequestBuilder, options);

% Build the UploadFileRequest
uploadFileOptions.putObjectRequest = putObjectRequest;
% Finalize the request
uploadFileRequest = aws.internal.builder.build(uploadFileRequestBuilder, uploadFileOptions);


% Call the uploadFile method from the AWS SDK TransferManager
uploadJob = obj.Handle.uploadFile(uploadFileRequest);

% Wait for the upload to complete (blocking, or use .completionFuture())
uploadJob.completionFuture().join();

% Wrap the Java UploadFileRequest in a MATLAB UploadFileResponse object
% (You may want to create a more detailed response class as needed)
uploadFile = aws.s3.model.FileUpload(uploadJob);

write(obj.logObj, 'verbose', 'File uploaded to Amazon S3 successfully');

end
