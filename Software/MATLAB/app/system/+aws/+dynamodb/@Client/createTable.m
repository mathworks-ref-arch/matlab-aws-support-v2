function createTableResponse = createTable(obj, options)
% CREATETABLE Create a new DynamoDB table.
%
% Syntax
%   resp = ddb.createTable( ...
%       tableName="<name>", ...
%       keySchema=<KeySchemaElement[]>, ...
%       attributeDefinitions=<AttributeDefinition[]>, ...
%       provisionedThroughput=<ProvisionedThroughput>);
%
% Name-Value Arguments
%   tableName             - Table name (string)
%   keySchema             - Primary key schema (array of aws.dynamodb.model.KeySchemaElement)
%   attributeDefinitions  - Attribute definitions (array of aws.dynamodb.model.AttributeDefinition)
%   provisionedThroughput - Provisioned throughput settings (aws.dynamodb.model.ProvisionedThroughput)
%
% Returns
%   aws.dynamodb.model.CreateTableResponse
%
% Example
%   ddb = aws.dynamodb.Client();
%   ks  = aws.dynamodb.model.KeySchemaElement(name="id", keyType="HASH");
%   ad  = aws.dynamodb.model.AttributeDefinition(attributeName="id", attributeType="S");
%   pt  = aws.dynamodb.model.ProvisionedThroughput(readCapacityUnits=int64(5), writeCapacityUnits=int64(5));
%   resp = ddb.createTable(tableName="my_table", keySchema=ks, attributeDefinitions=ad, provisionedThroughput=pt);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.tableName (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.keySchema (1,:) % array of aws.dynamodb.model.KeySchemaElement
    options.attributeDefinitions (1,:) % array of aws.dynamodb.model.AttributeDefinition
    options.provisionedThroughput (1,1) % aws.dynamodb.model.ProvisionedThroughput
end

write(obj.logObj, 'info', 'Creating Table in DynamoDB');

% Create a table request builder
createTableRequestBuilder = software.amazon.awssdk.services.dynamodb.model.CreateTableRequest.builder();

% Call the createTable method from the AWS SDK
createTableRequest = aws.internal.builder.build(createTableRequestBuilder,options);
responseJ = obj.Handle.createTable(createTableRequest);

% Wrap the Java response in a MATLAB CreateTableResponse object
createTableResponse = aws.dynamodb.model.CreateTableResponse(responseJ);
write(obj.logObj, 'info', 'Created Table in DynamoDB');

end
