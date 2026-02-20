classdef Client < aws.core.BaseClient
    % CLIENT MATLAB client for AWS Security Token Service (STS).
    %
    % Syntax
    %   sts = aws.sts.Client();
    %   sts = aws.sts.Client('region',"us-east-1", 'credentialsprovider', provider);
    %
    % Name-Value Arguments
    %   'region'              - (string | software.amazon.awssdk.regions.Region) Target region.
    %   'credentialsprovider' - (aws.auth.CredentialProvider) Credential chain override.
    %   'isCrt'               - (logical) Use the AWS Common Runtime HTTP client when true.
    %
    % Example
    %   sts = aws.sts.Client();
    %   resp = sts.getCallerIdentity();

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = Client(varargin)
            obj@aws.core.BaseClient('sts', varargin{:});
        end
    end

    methods (Access = protected)
        function initStat = initialize(obj, regionObj, credentialsProvider)
            import software.amazon.awssdk.services.sts.StsClient;

            initStat = false;
            builder = StsClient.builder();
            builder.region(regionObj);

            if ~isempty(credentialsProvider)
                builder.credentialsProvider(credentialsProvider);
            end

            % STS is fine with either CRT or Apache
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
