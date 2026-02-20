classdef DeleteSecretResponse < aws.Object
    %DeleteSecretResponse Response object for deleting a Secrets Manager secret.
    %
    % This class encapsulates the response from the deleteSecret operation
    % in Secrets Manager.
    %
    % Example:
    %    deleteSecretResponse = sm.deleteSecret(secretId);
    %    secretArn = deleteSecretResponse.secretArn;

    % Copyright 2025 The MathWorks, Inc.

    properties
        arn string
    end

    methods
        function obj = DeleteSecretResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.secretsmanager.model.DeleteSecretResponse')
                obj.Handle = varargin{1};
                obj.arn = string(obj.Handle.arn());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end