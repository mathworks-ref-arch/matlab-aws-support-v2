function downloadFileResp = downloadFile(obj, options)
% DOWNLOADFILE Download a single object to the local file system.
%
% Syntax
%   resp = tm.downloadFile(bucket="mybucket", key="data.csv", file="data.csv");
%
% Name-Value Arguments
%   bucket - (string, required) Source bucket name.
%   key    - (string, required) Source object key.
%   file   - (string, required) Destination path on the local file system.
%
% Returns
%   downloadFileResp - aws.s3.model.FileDownload describing the transfer job.
%
% Example
%   tm = aws.s3.transfer.TransferManager();
%   resp = tm.downloadFile(bucket="logs", key="2024/summary.txt", file="summary.txt");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.key (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.file (1,1) string {mustBeTextScalar, mustBeNonempty}
end

write(obj.logObj, 'verbose', 'Downloading file from Amazon S3 using TransferManager');

getObjectRequestBuilder = software.amazon.awssdk.services.s3.model.GetObjectRequest.builder();
downloadRequestBuilder = software.amazon.awssdk.transfer.s3.model.DownloadFileRequest.builder();
destinationPath = java.io.File(options.file);
downloadRequestOpt.destination  = destinationPath;
options = rmfield(options, 'file');

getObjectRequest = aws.internal.builder.build(getObjectRequestBuilder, options);
downloadRequestOpt.getObjectRequest  = getObjectRequest;

downloadRequest = aws.internal.builder.build(downloadRequestBuilder, downloadRequestOpt);

downloadJob = obj.Handle.downloadFile(downloadRequest);
downloadJob.completionFuture().join();

downloadFileResp = aws.s3.model.FileDownload(downloadJob);
write(obj.logObj, 'verbose', 'File downloaded from Amazon S3 successfully');

end
