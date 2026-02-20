function deleteQueueResponse = deleteQueue(obj, options)
% DELETEQUEUE Delete an SQS queue.
%
% Syntax
%   resp = sqs.deleteQueue(queueUrl=url);
%
% Name-Value Arguments
%   queueUrl - (string, required) Queue URL to delete.
%
% Returns
%   deleteQueueResponse - aws.sqs.model.DeleteQueueResponse containing HTTP metadata.

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.queueUrl (1,1) string {mustBeTextScalar, mustBeNonempty}
end

write(obj.logObj, 'info', 'Deleting Queue in Simple Queue Service');

% Build the request
deleteQueueRequestBuilder = software.amazon.awssdk.services.sqs.model.DeleteQueueRequest.builder();
deleteQueueRequest = aws.internal.builder.build(deleteQueueRequestBuilder, options);

% Call the deleteQueue method from the AWS SDK
responseJ = obj.Handle.deleteQueue(deleteQueueRequest);

% Wrap the Java response in a MATLAB DeleteQueueResponse object
deleteQueueResponse = aws.sqs.model.DeleteQueueResponse(responseJ);

end
