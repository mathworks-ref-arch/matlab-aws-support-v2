classdef DeleteDocumentResponse < aws.Object
    % DELETEDOCUMENTRESPONSE MATLAB wrapper for deleteDocument results.
    %
    % Syntax
    %   resp = aws.ssm.model.DeleteDocumentResponse(javaResponse);
    %
    % Properties
    %   status - (string) Operation status (always "Success" for AWS SDK v2).

    % Copyright 2025 The MathWorks, Inc.

    properties
        status string
    end
    methods
        function obj = DeleteDocumentResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ssm.model.DeleteDocumentResponse')
                obj.Handle = varargin{1};
                obj.status = "Success"; % No fields in response
            else
                error('Input must be a software.amazon.awssdk.services.ssm.model.DeleteDocumentResponse object');
            end
        end
    end
end
