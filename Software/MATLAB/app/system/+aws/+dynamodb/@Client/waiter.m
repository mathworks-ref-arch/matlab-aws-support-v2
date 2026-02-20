function waiterObj = waiter(obj)
%WAITER Create a DynamoDB waiter bound to this client
%
% Usage:
%   dynamo = aws.dynamodb.Client(...);
%   w = dynamo.waiter();
%   w.waitUntilTableExists(tableName="myTable");
%   w.waitUntilTableNotExists(tableName="myTable");
%
% Returns:
%   waiterObj (aws.dynamodb.DynamoDbWaiter) - MATLAB wrapper around
%   software.amazon.awssdk.services.dynamodb.waiters.DynamoDbWaiter

% Copyright 2025 The MathWorks, Inc.

% Java waiter from the AWS SDK for Java v2
waiterJ = obj.Handle.waiter();
% Your MATLAB wrapper
waiterObj = aws.dynamodb.waiters.DynamoDbWaiter(waiterJ);

write(obj.logObj, 'verbose', 'DynamoDB waiter created');

end
