classdef (Abstract) BaseClient < aws.Object
    %BASECLIENT Abstract base class for AWS service clients.
    % Provides shared functionality for initializing AWS clients.

    % Copyright 2025 The MathWorks, Inc.

    properties(Hidden)
        InitializeStatus = false;
        CleanupObj;
        isCrt (1,1) logical = false;
        serviceId (1,1) string = "";
    end

    methods (Abstract, Access=protected)
        initStat = initialize(obj, regionObj, credentialsProvider)
    end

    methods
        function obj = BaseClient(serviceId, varargin)
            % Initialize logger
            servicePrefix = "AMAZON:" + upper(serviceId);
            obj.initializeLogger(servicePrefix);
            write(obj.logObj, 'verbose', ['Creating AWS Client for ', servicePrefix]);

            % JVM and MATLAB version checks
            if ~usejava('jvm')
                write(obj.logObj, 'error', ['MATLAB must be used with the JVM enabled to access ', servicePrefix]);
            end
            if isMATLABReleaseOlderThan('R2021b')
                write(obj.logObj, 'error', 'MATLAB Release 2021b or newer is required');
            end

            % Parse input arguments
            parser = inputParser();
            addParameter(parser, 'credentialsprovider', []);
            addParameter(parser, 'region', []);
            addParameter(parser, 'isCrt', false, @(x) islogical(x) || (isnumeric(x) && isscalar(x)));
            parse(parser, varargin{:});

            credentialsProvider = parser.Results.credentialsprovider;
            region = parser.Results.region;
            obj.isCrt = logical(parser.Results.isCrt);

            % Sometimes Credential Provider is passed in which case do not
            % use the default credential provider from default chain. 
            if isempty(credentialsProvider)
                [credentialsProvider, ~] = aws.auth.CredentialProvider.getDefaultCredentialProvider();
            end
            % Sometimes region is passed in which case do not
            % use the region from default provider chain.
            if isempty(region)
                [~, region] = aws.auth.CredentialProvider.getDefaultCredentialProvider();
            end

            % Store service identifier
            obj.serviceId = string(serviceId);

            regionObj = obj.validateRegion(region, serviceId);

            % Call subclass-specific initialization
            obj.InitializeStatus = obj.initialize(regionObj, credentialsProvider);

            % Setup cleanup
            obj.CleanupObj = onCleanup(@() obj.delete());
        end

        function delete(obj)
            if ~isempty(obj.Handle)
                obj.Handle.close();
            end
        end

        function regionObj = validateRegion(~, region, serviceId)
            import software.amazon.awssdk.regions.Region;
            if ischar(region)
                regionObj = Region.of(region);
            else
                regionObj = region;
            end

            import software.amazon.awssdk.regions.GeneratedServiceMetadataProvider;
            smdp = GeneratedServiceMetadataProvider();
            amd = smdp.serviceMetadata(serviceId);
            if ~amd.regions.contains(regionObj)
                error('AWS service "%s" is not available in region "%s".', ...
                    serviceId, string(regionObj.toString()));
            end
        end

        function builder = applyHttpClientBuilder(obj, builder, options)
            arguments
                obj
                builder
                options.isCrt logical = false
            end
            import software.amazon.awssdk.http.crt.AwsCrtHttpClient;
            if options.isCrt
                % Use AwsCrtHttpClient for all clients
                builder.httpClientBuilder(AwsCrtHttpClient.builder());
            else
                % Configure an apache http client if need for proxy support
                httpClientBuilder = configProxyHttpClient(obj);
                if ~isempty(httpClientBuilder)
                    builder.httpClientBuilder(httpClientBuilder);
                end
            end
        end
    end
end
