function listTablesResponse = listTables(obj, options)
% LISTTABLES Enumerate DynamoDB table names.
%
% Syntax
%   resp = ddb.listTables();
%   resp = ddb.listTables(limit=10);
%
% Name-Value Arguments
%   limit - (double) Maximum number of table names to return (default: all tables).
%
% Returns
%   listTablesResponse - aws.dynamodb.model.ListTablesResponse containing table names and continuation token.
%
% Example
%   ddb = aws.dynamodb.Client();
%   resp = ddb.listTables(limit=10);
%   disp(resp.tableNames);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.limit (1,1) double {mustBePositive} = inf
end

write(obj.logObj, 'info', 'Listing Tables in DynamoDB');


listTablesRequestBuilder = software.amazon.awssdk.services.dynamodb.model.ListTablesRequest.builder();

if isfinite(options.limit)
    listTablesRequestBuilder = listTablesRequestBuilder.limit(options.limit);
end

listTablesRequest = listTablesRequestBuilder.build();

% Call the listTables method from the AWS SDK
responseJ = obj.Handle.listTables(listTablesRequest);

% Wrap the Java response in a MATLAB ListTablesResponse object
listTablesResponse = aws.dynamodb.model.ListTablesResponse(responseJ);
write(obj.logObj, 'info', 'Listed Tables in DynamoDB');

end
