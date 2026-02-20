function saveS3ResponseInputStreamToFile(obj, responseInputStream, localFilePath)
% SAVES3RESPONSEINPUTSTREAMTOFILE Persist an S3 ResponseInputStream to disk.
%
% Syntax
%   s3.saveS3ResponseInputStreamToFile(resp.InputStream, "download.bin");
%
% Inputs
%   responseInputStream - (software.amazon.awssdk.core.ResponseInputStream) Stream returned by `getObject`.
%   localFilePath       - (string | char) Destination file path on disk.

% Copyright 2025 The MathWorks, Inc.

write(obj.logObj, 'info', 'Saving object from Simple Storage Service');
import java.io.DataInputStream
% Open MATLAB file for writing (binary mode)
fid = fopen(localFilePath, 'w');
if fid == -1
    error('Could not open file: %s', localFilePath);
end
dis = java.io.DataInputStream(responseInputStream);
bytes = org.apache.commons.io.IOUtils.toByteArray(dis);
fwrite(fid, bytes, 'uint8');
dis.close();
responseInputStream.close();

fclose(fid);
end

