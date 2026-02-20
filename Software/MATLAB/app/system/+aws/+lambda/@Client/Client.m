classdef Client < aws.core.BaseClient
    % CLIENT Amazon Lambda service client.
    %
    % Syntax
    %   lambda = aws.lambda.Client();
    %   lambda = aws.lambda.Client('region',"us-east-1", 'credentialsprovider', provider);
    %
    % Name-Value Arguments
    %   'region'              - (string) AWS region to target. Defaults to the shared credential default.
    %   'credentialsprovider' - (aws.auth.CredentialProvider) Custom credential provider.
    %   'isCrt'               - (logical) Use the AWS Common Runtime HTTP client when true.
    %
    % Example
    %   lambda = aws.lambda.Client('region',"us-east-1");
    %   resp = lambda.listFunctions(); % assuming helper exists
    %
    % Lambda executes code without provisioning servers and this client wraps the
    % AWS SDK v2 `software.amazon.awssdk.services.lambda.LambdaClient`.

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = Client(varargin)
            obj@aws.core.BaseClient('lambda', varargin{:});
        end
    end

    methods (Access = protected)
        function initStat = initialize(obj, regionObj, credentialsProvider)
            import software.amazon.awssdk.services.lambda.LambdaClient;

            initStat = false;
            builder = LambdaClient.builder();
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
