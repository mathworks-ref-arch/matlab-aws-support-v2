classdef Client < aws.core.BaseClient
    % CLIENT MATLAB client for Amazon Polly (text-to-speech).
    %
    % Syntax
    %   polly = aws.polly.Client();
    %   polly = aws.polly.Client('region',"us-east-1", 'credentialsprovider', provider);
    %
    % Name-Value Arguments
    %   'region'              - (string | software.amazon.awssdk.regions.Region) Target region.
    %   'credentialsprovider' - (aws.auth.CredentialProvider) Credential chain override.
    %   'isCrt'               - (logical) Use the AWS Common Runtime HTTP client when true.
    %
    % Example
    %   polly = aws.polly.Client();
    %   resp = polly.describeVoices(languageCode="en-US");

    % Copyright 2025 The MathWorks

    methods
        function obj = Client(varargin)
            % Service ID matches endpoint prefix: 'polly'
            obj@aws.core.BaseClient('polly', varargin{:});
        end
    end

    methods (Access = protected)
        function initStat = initialize(obj, regionObj, credentialsProvider)
            import software.amazon.awssdk.services.polly.PollyClient;

            initStat = false;
            builder = PollyClient.builder();
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
