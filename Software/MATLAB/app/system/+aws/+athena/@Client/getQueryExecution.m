function getQueryExecutionResponse = getQueryExecution(obj, options)
%GETQUERYEXECUTION Retrieve query execution metadata from Amazon Athena.
%
% Syntax
%   resp = athena.getQueryExecution(queryExecutionId="<id>");
%
% Name-Value Arguments
%   queryExecutionId - (string, required) Athena query execution identifier.
%
% Output Arguments
%   getQueryExecutionResponse - aws.athena.model.GetQueryExecutionResponse containing
%                               status details, timestamps, and IDs.
%
% Example
%   athena = aws.athena.Client();
%   resp = athena.getQueryExecution(queryExecutionId="1234abcd-5678-efgh");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.queryExecutionId (1,1) string {mustBeNonempty}
end

write(obj.logObj, 'info', ['Retrieving Query Execution for ID: ' options.queryExecutionId]);

% Build the GetQueryExecutionRequest using the AWS SDK builder
builder = software.amazon.awssdk.services.athena.model.GetQueryExecutionRequest.builder();

getQueryExecutionRequest = aws.internal.builder.build(builder,options);

% Call the getQueryExecution method from the AWS SDK
responseJ = obj.Handle.getQueryExecution(getQueryExecutionRequest);

% Wrap the Java response in a MATLAB GetQueryExecutionResponse object
getQueryExecutionResponse = aws.athena.model.GetQueryExecutionResponse(responseJ);
write(obj.logObj, 'info', 'Retrieved query execution from Athena');

end
