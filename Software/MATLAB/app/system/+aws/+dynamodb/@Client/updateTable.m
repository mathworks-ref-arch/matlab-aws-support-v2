function updateTableResponse = updateTable(obj, options)
% UPDATETABLE Modify DynamoDB table settings.
%
% Syntax
%   resp = ddb.updateTable(tableName="Orders", provisionedThroughput=pt);
%
% Name-Value Arguments
%   tableName             - (string, required) Table to update.
%   provisionedThroughput - (aws.dynamodb.model.ProvisionedThroughput, required)
%                           Updated read/write capacity configuration.
%
% Returns
%   updateTableResponse - aws.dynamodb.model.UpdateTableResponse containing the
%                         latest table description and status.
%
% Example
%   ddb = aws.dynamodb.Client();
%   pt = aws.dynamodb.model.ProvisionedThroughput( ...
%       readCapacityUnits=int64(10), writeCapacityUnits=int64(5));
%   resp = ddb.updateTable(tableName="Orders", provisionedThroughput=pt);
%   disp(resp.tableDescription.tableStatus);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.tableName (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.provisionedThroughput (1,1) aws.dynamodb.model.ProvisionedThroughput % Required - Provisioned throughput configuration
end

write(obj.logObj, 'verbose', 'Updating Table in DynamoDB');

% Create an UpdateTableRequest builder
updateTableRequestBuilder = software.amazon.awssdk.services.dynamodb.model.UpdateTableRequest.builder();
% Build the UpdateTableRequest
updateTableRequest = aws.internal.builder.build(updateTableRequestBuilder,options);

% Call the updateTable method from the AWS SDK
responseJ = obj.Handle.updateTable(updateTableRequest);

% Wrap the Java response in a MATLAB UpdateTableResponse object
updateTableResponse = aws.dynamodb.model.UpdateTableResponse(responseJ);
write(obj.logObj, 'verbose', 'Updated Table in DynamoDB');

end
