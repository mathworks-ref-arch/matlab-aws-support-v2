function deleteMessageResponse = deleteMessage(obj, options)
% DELETEMESSAGE Remove a message from an SQS queue using its receipt handle.
%
% Syntax
%   resp = sqs.deleteMessage(queueUrl=url, receiptHandle=handle);
%
% Name-Value Arguments
%   queueUrl      - (string, required) Queue URL containing the message.
%   receiptHandle - (string, required) Receipt handle returned by `receiveMessage`.
%
% Returns
%   deleteMessageResponse - aws.sqs.model.DeleteMessageResponse containing HTTP metadata.

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.queueUrl (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.receiptHandle (1,1) string {mustBeTextScalar, mustBeNonempty}
end

write(obj.logObj, 'info', 'Deleting message from Simple Queue Service');

% Build the request
deleteMessageRequestBuilder = software.amazon.awssdk.services.sqs.model.DeleteMessageRequest.builder();
deleteMessageRequest = aws.internal.builder.build(deleteMessageRequestBuilder, options);


% Call the deleteMessage method from the AWS SDK
responseJ = obj.Handle.deleteMessage(deleteMessageRequest);

% Wrap the Java response in a MATLAB DeleteMessageResponse object
deleteMessageResponse = aws.sqs.model.DeleteMessageResponse(responseJ);

end
