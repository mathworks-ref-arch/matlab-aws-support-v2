classdef Client < aws.core.BaseClient
    %CLIENT Amazon Web Services Secrets Manager Client
    %
    % This client is used to interact with the Amazon Web Services Secrets Manager
    % service, allowing secrets to be listed, created, deleted and retrieved.
    %
    % Example:
    %       sm = aws.secretsmanager.Client();
    %       % Perform operations with Secrets Manager
    %       listSecretsResponse = sm.listSecrets();
    %
    % Authentication Credentials - Please see the authentication section
    % of the documentation for more details.

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = Client(varargin)
            obj@aws.core.BaseClient('secretsmanager', varargin{:});
        end
    end

    methods (Access = protected)
        function initStat = initialize(obj, regionObj, credentialsProvider)
            import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;

            initStat = false;
            builder = SecretsManagerClient.builder();
            builder.region(regionObj);

            if ~isempty(credentialsProvider)
                builder.credentialsProvider(credentialsProvider);
            end

            builder = obj.applyHttpClientBuilder(builder, isCrt=obj.isCrt);
            obj.Handle = builder.build();

            if ~isempty(obj.Handle)
                write(obj.logObj, 'info', 'Client initialized');
                initStat = true;
            else
                write(obj.logObj, 'error', 'Client initialization failed');
            end
        end
    end
end
