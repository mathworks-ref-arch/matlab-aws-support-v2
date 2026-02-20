## ☁️ 6.3 DynamoDB

MATLAB client for Amazon DynamoDB. Create tables, perform CRUD operations, and use waiters for table state.

```matlab
ddb = aws.dynamodb.Client();
```

### 🔧 6.3.1 List of Available Methods

- [createTable](AWSSDKAPI.md#awsdynamodbclientcreatetable)  
- [deleteTable](AWSSDKAPI.md#awsdynamodbclientdeletetable)  
- [describeTable](AWSSDKAPI.md#awsdynamodbclientdescribetable)  
- [listTables](AWSSDKAPI.md#awsdynamodbclientlisttables)  
- [putItem](AWSSDKAPI.md#awsdynamodbclientputitem)  
- [getItem](AWSSDKAPI.md#awsdynamodbclientgetitem)  
- [updateItem](AWSSDKAPI.md#awsdynamodbclientupdateitem)  
- [deleteItem](AWSSDKAPI.md#awsdynamodbclientdeleteitem)  
- [query](AWSSDKAPI.md#awsdynamodbclientquery)  
- [batchWriteItem](AWSSDKAPI.md#awsdynamodbclientbatchwriteitem)  

### 🧩 6.3.2 Examples

Create a table (simplified)
```matlab
ddb = aws.dynamodb.Client();

keySchema = aws.dynamodb.model.KeySchemaElement(name="id", keyType="HASH");
attrDef   = aws.dynamodb.model.AttributeDefinition(attributeName="id", attributeType="S");
thruput   = aws.dynamodb.model.ProvisionedThroughput(readCapacityUnits=int64(5), writeCapacityUnits=int64(5));

ct = ddb.createTable(tableName="matlab-demo", keySchema=keySchema, attributeDefinitions=attrDef, provisionedThroughput=thruput);
```

Put and get an item
```matlab
item = dictionary;
item("id")   = aws.dynamodb.model.AttributeValue.s("123");
item("name") = aws.dynamodb.model.AttributeValue.s("Alice");
ddb.putItem(tableName="matlab-demo", item=item);

key = dictionary("id", aws.dynamodb.model.AttributeValue.s("123"));
gr = ddb.getItem(tableName="matlab-demo", key=key);
```

### 📘 6.3.3 Method Reference (Summary)

#### 🔸 `createTable`
```matlab
ct = ddb.createTable(tableName="<name>", keySchema=<KeySchemaElement>, attributeDefinitions=<AttributeDefinition>, provisionedThroughput=<ProvisionedThroughput>);
```
*   Returns: `aws.dynamodb.model.CreateTableResponse`

#### 🔸 `deleteTable`
```matlab
ddb.deleteTable(tableName="<name>");
```
*   Returns: `aws.dynamodb.model.DeleteTableResponse`

#### 🔸 `describeTable`
```matlab
dt = ddb.describeTable(tableName="<name>");
```
*   Returns: `aws.dynamodb.model.DescribeTableResponse`

#### 🔸 `listTables`
```matlab
lt = ddb.listTables();
```
*   Returns: `aws.dynamodb.model.ListTablesResponse`

#### 🔸 `putItem`
```matlab
ddb.putItem(tableName="<name>", item=<dictionary>);
```
*   Returns: `aws.dynamodb.model.PutItemResponse`

#### 🔸 `getItem`
```matlab
gr = ddb.getItem(tableName="<name>", key=<dictionary>);
```
*   Returns: `aws.dynamodb.model.GetItemResponse`

#### 🔸 `updateItem`
```matlab
ur = ddb.updateItem(tableName="<name>", key=<dictionary>, updateExpression="SET #n = :v", expressionAttributeNames=dictionary("#n","name"), expressionAttributeValues=dictionary(":v", aws.dynamodb.model.AttributeValue.s("Bob")));
```
*   Returns: `aws.dynamodb.model.UpdateItemResponse`

#### 🔸 `deleteItem`
```matlab
ddb.deleteItem(tableName="<name>", key=<dictionary>);
```
*   Returns: `aws.dynamodb.model.DeleteItemResponse`

#### 🔸 `query`
```matlab
qr = ddb.query(tableName="<name>", keyConditionExpression="id = :id", expressionAttributeValues=dictionary(":id", aws.dynamodb.model.AttributeValue.s("123")));
```
*   Returns: `aws.dynamodb.model.QueryResponse`

#### 🔸 `batchWriteItem`
```matlab
bwr = ddb.batchWriteItem(requestItems=<dictionary>);
```
*   Returns: `aws.dynamodb.model.BatchWriteItemResponse`

```{seealso}
🔗 Data Models: TableDescription, AttributeDefinition, KeySchemaElement, ProvisionedThroughput, AttributeValue, PutItemResponse, GetItemResponse, QueryResponse, UpdateItemResponse, DeleteItemResponse, BatchWriteItemResponse, DescribeTableResponse, ListTablesResponse
```
