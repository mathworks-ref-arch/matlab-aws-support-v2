classdef Client < aws.core.BaseClient
    %CLIENT MATLAB client wrapper for Amazon Athena.
    %
    % Syntax
    %   athena = aws.athena.Client();
    %   athena = aws.athena.Client('region',"us-east-1", ...
    %                              'credentialsprovider', credProv, ...
    %                              'isCrt', true);
    %
    % Name-Value Arguments
    %   'region'              - (string | software.amazon.awssdk.regions.Region) AWS Region.
    %   'credentialsprovider' - (aws.auth.CredentialProvider) Credential source used by the client.
    %   'isCrt'               - (logical) Use the AWS Common Runtime HTTP client when true.
    %
    % Example
    %   cred = aws.auth.CredentialProvider.getDefaultCredentialProvider();
    %   athena = aws.athena.Client('region',"us-east-1", 'credentialsprovider', cred);
    %   resp = athena.getQueryExecution(queryExecutionId="1234-abcd");
    %
    % Authentication credentials – see the Authentication section of the
    % documentation for setup guidance.

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = Client(varargin)
            obj@aws.core.BaseClient('athena', varargin{:});
        end
    end

    methods (Access = protected)
        function initStat = initialize(obj, regionObj, credentialsProvider)
            import software.amazon.awssdk.services.athena.AthenaClient;

            initStat = false;
            builder = AthenaClient.builder();
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
