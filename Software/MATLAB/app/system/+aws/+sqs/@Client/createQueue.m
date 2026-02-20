function createQueueResponse = createQueue(obj, options)
% CREATEQUEUE Create an Amazon SQS queue.
%
% Syntax
%   resp = sqs.createQueue(queueName="demoQueue");
%   resp = sqs.createQueue(queueName="fifoQueue.fifo", attributesWithStrings=attrs, tags=tags);
%
% Name-Value Arguments
%   queueName            - (string, required) Name for the queue (must end with `.fifo` for FIFO queues).
%   attributesWithStrings - (dictionary) Map of attribute name -> string value (e.g., `VisibilityTimeout`).
%   tags                 - (dictionary) Cost allocation tags to apply to the queue.
%
% Returns
%   createQueueResponse - aws.sqs.model.CreateQueueResponse containing the queue URL.
%
% Example
%   attrs = dictionary("VisibilityTimeout","45");
%   resp = sqs.createQueue(queueName="demoQueue", attributesWithStrings=attrs);
%   disp(resp.queueUrl);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.queueName (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.attributesWithStrings dictionary = dictionary()
    options.tags dictionary = dictionary()
end

write(obj.logObj, 'info', 'Creating Queue in Simple Queue Service');

createQueueRequestBuilder = software.amazon.awssdk.services.sqs.model.CreateQueueRequest.builder();
requestOptions = options;
if numEntries(requestOptions.attributesWithStrings) == 0
    requestOptions = rmfield(requestOptions, 'attributesWithStrings');
end
if numEntries(requestOptions.tags) == 0
    requestOptions = rmfield(requestOptions, 'tags');
end
createQueueRequest = aws.internal.builder.build(createQueueRequestBuilder, requestOptions);

% Call the createQueue method from the AWS SDK
responseJ = obj.Handle.createQueue(createQueueRequest);

% Wrap the Java response in a MATLAB CreateQueueResponse object
createQueueResponse = aws.sqs.model.CreateQueueResponse(responseJ);

end
