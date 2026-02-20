function deleteItemResponse = deleteItem(obj, options)
% DELETEITEM Remove a single item from a DynamoDB table.
%
% Syntax
%   resp = ddb.deleteItem(tableName="<name>", key=keyMap);
%
% Name-Value Arguments
%   tableName - (string, required) DynamoDB table name.
%   key       - (dictionary | struct, required) Primary key map using `aws.dynamodb.model.AttributeValue`.
%
% Returns
%   deleteItemResponse - aws.dynamodb.model.DeleteItemResponse containing consumed capacity and metadata.
%
% Example
%   ddb = aws.dynamodb.Client();
%   key = dictionary("pk", aws.dynamodb.model.AttributeValue(s="user#123"));
%   resp = ddb.deleteItem(tableName="users", key=key);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.tableName (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.key dictionary {mustBeNonempty} % A map representing the key attributes of the item
end

write(obj.logObj, 'info', 'Deleting Item from DynamoDB');

% Create a DeleteItemRequest builder
deleteItemRequestBuilder = software.amazon.awssdk.services.dynamodb.model.DeleteItemRequest.builder();

% Build the DeleteItemRequest
deleteItemRequest = aws.internal.builder.build(deleteItemRequestBuilder,options);


% Call the deleteItem method from the AWS SDK
responseJ = obj.Handle.deleteItem(deleteItemRequest);

% Wrap the Java response in a MATLAB DeleteItemResponse object
deleteItemResponse = aws.dynamodb.model.DeleteItemResponse(responseJ);
write(obj.logObj, 'info', 'Deleted Item from DynamoDB');

end
