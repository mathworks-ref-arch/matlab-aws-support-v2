function sendMessageResponse = sendMessage(obj, options)
% SENDMESSAGE Send a payload to an SQS queue.
%
% Syntax
%   resp = sqs.sendMessage(queueUrl=url, messageBody="Hello world");
%   resp = sqs.sendMessage(queueUrl=url, messageBody=payload, delaySeconds=5, ...
%       messageAttributes=attrs, messageGroupId="group-1", messageDeduplicationId="token");
%
% Name-Value Arguments
%   queueUrl              - (string, required) Queue URL returned by `createQueue` or AWS console.
%   messageBody           - (string, required) UTF-8 payload (<= 262144 bytes).
%   delaySeconds          - (int32) Delivery delay in seconds (0â€“900, default 0).
%   messageAttributes     - (dictionary) Map of attribute name -> struct with `dataType`, `stringValue`, etc.
%   messageDeduplicationId - (string) Deduplication key (for FIFO queues).
%   messageGroupId        - (string) Group identifier (required for FIFO queues).
%
% Returns
%   sendMessageResponse - aws.sqs.model.SendMessageResponse containing the message ID and MD5 hashes.
%
% Example
%   attrs = dictionary("priority", struct("dataType","String","stringValue","high"));
%   resp = sqs.sendMessage(queueUrl=url, messageBody="Hello", messageAttributes=attrs);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.queueUrl (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.messageBody (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.delaySeconds (1,1) int32 {mustBeNonnegative, mustBeInteger} = 0
    options.messageAttributes dictionary
    options.messageDeduplicationId (1,1) string
    options.messageGroupId (1,1) string
end

write(obj.logObj, 'info', 'Sending message to Simple Queue Service');

% Assuming it is ASCII checks 1 byte/ character. (262144 bytes)
if strlength(options.messageBody) > 262144
    write(obj.logObj, 'error', 'Max. message length (262144 bytes) exceeded with UTF-8 encoding');
    error('AWS:SQS:MessageSizeExceeded', 'Message size exceeds limit');
end

sendMessageRequestBuilder = software.amazon.awssdk.services.sqs.model.SendMessageRequest.builder();
sendMessageRequest = aws.internal.builder.build(sendMessageRequestBuilder, options);

% Call the sendMessage method from the AWS SDK
responseJ = obj.Handle.sendMessage(sendMessageRequest);

% Wrap the Java response in a MATLAB SendMessageResponse object
sendMessageResponse = aws.sqs.model.SendMessageResponse(responseJ);

end