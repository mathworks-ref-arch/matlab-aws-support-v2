function downloadDirectory = downloadDirectory(obj, options)
% DOWNLOADDIRECTORY Download an entire bucket (or virtual folder) to disk.
%
% Syntax
%   resp = tm.downloadDirectory(bucket="mybucket", targetDir="downloads");
%
% Name-Value Arguments
%   bucket    - (string, required) Source bucket name.
%   targetDir - (string, required) Local destination directory.
%
% Returns
%   downloadDirectory - aws.s3.model.Transfer describing the directory transfer job.
%
% Example
%   tm = aws.s3.transfer.TransferManager();
%   resp = tm.downloadDirectory(bucket="datasets", targetDir="local-data");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket    (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.targetDir (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.prefix    (1,1) string {mustBeTextScalar}
end

write(obj.logObj, 'verbose', 'Downloading directory from Amazon S3 using TransferManager');

% Build the DownloadDirectoryRequest
downloadDirectoryRequestBuilder = software.amazon.awssdk.transfer.s3.model.DownloadDirectoryRequest.builder();

% Set the bucket
downloadDirectoryRequestOptions.bucket=(options.bucket);


% Set the target directory (as java.nio.file.Path)
targetDirFile = java.io.File(options.targetDir).toPath();
downloadDirectoryRequestOptions.destination=targetDirFile;

% Finalize the request
downloadDirectoryRequest = aws.internal.builder.build(downloadDirectoryRequestBuilder, downloadDirectoryRequestOptions);

% Call the downloadDirectory method from the AWS SDK TransferManager
directoryDownloadJob = obj.Handle.downloadDirectory(downloadDirectoryRequest);

% Wait for the download to complete (blocking, or use .completionFuture())
completedDirectoryDownload = directoryDownloadJob.completionFuture().join();
if (~completedDirectoryDownload.failedTransfers().isEmpty())
    write(obj.logObj,'verbose','Some Files Failed to Download Successfully')
else
    write(obj.logObj,'verbose','Directory Downloaded Successfully')
end

% Wrap the Java DirectoryDownload in a MATLAB DirectoryDownload object
downloadDirectory = aws.s3.model.Transfer(directoryDownloadJob);

write(obj.logObj, 'verbose', 'Directory downloaded from Amazon S3 successfully');

end
