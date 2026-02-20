function uploadDirectory = uploadDirectory(obj, options)
% UPLOADDIRECTORY Upload all files within a local directory to Amazon S3.
%
% Syntax
%   resp = tm.uploadDirectory(bucket="mybucket", sourceDir="data");
%
% Name-Value Arguments
%   bucket    - (string, required) Destination bucket.
%   sourceDir - (string, required) Local directory to sync.
%   prefix    - (string) Optional key prefix under which files are stored.
%
% Returns
%   uploadDirectory - aws.s3.model.Transfer describing the directory upload job.
%
% Example
%   tm = aws.s3.transfer.TransferManager();
%   resp = tm.uploadDirectory(bucket="datasets", sourceDir="processed");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket    (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.sourceDir (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.prefix string
end

write(obj.logObj, 'verbose', 'Uploading directory to Amazon S3 using TransferManager');

% Build the UploadDirectoryRequest
uploadDirectoryRequestBuilder = software.amazon.awssdk.transfer.s3.model.UploadDirectoryRequest.builder();

% Set the source directory
sourceDirFile = java.io.File(options.sourceDir).toPath();

% Finalize the request
uploadDirectoryOptions.bucket = options.bucket;
uploadDirectoryOptions.source = sourceDirFile;
% Set S3 prefix if provided
if isfield(options, 'prefix')
    uploadDirectoryOptions.s3Prefix=options.prefix;
end

uploadDirectoryRequest = aws.internal.builder.build(uploadDirectoryRequestBuilder,uploadDirectoryOptions);

% Call the uploadDirectory method from the AWS SDK TransferManager
directoryUploadJob = obj.Handle.uploadDirectory(uploadDirectoryRequest);

% Wait for the upload to complete (blocking, or use .completionFuture())
completedDirectoryUpload = directoryUploadJob.completionFuture().join();
if (~completedDirectoryUpload.failedTransfers().isEmpty())
    write(obj.logObj,'verbose','Some Files Failed to Upload Successfully')
else
    write(obj.logObj,'verbose','Directory Upload Successfully')
end

% Wrap the Java DirectoryUpload in a MATLAB DirectoryUpload object
uploadDirectory = aws.s3.model.Transfer(directoryUploadJob);

write(obj.logObj, 'verbose', 'Directory uploaded to Amazon S3 successfully');

end
