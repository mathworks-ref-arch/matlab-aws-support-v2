function getItemResponse = getItem(obj, options)
% GETITEM Retrieve a single item from a DynamoDB table.
%
% Syntax
%   resp = ddb.getItem(tableName="<name>", key=keyMap);
%
% Name-Value Arguments
%   tableName - (string, required) DynamoDB table name.
%   key       - (dictionary | struct, required) Primary key map where each value is an
%               `aws.dynamodb.model.AttributeValue`.
%
% Returns
%   getItemResponse - aws.dynamodb.model.GetItemResponse containing the item attributes and metadata.
%
% Example
%   ddb = aws.dynamodb.Client();
%   key = dictionary("pk", aws.dynamodb.model.AttributeValue(s="user#123"));
%   resp = ddb.getItem(tableName="users", key=key);
%   disp(resp.item);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.tableName (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.key (1,1) dictionary % Primary key attributes (AttributeValue map)
end

write(obj.logObj, 'info', 'Getting Item from DynamoDB');

% Create a getItemRequest builder
getItemRequestBuilder = software.amazon.awssdk.services.dynamodb.model.GetItemRequest.builder();

% Build the getItemRequest
getItemRequest = aws.internal.builder.build(getItemRequestBuilder,options);


% Call the getItem method from the AWS SDK
responseJ = obj.Handle.getItem(getItemRequest);

% Wrap the Java response in a MATLAB GetItemResponse object
getItemResponse = aws.dynamodb.model.GetItemResponse(responseJ);
write(obj.logObj, 'info', 'Retrieved Item from DynamoDB');

end
