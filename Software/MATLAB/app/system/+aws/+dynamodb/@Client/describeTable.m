function describeTableResponse = describeTable(obj, options)
% DESCRIBETABLE Fetch metadata for a DynamoDB table.
%
% Syntax
%   resp = ddb.describeTable(tableName="<name>");
%
% Name-Value Arguments
%   tableName - (string, required) DynamoDB table name to inspect.
%
% Returns
%   describeTableResponse - aws.dynamodb.model.DescribeTableResponse containing status,
%                           key schema, throughput, and more.
%
% Example
%   ddb = aws.dynamodb.Client();
%   resp = ddb.describeTable(tableName="users");
%   disp(resp.table.tableStatus);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.tableName (1,1) string {mustBeTextScalar, mustBeNonempty}
end

write(obj.logObj, 'info', ['Describing Table: ', options.tableName]);

% Create a describe table request builder
describeTableRequestBuilder = software.amazon.awssdk.services.dynamodb.model.DescribeTableRequest.builder();


% Build the describe table request
describeTableRequest = aws.internal.builder.build(describeTableRequestBuilder, options);

% Call the describeTable method from the AWS SDK
responseJ = obj.Handle.describeTable(describeTableRequest);

% Wrap the Java response in a MATLAB DescribeTableResponse object
describeTableResponse = aws.dynamodb.model.DescribeTableResponse(responseJ);
write(obj.logObj, 'info', ['Described Table: ', options.tableName]);

end
