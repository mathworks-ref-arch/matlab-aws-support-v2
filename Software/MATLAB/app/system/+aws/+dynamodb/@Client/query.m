function queryResponse = query(obj, options)
% QUERY Run a key-condition query against a DynamoDB table.
%
% Syntax
%   resp = ddb.query( ...
%       tableName="<name>", ...
%       keyConditionExpression="pk = :pk", ...
%       expressionAttributeValues=vals);
%
% Name-Value Arguments
%   tableName                - (string, required) DynamoDB table to query.
%   keyConditionExpression   - (string, required) Expression using partition key (and optional sort key).
%   expressionAttributeValues - (dictionary) Map of tokens (e.g., `:pk`) to AttributeValue objects.
%
% Returns
%   queryResponse - aws.dynamodb.model.QueryResponse containing matching items and metadata.
%
% Example
%   ddb = aws.dynamodb.Client();
%   vals = dictionary(":pk", aws.dynamodb.model.AttributeValue(s="user#123"));
%   resp = ddb.query( ...
%       tableName="users", ...
%       keyConditionExpression="pk = :pk", ...
%       expressionAttributeValues=vals);
%   disp(resp.count);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.tableName (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.keyConditionExpression (1,1) string {mustBeNonempty}
    options.expressionAttributeValues dictionary = dictionary()
end

write(obj.logObj, 'info', 'Querying Items in DynamoDB');

% Call the query method from the AWS SDK
queryRequestBuilder = software.amazon.awssdk.services.dynamodb.model.QueryRequest.builder();
queryRequest = aws.internal.builder.build(queryRequestBuilder,options);
responseJ = obj.Handle.query(queryRequest);

% Wrap the Java response in a MATLAB QueryResponse object
queryResponse = aws.dynamodb.model.QueryResponse(responseJ);
write(obj.logObj, 'info', 'Queried Items in DynamoDB');

end
