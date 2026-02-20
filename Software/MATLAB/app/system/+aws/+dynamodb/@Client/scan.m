function scanResponse = scan(obj, options)
% SCAN Perform a table scan with optional filtering.
%
% Syntax
%   resp = ddb.scan(tableName="Users");
%   resp = ddb.scan(tableName="Users", filterExpression="begins_with(pk, :prefix)", ...
%       expressionAttributeValues=vals, limit=25);
%
% Name-Value Arguments
%   tableName                - (string, required) Table to scan.
%   filterExpression         - (string) Conditional expression applied after the scan.
%   expressionAttributeValues - (dictionary) Map of tokens (e.g., `:prefix`) to
%                               aws.dynamodb.model.AttributeValue objects.
%   expressionAttributeNames - (dictionary) Map of tokens (e.g., `#pk`) to attribute names.
%   projectionExpression     - (string) Expression specifying which attributes to return.
%   limit                    - (double) Positive integer cap on the number of items returned.
%   consistentRead           - (logical) true to request strongly consistent results (default false).
%   exclusiveStartKey        - (dictionary) Last evaluated key from a previous scan call.
%
% Returns
%   scanResponse - aws.dynamodb.model.ScanResponse containing the items, consumed
%                  capacity, and pagination tokens.
%
% Example
%   ddb = aws.dynamodb.Client();
%   vals = dictionary(":prefix", aws.dynamodb.model.AttributeValue(s="user#"));
%   resp = ddb.scan(tableName="Users", filterExpression="begins_with(pk, :prefix)", ...
%       expressionAttributeValues=vals, limit=25);
%   while ~isempty(resp.lastEvaluatedKey)
%       resp = ddb.scan(tableName="Users", exclusiveStartKey=resp.lastEvaluatedKey);
%   end

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.tableName (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.filterExpression string
    options.expressionAttributeValues dictionary
    options.expressionAttributeNames dictionary
    options.projectionExpression string
    options.limit (1,1) int32 {mustBePositiveIntegerScalar}
    options.consistentRead (1,1) logical
    options.exclusiveStartKey dictionary
end

write(obj.logObj, 'info', 'Scanning Items in DynamoDB');

scanRequestBuilder = software.amazon.awssdk.services.dynamodb.model.ScanRequest.builder();
scanRequest = aws.internal.builder.build(scanRequestBuilder, options);
responseJ = obj.Handle.scan(scanRequest);

scanResponse = aws.dynamodb.model.ScanResponse(responseJ);
write(obj.logObj, 'info', 'Scanned Items in DynamoDB');

end

function mustBePositiveIntegerScalar(val)
if isempty(val)
    return
end
if ~isscalar(val) || val <= 0 || floor(val) ~= val
    error("aws:dynamodb:InvalidLimit", ...
        "limit must be a positive integer scalar.");
end
end
