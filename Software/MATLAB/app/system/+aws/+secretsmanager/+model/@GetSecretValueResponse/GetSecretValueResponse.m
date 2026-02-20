classdef GetSecretValueResponse < aws.Object
    %GETSECRETVALUERESPONSE Response object for getting a Secrets Manager secret value.
    %
    % This class encapsulates the response from the getSecretValue operation
    % in Secrets Manager.
    %
    % Example:
    %    getSecretValueResponse = sm.getSecretValue(secretId);
    %    secretString = getSecretValueResponse.secretString;

    % Copyright 2025 The MathWorks, Inc.

    properties
        arn string
        secretString string
        secretBinary uint8
    end

    methods
        function obj = GetSecretValueResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.secretsmanager.model.GetSecretValueResponse')
                obj.Handle = varargin{1};
                obj.arn = string(obj.Handle.arn());                
                if ~isempty(obj.Handle.secretString())
                    obj.secretString = string(obj.Handle.secretString());
                end

                if ~isempty(obj.Handle.secretBinary())
                    jbytes = obj.Handle.secretBinary().asByteArray();
                    obj.secretBinary = uint8(jbytes);
                end

            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end