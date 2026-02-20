function getQueueAttributesResponse = getQueueAttributes(obj, options)
% GETQUEUEATTRIBUTES Retrieve metadata for an SQS queue.
%
% Syntax
%   resp = sqs.getQueueAttributes(queueUrl=url);
%   resp = sqs.getQueueAttributes(queueUrl=url, attributeNamesWithStrings=["VisibilityTimeout","ApproximateNumberOfMessages"]);
%
% Name-Value Arguments
%   queueUrl               - (string, required) Queue URL.
%   attributeNamesWithStrings - (string array) Attribute names to request (default `"All"`).
%
% Returns
%   getQueueAttributesResponse - aws.sqs.model.GetQueueAttributesResponse with a dictionary of key/value pairs.
%
% Example
%   resp = sqs.getQueueAttributes(queueUrl=url, attributeNamesWithStrings=["VisibilityTimeout"]);
%   disp(resp.attributes("VisibilityTimeout"));

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.queueUrl (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.attributeNamesWithStrings (1,:) string = "All"
end

write(obj.logObj, 'info', 'Retrieving queue attributes from Simple Queue Service');

% Create the request builder for getting queue attributes
getQueueAttributesRequestBuilder = software.amazon.awssdk.services.sqs.model.GetQueueAttributesRequest.builder();
getQueueAttributesRequest = aws.internal.builder.build(getQueueAttributesRequestBuilder, options);


% Call the getQueueAttributes method from the AWS SDK
responseJ = obj.Handle.getQueueAttributes(getQueueAttributesRequest);

% Wrap the Java response in a MATLAB GetQueueAttributesResponse object
getQueueAttributesResponse = aws.sqs.model.GetQueueAttributesResponse(responseJ);

end
