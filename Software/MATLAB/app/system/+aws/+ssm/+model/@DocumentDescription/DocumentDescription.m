classdef DocumentDescription < aws.Object
    % DOCUMENTDESCRIPTION MATLAB wrapper for SSM document metadata.
    %
    % Syntax
    %   desc = aws.ssm.model.DocumentDescription(javaResponse);
    %
    % Properties
    %   name            - (string) Document name.
    %   documentType    - (string) Classification such as "Command" or "Automation".
    %   documentFormat  - (string) "JSON" or "YAML".
    %   status          - (string) Current publication status.
    %   versionName     - (string) Friendly version alias when provided.
    %   documentVersion - (string) Version number assigned by SSM.

    % Copyright 2025 The MathWorks, Inc.

    properties
        name string
        documentType string
        documentFormat string
        status string
        versionName string
        documentVersion string
    end

    methods
        function obj = DocumentDescription(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ssm.model.DocumentDescription')
                obj.Handle = varargin{1};
                obj.name = string(obj.Handle.name());
                obj.documentType = string(obj.Handle.documentTypeAsString());
                obj.documentFormat = string(obj.Handle.documentFormatAsString());
                obj.status = string(obj.Handle.statusAsString());
                obj.versionName = string(obj.Handle.versionName());
                obj.documentVersion = string(obj.Handle.documentVersion());
            else
                error('Input must be a software.amazon.awssdk.services.ssm.model.DocumentDescription object');
            end
        end
    end
end
