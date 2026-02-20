classdef Client < aws.core.BaseClient
    % CLIENT MATLAB client for the Amazon Redshift Data API.
    %
    % Syntax
    %   rsData = aws.redshiftdata.Client();
    %   rsData = aws.redshiftdata.Client('region',"us-east-1", 'credentialsprovider', provider);
    %
    % Name-Value Arguments
    %   'region'              - (string | software.amazon.awssdk.regions.Region) Target Region.
    %   'credentialsprovider' - (aws.auth.CredentialProvider) Credential chain override.
    %   'isCrt'               - (logical) Use the AWS Common Runtime HTTP client when true.
    %
    % Example
    %   rs = aws.redshiftdata.Client('region',"us-east-1");
    %   resp = rs.executeStatement(sql="SELECT 1", clusterIdentifier="demo", database="dev");

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = Client(varargin)
            % Endpoint prefix: 'redshift-data'
            obj@aws.core.BaseClient('redshift', varargin{:});
        end
    end

    methods (Access = protected)
        function initStat = initialize(obj, regionObj, credentialsProvider)
            import software.amazon.awssdk.services.redshiftdata.RedshiftDataClient;

            initStat = false;
            builder = RedshiftDataClient.builder();
            builder.region(regionObj);

            if ~isempty(credentialsProvider)
                builder.credentialsProvider(credentialsProvider);
            end

            % Redshift Data works fine with CRT or Apache; keep default (CRT)
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
