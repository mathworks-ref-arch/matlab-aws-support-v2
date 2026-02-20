classdef Client < aws.core.BaseClient
    % CLIENT Amazon Elastic Container Service (ECS) client.
    %
    % Syntax
    %   ecs = aws.ecs.Client();
    %   ecs = aws.ecs.Client('region',"us-east-1", 'credentialsprovider', provider, 'isCrt', true);
    %
    % Name-Value Arguments
    %   'region'              - (string) Region override; defaults to the shared credential region.
    %   'credentialsprovider' - (aws.auth.CredentialProvider) Custom credential chain to use.
    %   'isCrt'               - (logical) Use the AWS Common Runtime HTTP client when true.
    %
    % Example
    %   ecs = aws.ecs.Client('region',"us-east-1");
    %   resp = ecs.createCluster(clusterName="demoCluster");

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = Client(varargin)
            obj@aws.core.BaseClient('ecs', varargin{:});
        end
    end

    methods (Access = protected)
        function initStat = initialize(obj, regionObj, credentialsProvider)
            import software.amazon.awssdk.services.ecs.EcsClient;

            initStat = false;
            builder = EcsClient.builder();
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
