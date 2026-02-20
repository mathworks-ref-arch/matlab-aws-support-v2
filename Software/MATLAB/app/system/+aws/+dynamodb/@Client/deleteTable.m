function deleteTableResponse = deleteTable(obj, options)
% DELETETABLE Delete a DynamoDB table.
%
% Syntax
%   resp = ddb.deleteTable(tableName="<name>");
%
% Name-Value Arguments
%   tableName - (string, required) DynamoDB table name slated for deletion.
%
% Returns
%   deleteTableResponse - aws.dynamodb.model.DeleteTableResponse containing table status and metadata.
%
% Example
%   ddb = aws.dynamodb.Client();
%   resp = ddb.deleteTable(tableName="users");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.tableName (1,1) string {mustBeTextScalar, mustBeNonempty}
end

write(obj.logObj, 'info', 'Deleting Table in DynamoDB');

% Create a table deletion request builder
deleteTableRequestBuilder = software.amazon.awssdk.services.dynamodb.model.DeleteTableRequest.builder();
% deleteTableRequestBuilder = deleteTableRequestBuilder.tableName(options.tableName);
deleteTableRequest = aws.internal.builder.build(deleteTableRequestBuilder,options);

% Call the deleteTable method from the AWS SDK
responseJ = obj.Handle.deleteTable(deleteTableRequest);

% Wrap the Java response in a MATLAB DeleteTableResponse object
deleteTableResponse = aws.dynamodb.model.DeleteTableResponse(responseJ);

write(obj.logObj, 'info', 'Deleted Table in DynamoDB');

end
