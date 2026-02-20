function batchWriteItemResponse = batchWriteItem(obj, options)
% BATCHWRITEITEM Write up to 25 put/delete requests per call.
%
% Syntax
%   resp = ddb.batchWriteItem(requestItems=reqs);
%
% Name-Value Arguments
%   requestItems - (dictionary, required) Map of table name => vector or cell
%                  array of aws.dynamodb.model.WriteRequest objects. Each value
%                  contains up to 25 put/delete entries combined across tables.
%
% Returns
%   batchWriteItemResponse - aws.dynamodb.model.BatchWriteItemResponse containing
%                            unprocessed items and consumed capacity metrics.
%
% Example
%   ddb = aws.dynamodb.Client();
%   putBody = dictionary("pk", aws.dynamodb.model.AttributeValue(s="order#1"));
%   putReq = aws.dynamodb.model.PutRequest(item=putBody);
%   writeReq = aws.dynamodb.model.WriteRequest(putRequest=putReq);
%   reqs = dictionary("Orders", [writeReq]);
%   resp = ddb.batchWriteItem(requestItems=reqs);
%   disp(resp.unprocessedItems);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.requestItems dictionary {mustBeNonempty}

end

write(obj.logObj, 'info', 'Performing Batch Write in DynamoDB');

% Create a batch write item request builder
batchWriteItemRequestBuilder = software.amazon.awssdk.services.dynamodb.model.BatchWriteItemRequest.builder();
batchWriteItemRequest = aws.internal.builder.build(batchWriteItemRequestBuilder,options);


% Call the batchWriteItem method from the AWS SDK
responseJ = obj.Handle.batchWriteItem(batchWriteItemRequest);

% Wrap the Java response in a MATLAB BatchWriteItemResponse object
batchWriteItemResponse = aws.dynamodb.model.BatchWriteItemResponse(responseJ);
write(obj.logObj, 'info', 'Performed Batch Write in DynamoDB');

end
