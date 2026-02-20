classdef TransferManager < aws.Object
    % TRANSFERMANAGER High-level transfer client for Amazon S3.
    %
    % Syntax
    %   tm = aws.s3.transfer.TransferManager();
    %   tm = aws.s3.transfer.TransferManager('region',"us-east-1", ...
    %       'credentialsprovider', provider, 'proxy', proxyConfig);
    %
    % Name-Value Arguments
    %   'region'              - (string | software.amazon.awssdk.regions.Region) Region for transfers.
    %   'credentialsprovider' - (aws.auth.CredentialProvider) Credential chain override.
    %   'proxy'               - (struct) Proxy settings understood by `aws.Object.configProxyHttpClient`.
    %
    % Example
    %   tm = aws.s3.transfer.TransferManager('region',"us-east-1");
    %   resp = tm.downloadFile(bucket="demo", key="data.csv", file="data.csv");
    %
    % Notes
    %   Requires a JVM-enabled MATLAB session (R2021b or newer) and valid AWS credentials.

    % Copyright 2025 The MathWorks, Inc.

    properties(Hidden)
        InitializeStatus = false;
        CleanupObj;
    end

    methods
        function obj = TransferManager(varargin)
            initializeLogger(obj, 'Amazon:S3:TransferManager');
            write(obj.logObj, 'verbose', 'Creating Amazon S3 TransferManager Client');

            if ~usejava('jvm')
                write(obj.logObj, 'error', ...
                    'MATLAB must be used with the JVM enabled to access Amazon S3');
            end
            if isMATLABReleaseOlderThan('R2021b')
                write(obj.logObj, 'error', ...
                    'MATLAB Release 2021b or newer is required');
            end

            if nargin == 0
                obj.InitializeStatus = obj.initialize('', '');
            else
                parser = inputParser();
                addParameter(parser, 'credentialsprovider', []);
                addParameter(parser, 'region', []);
                addParameter(parser, 'proxy', []);
                parse(parser, varargin{:});

                credentialsProvider = parser.Results.credentialsprovider;
                region = parser.Results.region;
                if isempty(credentialsProvider)
                    [credentialsProvider, ~] = aws.auth.CredentialProvider.getDefaultCredentialProvider();
                end
                if isempty(region)
                    [~, region] = aws.auth.CredentialProvider.getDefaultCredentialProvider();
                end

                obj.InitializeStatus = obj.initialize(region, credentialsProvider);

                if ~isempty(parser.Results.proxy)
                    obj.ProxyConfiguration = parser.Results.proxy;
                end
            end

            obj.CleanupObj = onCleanup(@() obj.delete());
        end

        function initStat = initialize(obj, region, credentialsprovider)
            % INITIALIZE Configure the MATLAB session to connect to S3 TransferManager

            %% Imports
            import software.amazon.awssdk.services.s3.S3AsyncClient;
            import software.amazon.awssdk.services.s3.S3AsyncClientBuilder;
            import software.amazon.awssdk.regions.Region;
            import software.amazon.awssdk.transfer.s3.S3TransferManager;
            import software.amazon.awssdk.transfer.s3.*;
            import software.amazon.awssdk.regions.GeneratedServiceMetadataProvider;

            initStat = false;

            useMATLABProxyPrefs(obj, 'https://s3.us-east-1.amazonaws.com');

            % Build S3AsyncClient first
            asyncBuilder = S3AsyncClient.crtBuilder();

            if ~isempty(credentialsprovider)
                asyncBuilder.credentialsProvider(credentialsprovider);
            end
            if ~isempty(region)
                if ischar(region)
                    region = Region.of(region);
                end
            else
                [~, region] = aws.auth.CredentialProvider.getDefaultCredentialProvider();
            end

            smdp = GeneratedServiceMetadataProvider();
            amd = smdp.serviceMetadata('s3');
            if ~amd.regions.contains(region)
                error('Amazon Simple Storage Service is not available in region "%s".\n', string(region.toString()));
            end
            asyncBuilder.region(region);

            httpClientBuilder = configProxyHttpClient(obj);
            if ~isempty(httpClientBuilder)
                asyncBuilder.httpClientBuilder(httpClientBuilder);
            end

            s3AsyncClient = asyncBuilder.build();

            % Now build TransferManager
            tmBuilder = S3TransferManager.builder();
            tmBuilder.s3Client(s3AsyncClient);

            obj.Handle = tmBuilder.build();

            if ~isempty(obj.Handle)
                write(obj.logObj, 'verbose', 'TransferManager client initialized');
                initStat = true;
            else
                write(obj.logObj, 'error', 'TransferManager client initialization failed');
            end
        end

        function delete(obj)
            if ~isempty(obj.Handle)
                obj.Handle.close();
            end
        end

    end
end
