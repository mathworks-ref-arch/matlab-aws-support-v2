classdef FileUpload < aws.Object
    % FILEUPLOAD Wrapper for TransferManager file upload jobs.
    %
    % Syntax
    %   resp = aws.s3.model.FileUpload(javaUploadJob);
    %
    % Properties
    %   status - (logical) True when the upload completed successfully.
    %
    % Example
    %   resp = tm.uploadFile(bucket="demo", key="data.csv", file="data.csv");
    %   if resp.status
    %       disp("Upload complete");
    %   end

    % Copyright 2025 The MathWorks, Inc.

    properties
        status logical
        % Add other properties as needed, e.g. result, exception, etc.
    end

    methods
        function obj = FileUpload(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.transfer.s3.model.FileUpload')
                obj.Handle = varargin{1};
                % Status
                obj.status = varargin{1}.completionFuture().isDone();

            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
