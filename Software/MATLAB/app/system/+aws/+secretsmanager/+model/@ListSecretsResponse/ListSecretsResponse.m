classdef ListSecretsResponse < aws.Object
    %LISTSECRETSRESPONSE Response object for listing Secrets Manager secrets
    %
    % This class encapsulates the response from the ListSecrets operation
    % in Amazon Secrets Manager, providing access to a list of secrets.
    % Example:
    %    listSecretsResponse = sm.listSecrets();
    %    secrets = listSecretsResponse.secrets;

    % Copyright 2025 The MathWorks, Inc.

    properties
        secrets (1,:) aws.secretsmanager.model.SecretListEntry % An array that represents secret details
        nextToken string
    end

    methods
        function obj = ListSecretsResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.secretsmanager.model.ListSecretsResponse')
                obj.Handle = varargin{1};
                if obj.Handle.hasSecretList
                    % Extract topic details from the Java response object
                    javaSecretsList = obj.Handle.secretList();                    
                    numSecrets = javaSecretsList.size();
                    % Preallocating string array. Otherwise the default
                    obj.secrets = strings(1,numSecrets);

                    for iSecret = 1:numSecrets
                        jEntry = javaSecretsList.get(iSecret - 1);
                        obj.secrets(iSecret) = aws.secretsmanager.model.SecretListEntry(jEntry);
                    end
                end
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end