function receiveMessageResponse = receiveMessage(obj, options)
% RECEIVEMESSAGE Retrieve messages from an SQS queue.
%
% Syntax
%   resp = sqs.receiveMessage(queueUrl=url);
%   resp = sqs.receiveMessage(queueUrl=url, maxNumberOfMessages=5, waitTimeSeconds=10, ...
%       messageAttributeNames=["All"]);
%
% Name-Value Arguments
%   queueUrl                        - (string, required) Queue URL to poll.
%   maxNumberOfMessages             - (int32) 1â€“10 messages per request (default 1).
%   messageAttributeNames           - (string array) Message attribute names to include (e.g., `"All"`).
%   messageSystemAttributeNamesWithStrings - (string array) System attributes to include (e.g., `"ApproximateReceiveCount"`).
%   visibilityTimeout               - (int32) Seconds to hide the message after retrieval.
%   waitTimeSeconds                 - (int32) Long-poll duration (0â€“20 seconds).
%   receiveRequestAttemptId         - (string) Idempotency token for FIFO queues.
%
% Returns
%   receiveMessageResponse - aws.sqs.model.ReceiveMessageResponse containing message wrappers.
%
% Example
%   resp = sqs.receiveMessage(queueUrl=url, maxNumberOfMessages=2, waitTimeSeconds=5);
%   disp(resp.messages{1}.body);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.queueUrl (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.maxNumberOfMessages (1,1) int32 {mustBePositive, mustBeInteger}
    options.messageAttributeNames (1,:) string
    options.messageSystemAttributeNamesWithStrings (1,:) string
    options.visibilityTimeout (1,1) int32 {mustBeNonnegative, mustBeInteger}
    options.waitTimeSeconds (1,1) int32 {mustBeNonnegative, mustBeInteger}
    options.receiveRequestAttemptId (1,1) string
end


write(obj.logObj, 'info', 'Receiving messages from Simple Queue Service');

receiveMessageRequestBuilder = software.amazon.awssdk.services.sqs.model.ReceiveMessageRequest.builder();
receiveMessageRequest = aws.internal.builder.build(receiveMessageRequestBuilder, options);

% Call the receiveMessage method
responseJ = obj.Handle.receiveMessage(receiveMessageRequest);

% Wrap the Java response in a MATLAB ReceiveMessageResponse object
receiveMessageResponse = aws.sqs.model.ReceiveMessageResponse(responseJ);

end