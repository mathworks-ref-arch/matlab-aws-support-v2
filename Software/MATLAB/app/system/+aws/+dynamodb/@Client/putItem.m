function putItemResponse = putItem(obj, options)
% PUTITEM Insert or replace an item in a DynamoDB table.
%
% Syntax
%   resp = ddb.putItem(tableName="<name>", item=itemMap);
%
% Name-Value Arguments
%   tableName - (string, required) DynamoDB table name.
%   item      - (dictionary | struct, required) Attribute map where each value is an
%               `aws.dynamodb.model.AttributeValue`.
%
% Returns
%   putItemResponse - aws.dynamodb.model.PutItemResponse containing consumed capacity and metadata.
%
% Example
%   ddb = aws.dynamodb.Client();
%   item = dictionary( ...
%       ["pk","sk","name"], ...
%       [aws.dynamodb.model.AttributeValue(s="user#123"), ...
%        aws.dynamodb.model.AttributeValue(s="profile"), ...
%        aws.dynamodb.model.AttributeValue(s="Ada Lovelace")]);
%   resp = ddb.putItem(tableName="users", item=item);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.tableName (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.item (1,1) dictionary % A dictionary representing the item attributes and their values
end

write(obj.logObj, 'info', 'Putting Item in DynamoDB');

% Create a PutItemRequest builder
putItemRequestBuilder = software.amazon.awssdk.services.dynamodb.model.PutItemRequest.builder();

putItemRequest = aws.internal.builder.build(putItemRequestBuilder,options);
% Call the putItem method from the AWS SDK
responseJ = obj.Handle.putItem(putItemRequest);

% Wrap the Java response in a MATLAB PutItemResponse object
putItemResponse = aws.dynamodb.model.PutItemResponse(responseJ);
write(obj.logObj, 'info', 'Put Item in DynamoDB');

end
