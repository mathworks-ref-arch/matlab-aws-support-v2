classdef Client < aws.core.BaseClient
    % CLIENT Amazon Simple Queue Service (SQS) client.
    %
    % Syntax
    %   sqs = aws.sqs.Client();
    %   sqs = aws.sqs.Client('region',"us-east-1", 'credentialsprovider', provider);
    %
    % Name-Value Arguments
    %   'region'              - (string) Region override; defaults to shared credential region.
    %   'credentialsprovider' - (aws.auth.CredentialProvider) Custom credential chain.
    %   'isCrt'               - (logical) Use the AWS Common Runtime HTTP client when true.
    %
    % Example
    %   sqs = aws.sqs.Client('region',"us-east-1");
    %   resp = sqs.createQueue(queueName="demoQueue");

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = Client(varargin)
            obj@aws.core.BaseClient('sqs', varargin{:});
        end
    end

    methods (Access = protected)
        function initStat = initialize(obj, regionObj, credentialsProvider)
            import software.amazon.awssdk.services.sqs.SqsClient;

            initStat = false;
            builder = SqsClient.builder();
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
