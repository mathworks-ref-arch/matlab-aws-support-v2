function setQueueAttributesResponse = setQueueAttributes(obj, options)
% SETQUEUEATTRIBUTES Update attributes for an SQS queue.
%
% Syntax
%   attrs = dictionary("VisibilityTimeout","45");
%   resp = sqs.setQueueAttributes(queueUrl=url, attributesWithStrings=attrs);
%
% Name-Value Arguments
%   queueUrl             - (string, required) Queue URL.
%   attributesWithStrings - (dictionary, required) Map of attribute name -> string value.
%
% Returns
%   setQueueAttributesResponse - aws.sqs.model.SetQueueAttributesResponse containing HTTP metadata.
%
% Example
%   attrs = dictionary(["DelaySeconds","MaximumMessageSize"], ["5","262144"]);
%   sqs.setQueueAttributes(queueUrl=url, attributesWithStrings=attrs);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.queueUrl (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.attributesWithStrings dictionary {mustBeNonempty}
end

write(obj.logObj, 'info', 'Setting queue attributes in Simple Queue Service');

% Create the request builder for setting queue attributes
setQueueAttributesRequestBuilder = software.amazon.awssdk.services.sqs.model.SetQueueAttributesRequest.builder();
setQueueAttributesRequest = aws.internal.builder.build(setQueueAttributesRequestBuilder, options);


% Call the setQueueAttributes method from the AWS SDK
responseJ = obj.Handle.setQueueAttributes(setQueueAttributesRequest);

% Wrap the response in a MATLAB SetQueueAttributesResult object
setQueueAttributesResponse = aws.sqs.model.SetQueueAttributesResponse(responseJ);

end
