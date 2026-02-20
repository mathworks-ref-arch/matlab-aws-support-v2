function response = invokeModel(obj, options)
% INVOKEMODEL Run inference against a Bedrock foundation model.
%
% Syntax
%   resp = bedrock.invokeModel(modelId="amazon.titan-text-express-v1", body="Hello!");
%   resp = bedrock.invokeModel(modelId="amazon.titan-image-generator-v1", body=spec);
%
% Name-Value Arguments
%   modelId             - (string, required) Model identifier.
%   body                - (string | struct | dictionary, required) Text prompt or payload spec.
%   accept              - (string) Desired MIME type for the response (default: "application/json").
%   contentType         - (string) MIME type for the request body (default: "application/json").
%   guardrailIdentifier - (string) Optional guardrail ID.
%   guardrailVersion    - (string) Optional guardrail version.
%   trace               - (string) Optional trace configuration.
%
% Returns
%   response - aws.bedrock.runtime.model.InvokeModelResponse containing the model output.
%
% Example
%   resp = bedrock.invokeModel(modelId="amazon.titan-text-lite-v1", body="Summarize this.");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.modelId (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.body {mustBePayloadSpec}
    options.accept (1,1) string
    options.contentType (1,1) string
    options.guardrailIdentifier (1,1) string
    options.guardrailVersion (1,1) string
    options.trace (1,1) string
end

invokeModelRequestBuilder = software.amazon.awssdk.services.bedrockruntime.model.InvokeModelRequest.builder();
payloadJson = aws.bedrock.runtime.utils.buildModelPayload(options.modelId, options.body);
options.body = software.amazon.awssdk.core.SdkBytes.fromUtf8String(payloadJson);
invokeModelRequest = aws.internal.builder.build(invokeModelRequestBuilder, options);

responseJ = obj.Handle.invokeModel(invokeModelRequest);

response = aws.bedrock.runtime.model.InvokeModelResponse(options.modelId, responseJ);

end

function mustBePayloadSpec(value)
isStringPayload = (isstring(value) && isscalar(value)) || ischar(value);
if ~(isStringPayload || isstruct(value) || isa(value, 'dictionary'))
    error('aws:bedrock:invokeModel:InvalidBody', ...
        'body must be a scalar string/char, struct, or dictionary describing the payload.');
end
if isStringPayload && strlength(string(value)) == 0
    error('aws:bedrock:invokeModel:EmptyBody', 'body cannot be empty.');
end
end

