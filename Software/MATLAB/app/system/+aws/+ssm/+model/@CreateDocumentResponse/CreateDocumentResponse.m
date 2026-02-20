classdef CreateDocumentResponse < aws.Object
    % CREATEDOCUMENTRESPONSE MATLAB wrapper for createDocument results.
    %
    % Syntax
    %   resp = aws.ssm.model.CreateDocumentResponse(javaResponse);
    %
    % Properties
    %   documentDescription - (aws.ssm.model.DocumentDescription) Metadata for the created document.

    % Copyright 2025 The MathWorks, Inc.

    properties
        documentDescription aws.ssm.model.DocumentDescription
    end
    methods
        function obj = CreateDocumentResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ssm.model.CreateDocumentResponse')
                obj.Handle = varargin{1};
                docDescJ = obj.Handle.documentDescription();
                if ~isempty(docDescJ)
                    obj.documentDescription = aws.ssm.model.DocumentDescription(docDescJ);
                else
                    obj.documentDescription = [];
                end
            else
                error('Input must be a software.amazon.awssdk.services.ssm.model.CreateDocumentResponse object');
            end
        end
    end
end
