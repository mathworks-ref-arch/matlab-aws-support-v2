function response = changeMessageVisibilityBatch(obj, options)
% CHANGEMESSAGEVISIBILITYBATCH Update visibility for multiple messages.
%
% Syntax
%   entries = struct( ...
%       'id', ["msg1","msg2"], ...
%       'receiptHandle', [handle1, handle2], ...
%       'visibilityTimeout', [90 120]);
%   resp = sqs.changeMessageVisibilityBatch(queueUrl=url, entries=entries);
%
% Name-Value Arguments
%   queueUrl - (string, required) Queue URL that owns the messages.
%   entries  - (struct array, required) Each element must include fields
%              `id`, `receiptHandle`, and `visibilityTimeout` (seconds).
%
% Returns
%   response - aws.sqs.model.ChangeMessageVisibilityBatchResponse containing
%              per-entry success/failure metadata.
%
% Example
%   entries = struct( ...
%       'id', ["msg1","msg2"], ...
%       'receiptHandle', [handle1, handle2], ...
%       'visibilityTimeout', [60 180]);
%   resp = sqs.changeMessageVisibilityBatch(queueUrl=url, entries=entries);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.queueUrl (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.entries (1,:) aws.sqs.model.ChangeMessageVisibilityBatchRequestEntry
end

write(obj.logObj, 'info', ...
    'Changing message visibility (batch) in Simple Queue Service');

requestBuilder = ...
    software.amazon.awssdk.services.sqs.model.ChangeMessageVisibilityBatchRequest.builder();
changeMessageVisibilityBatchRequest = aws.internal.builder.build(requestBuilder, options);

responseJ = obj.Handle.changeMessageVisibilityBatch(changeMessageVisibilityBatchRequest);
response = aws.sqs.model.ChangeMessageVisibilityBatchResponse(responseJ);

end

