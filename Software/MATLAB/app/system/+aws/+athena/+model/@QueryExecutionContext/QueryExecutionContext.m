classdef QueryExecutionContext < aws.Object
    %QUERYEXECUTIONCONTEXT MATLAB representation of Athena QueryExecutionContext.
    %
    % Syntax
    %   ctx = aws.athena.model.QueryExecutionContext(database="db", catalog="AwsDataCatalog");
    %   ctx = aws.athena.model.QueryExecutionContext(javaQueryExecutionContext=javaObj);
    %
    % Name-Value Arguments
    %   database                  - (string) Database name visible to the query.
    %   catalog                   - (string) Data catalog identifier.
    %   javaQueryExecutionContext - (software.amazon.awssdk.services.athena.model.QueryExecutionContext)
    %                               Use an existing Java object instead of building a new one.
    %
    % Example
    %   ctx = aws.athena.model.QueryExecutionContext(database="sampledb");

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = QueryExecutionContext(options)
            % Constructor for QueryExecutionContext
            %
            % Usage:
            %   ctx = aws.athena.model.QueryExecutionContext(database="mydb", catalog="AwsDataCatalog");
            arguments
                options.database (1,1) string
                options.catalog (1,1) string
                % java object
                options.javaQueryExecutionContext
            end

            if isfield(options, "javaQueryExecutionContext") && ...
                    isa(options.javaQueryExecutionContext, "software.amazon.awssdk.services.athena.model.QueryExecutionContext")
                obj.Handle = options.javaQueryExecutionContext;
            else
                builder = software.amazon.awssdk.services.athena.model.QueryExecutionContext.builder();

                obj.Handle = aws.internal.builder.build(builder,options);
            end
        end
    end
end
