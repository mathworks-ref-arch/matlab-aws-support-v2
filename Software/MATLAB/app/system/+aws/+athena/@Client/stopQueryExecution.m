function stopQueryExecutionResponse = stopQueryExecution(obj, options)
%STOPQUERYEXECUTION Cancel a running Athena query.
%
% Syntax
%   resp = athena.stopQueryExecution(queryExecutionId="<id>");
%
% Name-Value Arguments
%   queryExecutionId - (string, required) Query execution identifier to cancel.
%
% Output Arguments
%   stopQueryExecutionResponse - aws.athena.model.StopQueryExecutionResponse confirming
%                                the cancel request.
%
% Example
%   resp = athena.stopQueryExecution(queryExecutionId="1234-abcd");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.queryExecutionId (1,1) string {mustBeTextScalar, mustBeNonempty}
end

write(obj.logObj, 'info', 'Stopping Query Execution in Athena');
write(obj.logObj, 'info', options.queryExecutionId);

% Create a StopQueryExecutionRequest builder
builder = software.amazon.awssdk.services.athena.model.StopQueryExecutionRequest.builder();


% Build the request
stopQueryExecutionRequest = aws.internal.builder.build(builder,options);

% Call the stopQueryExecution method from the AWS SDK
responseJ = obj.Handle.stopQueryExecution(stopQueryExecutionRequest);

% Wrap the Java response in a MATLAB StopQueryExecutionResponse object
stopQueryExecutionResponse = aws.athena.model.StopQueryExecutionResponse(responseJ);
write(obj.logObj, 'info', 'Stopped Query Execution in Athena');

end
