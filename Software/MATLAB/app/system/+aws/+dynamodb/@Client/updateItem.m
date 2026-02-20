function updateItemResponse = updateItem(obj, options)
% UPDATEITEM Modify attributes of an existing DynamoDB item.
%
% Syntax
%   resp = ddb.updateItem( ...
%       tableName="<name>", ...
%       key=keyMap, ...
%       updateExpression="SET #n = :val", ...
%       expressionAttributeValues=exprVals);
%
% Name-Value Arguments
%   tableName                - (string, required) DynamoDB table name.
%   key                      - (dictionary | struct, required) Primary key map using AttributeValue objects.
%   updateExpression         - (string, required) DynamoDB update expression.
%   expressionAttributeValues - (dictionary) Map of tokens (`:val`) to AttributeValue objects.
%   returnValues             - (string) Return mode (e.g., `"ALL_NEW"`).
%
% Returns
%   updateItemResponse - aws.dynamodb.model.UpdateItemResponse containing updated attributes and metadata.
%
% Example
%   ddb = aws.dynamodb.Client();
%   key = dictionary("pk", aws.dynamodb.model.AttributeValue(s="user#123"));
%   exprVals = dictionary(":name", aws.dynamodb.model.AttributeValue(s="Ada"));
%   resp = ddb.updateItem( ...
%       tableName="users", ...
%       key=key, ...
%       updateExpression="SET #n = :name", ...
%       expressionAttributeValues=exprVals, ...
%       returnValues="ALL_NEW");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.tableName (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.key (1,1) dictionary % Primary key attributes
    options.updateExpression (1,1) string {mustBeNonempty}
    options.expressionAttributeValues dictionary
    options.returnValues (1,1) string
end

write(obj.logObj, 'info', 'Updating Item in DynamoDB');

% Create an UpdateItemRequest builder

updateItemRequestBuilder = software.amazon.awssdk.services.dynamodb.model.UpdateItemRequest.builder();
updateItemRequest = aws.internal.builder.build(updateItemRequestBuilder,options);
responseJ = obj.Handle.updateItem(updateItemRequest);

% Wrap the Java response in a MATLAB UpdateItemResponse object
updateItemResponse = aws.dynamodb.model.UpdateItemResponse(responseJ);
write(obj.logObj, 'info', 'Updated Item in DynamoDB');

end
