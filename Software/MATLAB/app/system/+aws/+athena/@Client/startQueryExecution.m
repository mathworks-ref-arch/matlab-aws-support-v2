function startQueryExecutionResponse = startQueryExecution(obj, options)
%STARTQUERYEXECUTION Submit a SQL statement to Amazon Athena.
%
% Syntax
%   resp = athena.startQueryExecution( ...
%       queryString="<SQL>", ...
%       resultConfiguration=<aws.athena.model.ResultConfiguration>, ...
%       queryExecutionContext=<aws.athena.model.QueryExecutionContext>, ...
%       clientRequestToken="<token>", workGroup="<name>");
%
% Name-Value Arguments
%   queryString           - (string, required) SQL statement to execute.
%   resultConfiguration   - (aws.athena.model.ResultConfiguration, required)
%                           Output location and encryption settings.
%   queryExecutionContext - (aws.athena.model.QueryExecutionContext, optional)
%                           Database/catalog selection.
%   clientRequestToken    - (string, optional) Idempotency token for retries.
%   workGroup             - (string, optional) Target Athena workgroup.
%
% Output Arguments
%   startQueryExecutionResponse - aws.athena.model.StartQueryExecutionResponse containing
%                                 the new queryExecutionId and metadata.
%
% Example
%   rc = aws.athena.model.ResultConfiguration(outputLocation="s3://bucket/results/");
%   qc = aws.athena.model.QueryExecutionContext(database="sample_db");
%   resp = athena.startQueryExecution( ...
%       queryString="SELECT * FROM sample_table LIMIT 10", ...
%       resultConfiguration=rc, ...
%       queryExecutionContext=qc);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.queryString (1,1) string {mustBeNonempty}
    options.resultConfiguration (1,1) aws.athena.model.ResultConfiguration
    options.queryExecutionContext (1,1) aws.athena.model.QueryExecutionContext

end

write(obj.logObj, 'info', 'Starting Query Execution in Athena');
write(obj.logObj, 'verbose', options.queryString);

% Build the StartQueryExecutionRequest using a builder utility
builder = software.amazon.awssdk.services.athena.model.StartQueryExecutionRequest.builder();



% Build the request
startQueryExecutionRequest = aws.internal.builder.build(builder, options);

% Call the startQueryExecution method from the AWS SDK
responseJ = obj.Handle.startQueryExecution(startQueryExecutionRequest);

% Wrap the Java response in a MATLAB StartQueryExecutionResponse object
startQueryExecutionResponse = aws.athena.model.StartQueryExecutionResponse(responseJ);
write(obj.logObj, 'info', 'Started query execution in Athena');

end
