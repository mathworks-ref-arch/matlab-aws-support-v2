classdef Transfer < aws.Object
    % TRANSFER Generic wrapper for AWS SDK TransferManager operations.
    %
    % Syntax
    %   resp = aws.s3.model.Transfer(javaTransferJob);
    %
    % Properties
    %   status - (logical) True when the transfer job has completed.
    %
    % Example
    %   resp = tm.uploadDirectory(bucket="demo", sourceDir="data");
    %   if resp.status; disp("Directory sync complete"); end

    % Copyright 2025 The MathWorks, Inc.

    properties
        status logical
        % Add other properties as needed, e.g. result, exception, etc.
    end

    methods
        function obj = Transfer(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.transfer.s3.model.Transfer')
                obj.Handle = varargin{1};
                % Status
                obj.status = varargin{1}.completionFuture().isDone();

            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
