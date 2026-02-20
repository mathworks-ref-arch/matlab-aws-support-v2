classdef FileDownload < aws.Object
    % FILEDOWNLOAD Wrapper for TransferManager file download jobs.
    %
    % Syntax
    %   resp = aws.s3.model.FileDownload(javaDownloadJob);
    %
    % Properties
    %   status - (logical) True when the download job completed successfully.
    %
    % Example
    %   resp = tm.downloadFile(bucket="demo", key="data.csv", file="data.csv");
    %   if resp.status
    %       disp("Download complete");
    %   end

    % Copyright 2025 The MathWorks, Inc.

    properties
        status logical
        % Add other properties as needed, e.g. request, exception, etc.
    end

    methods
        function obj = FileDownload(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.transfer.s3.model.FileDownload')
                obj.Handle = varargin{1};
                % Status: true if download is complete
                obj.status = varargin{1}.completionFuture().isDone();
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
