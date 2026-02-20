function waitUntilTableExists(obj, options)
%WAITUNTILTABLEEXISTS Block until the specified DynamoDB table exists.
%
% Syntax
%   waiter.waitUntilTableExists(tableName="MyTable");
%
% Name-Value Arguments
%   tableName - (string, required) Name of the DynamoDB table to wait for.
%
% Example
%   ddb    = aws.dynamodb.Client();
%   waiter = ddb.getWaiter(); % Java waiter
%   waiter.waitUntilTableExists(tableName="Orders");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.tableName (1,1) string
end

write(obj.logObj, 'info', ['Waiting until Table exists: ', options.tableName]);

% Create a describe table request builder
describeTableRequestBuilder = software.amazon.awssdk.services.dynamodb.model.DescribeTableRequest.builder();


% Build the describe table request
describeTableRequest = aws.internal.builder.build(describeTableRequestBuilder, options);

% If you need to tweak attempts/delay (SDK-dependent), use overrides:
% override = WaiterOverrideConfiguration.builder() ...
%                .maxAttempts(ceil(timeoutSeconds/5)).build();

% Simple call (portable):
obj.Handle.waitUntilTableExists(describeTableRequest);

write(obj.logObj, 'info', ['Waiting Complete until Table exists: ', options.tableName]);

end
