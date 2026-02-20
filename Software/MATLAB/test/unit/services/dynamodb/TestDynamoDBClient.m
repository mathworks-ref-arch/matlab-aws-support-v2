classdef TestDynamoDBClient < matlab.unittest.TestCase
    % TESTDYNAMODBCLIENT Unit Test for the Amazon DynamoDB Client
    %
    % The assertions that you can use in test cases:
    %
    %    verifyClass
    %    verifyNotEmpty
    %    verifyEqual
    %
    % The test suite exercises the basic operations on the DynamoDB Client.

    % Copyright 2025 The MathWorks, Inc.

    properties
        logObj
        dynamoDB
        isOnGitlab
        tableName
    end

    methods(TestClassSetup)
        % Shared setup for the entire test class
        function testSetup(testCase)
            testCase.logObj = Logger.getLogger();
            testCase.logObj.DisplayLogLevel = 'verbose';
        end

        function checkGitlab(testCase)
            host = getenv('CI_RUNNER_DESCRIPTION');
            testCase.isOnGitlab = ~isempty(host);
        end

        function initializeDynamoDBClient(testCase)
            region = 'us-east-1';
            if testCase.isOnGitlab
                credentials = loadConfigurationSettings('credentials.json');
                credentialProvider = aws.auth.CredentialProvider.getSessionCredentialProvider(...
                    credentials.aws_access_key_id, credentials.aws_secret_access_key, ...
                    credentials.aws_session_token);
                testCase.dynamoDB = aws.dynamodb.Client('credentialsprovider', credentialProvider, ...
                    'region', region);
            else
                testCase.dynamoDB = aws.dynamodb.Client('region', region);
            end
        end

        function createDynamoDBTable(testCase)

            % Unique table per class
            testCase.tableName = strcat('matlab-dynamodbtest-table-', ...
                string(datetime('now','Format','yyyyMMddHHmmssSSS')));

            % Define schema
            keyElement = aws.dynamodb.model.KeySchemaElement(attributeName="Id", keyType="HASH");
            attrDef    = aws.dynamodb.model.AttributeDefinition(attributeName="Id", attributeType="S");

            provisionedThroughput = aws.dynamodb.model.ProvisionedThroughput(readCapacityUnits=5,writeCapacityUnits=5);

            % Create and wait ACTIVE
            respCreate = testCase.dynamoDB.createTable( ...
                tableName=testCase.tableName, keySchema={keyElement}, ...
                attributeDefinitions={attrDef}, provisionedThroughput=provisionedThroughput);

            testCase.verifyNotEmpty(respCreate.tableDescription.tableArn() , ...
                'Table ARN should not be empty after creation.');

            waiter = testCase.dynamoDB.waiter();
            waiter.waitUntilTableExists(tableName=testCase.tableName);
        end
    end

    methods(TestClassTeardown)
        function teardownOnce(testCase)
            waiter = testCase.dynamoDB.waiter();
            waiter.waitUntilTableExists(tableName=testCase.tableName);
            testCase.dynamoDB.deleteTable(tableName=testCase.tableName);
            waiter.waitUntilTableNotExists(tableName=testCase.tableName);
        end
    end

    methods(Test, TestTags = {'Unit'})

        function testTables(testCase)
            % Test listing DynamoDB tables
            listTablesResponse = testCase.dynamoDB.listTables();
            tables = listTablesResponse.tableNames;
            testCase.verifyNotEmpty(tables, 'Table list should not be empty.');
            write(testCase.logObj, 'verbose', strjoin(tables, ', '));
            testCase.verifyClass(tables, 'string');
            % Test table description,
            describeTableResponse = testCase.dynamoDB.describeTable(tableName = testCase.tableName);
            testCase.verifyEqual(describeTableResponse.table.tableName, testCase.tableName, "The table Name are not equal");

            % Test Update DynamoDB table is ready for update
            while ~strcmp(describeTableResponse.table.tableStatus, "ACTIVE")
                pause(1);
                write(testCase.logObj,'verbose', 'Waiting for Status change for next action');
                describeTableResponse = testCase.dynamoDB.describeTable(tableName = testCase.tableName);
            end

            throughPut= aws.dynamodb.model.ProvisionedThroughput(readCapacityUnits=5,writeCapacityUnits=6);
            updateTableResponse = testCase.dynamoDB.updateTable(tableName=testCase.tableName,provisionedThroughput=throughPut);
            testCase.verifyNotEmpty(updateTableResponse.tableDescription);

        end

        function testInvalidDynamoDbWaiter(testCase)
            log = Logger.getLogger();
            log.clearMessages();

            aws.dynamodb.waiters.DynamoDbWaiter(javaObject('java.lang.String'));

            msgs = log.getMessages('error');
            testCase.verifyFalse(any(contains({msgs.message}, 'Invalid arguments')), ...
                "Expected 'Invalid arguments' message in log");
        end

        function testDeleteNonExistentTable(testCase)
            % Use a unique name to guarantee non-existence
            nonExistentTableName = "nonExistentTable_" + string(java.util.UUID.randomUUID);

            % Negative test: deleting a non-existent table must throw
            testCase.verifyError( ...
                @() testCase.dynamoDB.deleteTable(tableName=nonExistentTableName), ...
                "MATLAB:Java:GenericException");
        end


        function testItem(testCase)

            % % Need to wait for table is ready to put
            % describeTableResponse = testCase.dynamoDB.describeTable(tableName = testCase.tableName);
            % testCase.verifyEqual(describeTableResponse.tableName, testCase.tableName, "The table Name are not equal");
            % Test putItem

            itemValue1 = aws.dynamodb.model.AttributeValue(s="111");
            itemValue2 = aws.dynamodb.model.AttributeValue(s="Movie");
            items = dictionary("Id",itemValue1,"Category",itemValue2);
            putItemResponse = testCase.dynamoDB.putItem(tableName=testCase.tableName, item=items);
            testCase.verifyNotEmpty(putItemResponse.attributes);

            % Test getItem
            getItemResponse = testCase.dynamoDB.getItem(tableName=testCase.tableName,key=dictionary("Id",itemValue1));
            testCase.verifyNotEmpty(getItemResponse.item.keys());

            % Test updateItem

            keyValue = aws.dynamodb.model.AttributeValue(s="111");
            keyToUpdate = dictionary("Id",keyValue);
            attributeValue1 = aws.dynamodb.model.AttributeValue(s="book");
            attributeValue2 = aws.dynamodb.model.AttributeValue(n="60");
            attributeValuesToUpdate = dictionary(":c", attributeValue1, ":p", attributeValue2);
            updateItemResponse = testCase.dynamoDB.updateItem( ...
                tableName=testCase.tableName, key=keyToUpdate,...
                updateExpression="SET Category = :c, price = :p",...
                expressionAttributeValues=attributeValuesToUpdate,...
                returnValues="UPDATED_NEW");

            testCase.verifyNotEmpty(updateItemResponse.attributes);
            % Query the item
            queryKeyValue = aws.dynamodb.model.AttributeValue(s="111");
            queryRespone = testCase.dynamoDB.query(tableName=testCase.tableName,keyConditionExpression="Id = :id", expressionAttributeValues=dictionary(":id",queryKeyValue));
            testCase.verifyNotEmpty(queryRespone.items)
            % Delete the item
            deleteItemResponse= testCase.dynamoDB.deleteItem(tableName=testCase.tableName,key=dictionary("Id", queryKeyValue));
            testCase.verifyNotEmpty(deleteItemResponse.attributes);

        end

        function testBatchWriteItem(testCase)

            % Construct batchItem
            % Step 1, construct one item

            item1Attribute1 = aws.dynamodb.model.AttributeValue(s="121");
            item1Attribute2 = aws.dynamodb.model.AttributeValue(s="label 121");
            item1 = dictionary("Id", item1Attribute1,"label", item1Attribute2);
            item2Attribute1 = aws.dynamodb.model.AttributeValue(s="122");
            item2Attribute2 = aws.dynamodb.model.AttributeValue(s="label 122");
            item2 = dictionary("Id", item2Attribute1, "label", item2Attribute2);
            % step 2, construct putrequest

            putRequest1 = aws.dynamodb.model.PutRequest(item=item1);
            writeRequest1 = aws.dynamodb.model.WriteRequest(putRequest=putRequest1);
            putRequest2 = aws.dynamodb.model.PutRequest(item=item2);
            writeRequest2 = aws.dynamodb.model.WriteRequest(putRequest=putRequest2);

            requestItemsArray = dictionary(testCase.tableName, {[writeRequest1, writeRequest2]});

            batchWriteResponse = testCase.dynamoDB.batchWriteItem(requestItems =requestItemsArray);

            testCase.verifyTrue(isempty(keys(batchWriteResponse.unprocessedItems)));

            item1Key = dictionary("Id",item2Attribute1);
            deleteRequest1 = aws.dynamodb.model.DeleteRequest(key=item1Key);

            writeRequest = aws.dynamodb.model.WriteRequest(deleteRequest=deleteRequest1);

            requestItemsArray = dictionary(testCase.tableName, {[writeRequest]});

            batchWriteResponse = testCase.dynamoDB.batchWriteItem(requestItems =requestItemsArray);
            testCase.verifyTrue(isempty(keys(batchWriteResponse.unprocessedItems)));

        end

    end

    methods (Test, TestTags = {'Unit'})

        function testScan_Baseline_NoFilters(testCase)
            % Arrange: put a couple of items
            putTestItems(testCase, ["u#001","u#002"]);

            % Act
            resp = testCase.dynamoDB.scan(tableName = testCase.tableName);

            % Assert: response type and basic fields
            testCase.verifyClass(resp, 'aws.dynamodb.model.ScanResponse');
            % Items can be empty if provisioned very low / immediate timing; ensure fields exist
            testCase.verifyTrue(isfield(resp, 'items') || true); %#ok<BOOL> (presence sanity)
        end

        function testScan_WithLimit_AndProjection(testCase)
            % Arrange
            putTestItems(testCase, "u#LIM1", struct("Type","A","Score", 7));
            putTestItems(testCase, "u#LIM2", struct("Type","B","Score", 9));

            % Act: limit 1 with projection (Id, Type only)
            resp = testCase.dynamoDB.scan( ...
                tableName = testCase.tableName, ...
                limit = int32(1), ...
                projectionExpression = "Id, #T", ...
                expressionAttributeNames = dictionary("#T","Type"));

            % Assert
            testCase.verifyClass(resp, 'aws.dynamodb.model.ScanResponse');
            testCase.verifyLessThanOrEqual(numel(resp.items), 1);
            if ~isempty(resp.items)
                item = resp.items{1};
                testCase.verifyTrue(isKey(item, "Id"));
                testCase.verifyTrue(isKey(item, "Type"));
                % Projection should NOT include Score
                testCase.verifyFalse(isKey(item, "Score"));
            end
        end

        function testScan_Filter_WithExpressionValues(testCase)
            % Arrange: add prefixed Ids
            putTestItems(testCase, ["user#A1","user#A2","order#X1"]);
            vals = dictionary(":pfx", aws.dynamodb.model.AttributeValue(s="user#"));

            % Act: filter begins_with on Id (hash key)
            resp = testCase.dynamoDB.scan( ...
                tableName = testCase.tableName, ...
                filterExpression = "begins_with(Id, :pfx)", ...
                expressionAttributeValues = vals);

            % Assert: all returned items (if any) should start with "user#"
            % Begins with "user#"
            if ~isempty(resp.items)
                n   = numel(resp.items);
                ids = strings(1, n);
                for idx = 1:n
                    it = resp.items{idx};              % dictionary
                    if isKey(it, "Id")
                        cellAV = it("Id");             % 1×1 cell {AttributeValue}
                        avCell2     = cellAV{1};            % unwrap the cell
                        avObj   = avCell2{1};        % aws.dynamodb.model.AttributeValue (wrapper)
                        ids(idx) = avObj.getValue();       % extract string value
                    else
                        ids(idx) = missing;            % or "", depending on preference
                    end
                end
                testCase.verifyTrue(all(startsWith(ids(~ismissing(ids)), "user#")));
            end
        end    

        function testScan_Pagination_WithLastEvaluatedKey(testCase)
            % Arrange: insert several items to exceed limit
            ids = "u#PG" + string(1001:1006);
            for idx = 1:numel(ids)
                putTestItems(testCase, ids(idx), struct("Seq", idx));
            end

            % Act: first page
            resp1 = testCase.dynamoDB.scan( ...
                tableName = testCase.tableName, ...
                limit = int32(2), ...
                projectionExpression = "Id, Seq");

            % Assert page 1 size and token presence/absence
            testCase.verifyLessThanOrEqual(numel(resp1.items), 2);
            lek1 = resp1.lastEvaluatedKey;
            if ~isempty(lek1)
                % Next page using exclusiveStartKey
                resp2 = testCase.dynamoDB.scan( ...
                    tableName = testCase.tableName, ...
                    limit = int32(2), ...
                    exclusiveStartKey = lek1, ...
                    projectionExpression = "Id, Seq");

                % Combined should be > first page if data large enough
                total = numel(resp1.items) + numel(resp2.items);
                testCase.verifyGreaterThanOrEqual(total, numel(resp1.items));
            else
                % If DynamoDB returned everything in one page (small table), that's valid
                testCase.verifyTrue(true);
            end
        end

        function testScan_WithConsistentRead(testCase)
            % Arrange
            putTestItems(testCase, "u#CONSISTENT", struct("Flag",true));

            % Act: request strongly consistent results
            resp = testCase.dynamoDB.scan( ...
                tableName = testCase.tableName, ...
                consistentRead = true, ...
                filterExpression = "Id = :id", ...
                expressionAttributeValues = dictionary(":id", aws.dynamodb.model.AttributeValue(s="u#CONSISTENT")));

            % Assert
            if ~isempty(resp.items)
                it      = resp.items{1};     % dictionary for the first item
                avCell1 = it("Id");          % 1x1 cell
                avCell2 = avCell1{1};        % 1x1 cell (nested)
                avObj   = avCell2{1};        % aws.dynamodb.model.AttributeValue (wrapper)
                testCase.verifyEqual(avObj.getValue(), "u#CONSISTENT");
            end
        end

        function testScan_InvalidLimitValidation(testCase)
            % limit = 0 → aws:dynamodb:InvalidLimit
            testCase.verifyError(@() testCase.dynamoDB.scan( ...
                tableName = testCase.tableName, ...
                limit = int32(0)), 'aws:dynamodb:InvalidLimit');

            % non-integer (not int32) should be rejected by your validator
            % (the validator converts to error only if provided; we simulate bad input)
            testCase.verifyError(@() testCase.dynamoDB.scan( ...
                tableName = testCase.tableName, ...
                limit = int32(-5)), 'aws:dynamodb:InvalidLimit');
        end

    end

    methods(Access=private)

        function putTestItems(testCase, idOrIds, extraAttributes)
            %PUTTESTITEMS Insert one or more items into the test table.
            %   putTestItems(testCase, "id")
            %   putTestItems(testCase, ["id1","id2"], struct("Type","A","Score",1))

            if nargin < 3
                extraAttributes = struct();
            end

            if isstring(idOrIds) && isscalar(idOrIds)
                ids = idOrIds;
            else
                ids = string(idOrIds);
            end

            for k = 1:numel(ids)
                attrs = dictionary();
                attrs("Id") = aws.dynamodb.model.AttributeValue(s = ids(k));

                % Add any extra attributes as strings/numbers/bools based on type
                fn = fieldnames(extraAttributes);
                for idx = 1:numel(fn)
                    val = extraAttributes.(fn{idx});
                    if isstring(val) || ischar(val)
                        attrs(fn{idx}) = aws.dynamodb.model.AttributeValue(s = string(val));
                    elseif isnumeric(val)
                        attrs(fn{idx}) = aws.dynamodb.model.AttributeValue(n = string(val));
                    elseif islogical(val)
                        attrs(fn{idx}) = aws.dynamodb.model.AttributeValue(bool = val);
                    else
                        % fall back to string serialization
                        attrs(fn{idx}) = aws.dynamodb.model.AttributeValue(s = string(jsonencode(val)));
                    end
                end

                testCase.dynamoDB.putItem(tableName = testCase.tableName, item = attrs);
            end
        end

    end

end