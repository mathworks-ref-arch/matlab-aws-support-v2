classdef Client < aws.core.BaseClient
    % CLIENT Amazon Web Services Systems Manager (SSM) client.
    %
    % Syntax
    %   ssm = aws.ssm.Client();
    %   ssm = aws.ssm.Client('region',"us-east-1", 'credentialsprovider', provider, 'isCrt', true);
    %
    % Name-Value Arguments
    %   'region'              - (string) Region override; defaults to shared credential region.
    %   'credentialsprovider' - (aws.auth.CredentialProvider) Supply a custom credential chain.
    %   'isCrt'               - (logical) Use the AWS Common Runtime HTTP stack when true.
    %
    % Example
    %   ssm = aws.ssm.Client('region',"us-east-1");
    %   resp = ssm.getParameter(name="/app/config", withDecryption=true);

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = Client(varargin)
            obj@aws.core.BaseClient('ssm', varargin{:});
        end
    end

    methods (Access = protected)
        function initStat = initialize(obj, regionObj, credentialsProvider)
            import software.amazon.awssdk.services.ssm.SsmClient;

            initStat = false;
            builder = SsmClient.builder();
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
