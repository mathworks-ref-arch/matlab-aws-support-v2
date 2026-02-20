classdef UpdateSecretResponse < aws.Object
    %UPDATESECRETRESPONSE Response object for updating a Secrets Manager secret.
    %
    % This class encapsulates the response from the updateSecret operation
    % in Secrets Manager.
    %
    % Example:
    %    updateSecretResponse = sm.updateSecret(secretId);
    %    secretArn = updateSecretResponse.secretArn;

    % Copyright 2025 The MathWorks, Inc.

    properties
        arn string
        name string
        versionId string        
    end

    methods
        function obj = UpdateSecretResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.secretsmanager.model.UpdateSecretResponse')
                obj.Handle = varargin{1};
                obj.arn = string(obj.Handle.arn());
                obj.name = string(obj.Handle.name());
                obj.versionId = string(obj.Handle.versionId());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end