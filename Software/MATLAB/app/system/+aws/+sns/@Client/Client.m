classdef Client < aws.core.BaseClient
    % CLIENT Amazon Simple Notification Service (SNS) client.
    %
    % Syntax
    %   sns = aws.sns.Client();
    %   sns = aws.sns.Client('region',"us-east-1", 'credentialsprovider', provider);
    %
    % Name-Value Arguments
    %   'region'              - (string) AWS region override; defaults to the shared credential configuration.
    %   'credentialsprovider' - (aws.auth.CredentialProvider) Custom credential provider.
    %   'isCrt'               - (logical) Use the AWS Common Runtime HTTP client when true.
    %
    % Example
    %   sns = aws.sns.Client('region',"us-east-1");
    %   resp = sns.createTopic(name="demoTopic");
    %
    % Provides high-level wrappers over `software.amazon.awssdk.services.sns.SnsClient`.

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = Client(varargin)
            obj@aws.core.BaseClient('sns', varargin{:});
        end
    end

    methods (Access = protected)
        function initStat = initialize(obj, regionObj, credentialsProvider)
            import software.amazon.awssdk.services.sns.SnsClient;

            initStat = false;
            builder = SnsClient.builder();
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
