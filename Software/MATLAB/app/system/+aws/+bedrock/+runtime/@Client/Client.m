classdef Client < aws.core.BaseClient
    % CLIENT MATLAB wrapper for Amazon Bedrock Runtime.
    %
    % Syntax
    %   bedrock = aws.bedrock.runtime.Client();
    %   bedrock = aws.bedrock.runtime.Client('region',"us-east-1", 'credentialsprovider', provider);
    %
    % Name-Value Arguments
    %   'region'              - (string | software.amazon.awssdk.regions.Region) Target Region.
    %   'credentialsprovider' - (aws.auth.CredentialProvider) Credential source. Defaults to shared chain.
    %   'isCrt'               - (logical) Use the AWS Common Runtime HTTP client when true.
    %
    % Example
    %   bedrock = aws.bedrock.runtime.Client('region',"us-east-1");
    %   resp = bedrock.invokeModel(modelId="amazon.titan-text-lite-v1", body="Hello!");
    %
    % Notes
    %   Amazon Bedrock Runtime is available only in select regions. Provide a supported region
    %   (e.g., `us-east-1`) when constructing the client.

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = Client(varargin)
            obj@aws.core.BaseClient('bedrock', varargin{:});
        end
    end

    methods (Access = protected)
        function initStat = initialize(obj, regionObj, credentialsProvider)
            import software.amazon.awssdk.services.bedrockruntime.BedrockRuntimeClient;

            initStat = false;
            builder = BedrockRuntimeClient.builder();
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
