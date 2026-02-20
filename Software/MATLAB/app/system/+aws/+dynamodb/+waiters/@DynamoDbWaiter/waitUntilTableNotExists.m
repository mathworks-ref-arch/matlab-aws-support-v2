function waitUntilTableNotExists(obj, options)
%WAITUNTILTABLENOTEXISTS Block until the specified DynamoDB table is deleted.
%
% Syntax
%   waiter.waitUntilTableNotExists(tableName="MyTable");
%
% Name-Value Arguments
%   tableName - (string, required) Name of the DynamoDB table to wait against.
%
% Example
%   ddb    = aws.dynamodb.Client();
%   waiter = ddb.getWaiter(); % Java waiter
%   waiter.waitUntilTableNotExists(tableName="OldTable");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.tableName (1,1) string
end

write(obj.logObj, 'info', ['Waiting until Table Not exists: ', options.tableName]);

% Create a describe table request builder
describeTableRequestBuilder = software.amazon.awssdk.services.dynamodb.model.DescribeTableRequest.builder();


% Build the describe table request
describeTableRequest = aws.internal.builder.build(describeTableRequestBuilder, options);

% If you need to tweak attempts/delay (SDK-dependent), use overrides:
% override = WaiterOverrideConfiguration.builder() ...
%                .maxAttempts(ceil(timeoutSeconds/5)).build();

% Simple call (portable):
obj.Handle.waitUntilTableNotExists(describeTableRequest);

write(obj.logObj, 'info', ['Waiting Complete until Table Not exists: ', options.tableName]);

end
