classdef Client < aws.core.BaseClient
    %CLIENT MATLAB client wrapper for Amazon Simple Storage Service (S3).
    %
    % Syntax
    %   s3 = aws.s3.Client();
    %   s3 = aws.s3.Client('region',"us-east-1", ...
    %                      'credentialsprovider', cred, ...
    %                      'isCrt', true);
    %
    % Name-Value Arguments
    %   'region'              - (string | software.amazon.awssdk.regions.Region) AWS Region.
    %   'credentialsprovider' - (aws.auth.CredentialProvider) Credential source used by the client.
    %   'isCrt'               - (logical) Use the AWS Common Runtime HTTP client when true.
    %
    % Example
    %   cred = aws.auth.CredentialProvider.getDefaultCredentialProvider();
    %   s3 = aws.s3.Client('region',"us-east-1", 'credentialsprovider', cred);
    %   resp = s3.listBuckets();
    %
    % Notes
    %   All AWS operations require valid credentials. See the Authentication
    %   documentation for setup details.

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = Client(varargin)
            obj@aws.core.BaseClient('s3', varargin{:});
        end
    end

    methods (Access = protected)
        function initStat = initialize(obj, regionObj, credentialsProvider)
            import software.amazon.awssdk.services.s3.S3Client;

            initStat = false;
            builder = S3Client.builder();
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
