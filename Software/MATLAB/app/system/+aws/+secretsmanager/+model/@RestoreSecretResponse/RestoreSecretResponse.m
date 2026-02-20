classdef RestoreSecretResponse < aws.Object
    %UPDATESECRETRESPONSE Response object for restoring a Secrets Manager secret.
    %
    % This class encapsulates the response from the restoreSecret operation
    % in Secrets Manager.
    %
    % Example:
    %    restoreSecretResponse = sm.restoreSecret(secretId);
    %    secretArn = restoreSecretResponse.secretArn;

    % Copyright 2025 The MathWorks, Inc.

    properties
        arn string
        name string
    end

    methods
        function obj = RestoreSecretResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.secretsmanager.model.RestoreSecretResponse')
                obj.Handle = varargin{1};
                obj.arn = string(obj.Handle.arn());
                obj.name = string(obj.Handle.name());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end