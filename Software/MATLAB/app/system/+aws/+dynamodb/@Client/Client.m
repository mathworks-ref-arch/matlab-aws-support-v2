classdef Client < aws.core.BaseClient
    %CLIENT Amazon DynamoDB Client
    %
    % This client is used to interact with the Amazon DynamoDB service, allowing
    % you to perform operations such as creating tables, querying, and scanning items.
    %
    % Example:
    %       dynamoDB = aws.dynamodb.Client();
    %       % Perform operations with DynamoDB
    %       tableDescription = dynamoDB.createTable('myTableName', ...);
    %
    % Authentication Credentials - Please see the authentication section
    % of the documentation for more details.

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = Client(varargin)
            obj@aws.core.BaseClient('dynamodb', varargin{:});
        end
    end

    methods (Access = protected)
        function initStat = initialize(obj, regionObj, credentialsProvider)
            import software.amazon.awssdk.services.dynamodb.DynamoDbClient;

            initStat = false;
            builder = DynamoDbClient.builder();
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
