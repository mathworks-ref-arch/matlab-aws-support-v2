classdef CreateSecretResponse < aws.Object
    %CREATESECRETRESPONSE Response object for creating a Secrets Manager secret.
    %
    % This class encapsulates the response from the createSecret operation
    % in Secrets Manager.
    %
    % Example:
    %    createSecretResponse = sm.createSecret(secretId);
    %    secretArn = createSecretResponse.secretArn;

    % Copyright 2025 The MathWorks, Inc.

    properties
        arn string
    end

    methods
        function obj = CreateSecretResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.secretsmanager.model.CreateSecretResponse')
                obj.Handle = varargin{1};
                obj.arn = string(obj.Handle.arn());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end