function response = changeMessageVisibility(obj, options)
% CHANGEMESSAGEVISIBILITY Update the visibility timeout for a message.
%
% Syntax
%   resp = sqs.changeMessageVisibility(queueUrl=url, ...
%       receiptHandle=handle, visibilityTimeout=120);
%
% Name-Value Arguments
%   queueUrl          - (string, required) Queue URL that owns the message.
%   receiptHandle     - (string, required) Receipt handle returned by `receiveMessage`.
%   visibilityTimeout - (int32, required) New timeout in seconds (0-43200).
%
% Returns
%   response - aws.sqs.model.ChangeMessageVisibilityResponse containing HTTP metadata.
%
% Example
%   resp = sqs.changeMessageVisibility(queueUrl=url, receiptHandle=handle, ...
%       visibilityTimeout=300);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.queueUrl (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.receiptHandle (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.visibilityTimeout (1,1) int32 {mustBeFinite}
end

validateVisibilityTimeout(options.visibilityTimeout);

write(obj.logObj, 'info', ...
    'Changing message visibility in Simple Queue Service');

changeMessageVisibilityRequestBuilder = ...
    software.amazon.awssdk.services.sqs.model.ChangeMessageVisibilityRequest.builder();

changeMessageVisibilityRequest = aws.internal.builder.build( ...
    changeMessageVisibilityRequestBuilder, options);

responseJ = obj.Handle.changeMessageVisibility(changeMessageVisibilityRequest);
response = aws.sqs.model.ChangeMessageVisibilityResponse(responseJ);

end

function validateVisibilityTimeout(value)
validateattributes(value, {'numeric'}, ...
    {'scalar','integer','>=',0,'<=',43200}, mfilename, 'visibilityTimeout');
end
