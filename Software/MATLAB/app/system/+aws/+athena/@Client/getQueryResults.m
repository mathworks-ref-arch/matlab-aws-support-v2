function getQueryResultsResponse = getQueryResults(obj, options)
%GETQUERYRESULTS Retrieve result rows for an Athena query execution.
%
% Syntax
%   resp = athena.getQueryResults(queryExecutionId="<id>");
%   resp = athena.getQueryResults(queryExecutionId="<id>", ...
%                                 maxResults=int32(1000), nextToken="<token>");
%
% Name-Value Arguments
%   queryExecutionId - (string, required) Athena query execution identifier.
%   maxResults       - (int32, optional) Maximum number of rows per page.
%   nextToken        - (string, optional) Pagination token from a prior call.
%
% Output Arguments
%   getQueryResultsResponse - aws.athena.model.GetQueryResultsResponse containing
%                             the result set and pagination metadata.
%
% Example
%   athena = aws.athena.Client();
%   resp = athena.getQueryResults(queryExecutionId="1234-abcd-5678");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.queryExecutionId (1,1) string {mustBeNonempty}
    options.maxResults (1,1) int32
    options.nextToken (1,1) string
end

write(obj.logObj, 'info', 'Getting query results from Athena');

% Build the GetQueryResultsRequest using a builder utility
builder = software.amazon.awssdk.services.athena.model.GetQueryResultsRequest.builder();

% Build the request
getQueryResultsRequest = aws.internal.builder.build(builder,options);

% Call the getQueryResults method from the AWS SDK
responseJ = obj.Handle.getQueryResults(getQueryResultsRequest);

% Wrap the Java response in a MATLAB GetQueryResultsResponse object
getQueryResultsResponse = aws.athena.model.GetQueryResultsResponse(responseJ);
write(obj.logObj, 'info', 'Fetched query results from Athena');

end
