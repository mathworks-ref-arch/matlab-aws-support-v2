function jsonString = buildModelPayload(modelId, payloadSpec)
% BUILDMODELPAYLOAD Construct a JSON payload for Amazon Bedrock Runtime.
%
% A caller can provide either a raw JSON string, or a MATLAB structure /
% dictionary containing the fields required by the target model. For the
% common text models a plain text prompt is accepted and converted
% automatically.
%
% Inputs
%   modelId     - (string) Identifier for the Bedrock model.
%   payloadSpec - (string | struct | dictionary) Prompt, raw JSON, or a MATLAB
%                 structure describing the payload.
%
% Returns
%   jsonString  - (char) JSON payload ready for use with InvokeModel.

% Copyright 2025 The MathWorks, Inc.

arguments
    modelId (1,1) string {mustBeTextScalar, mustBeNonempty}
    payloadSpec
end

if isa(payloadSpec, 'dictionary')
    nativeSpec = dictionaryToStruct(payloadSpec);
elseif isstruct(payloadSpec)
    nativeSpec = payloadSpec;
elseif isStringOrCharScalar(payloadSpec)
    prompt = string(payloadSpec);
    trimmed = strtrim(prompt);
    if startsWith(trimmed, ["{", "["], 'IgnoreCase', false)
        jsonString = char(prompt);
        return
    end
    nativeSpec = buildTemplateFromPrompt(modelId, prompt);
else
    error('aws:bedrock:buildModelPayload:UnsupportedPayload', ...
        'payloadSpec must be a scalar string/char, struct, or dictionary.');
end

nativeSpec = normalizeStructuredPayload(modelId, nativeSpec);

jsonString = jsonencode(nativeSpec);

end

function nativeSpec = buildTemplateFromPrompt(modelId, prompt)
prompt = char(prompt);
switch modelId
    case "ai21.j2-mid-v1"
        nativeSpec = struct('prompt', prompt);
    case {"amazon.titan-text-premier-v1:0", "amazon.titan-text-express-v1", "amazon.titan-text-lite-v1"}
        nativeSpec = struct('inputText', prompt);
    case "amazon.titan-embed-text-v2:0"
        nativeSpec = struct('inputText', prompt);
    case "anthropic.claude-3-haiku-20240307-v1:0"
        nativeSpec = struct( ...
            'anthropic_version', 'bedrock-2023-05-31', ...
            'max_tokens', 512, ...
            'temperature', 0.5, ...
            'messages', {{struct('role','user','content',prompt)}} );
    case "cohere.command-r-v1:0"
        nativeSpec = struct('message', prompt);
    case "cohere.command-light-text-v14"
        nativeSpec = struct('prompt', prompt);
    case "meta.llama2-13b-chat-v1"
        instruction = sprintf('<s>[INST] %s [/INST]\n', prompt);
        nativeSpec = struct('prompt', instruction);
    case "meta.llama3-8b-instruct-v1:0"
        instruction = sprintf( ...
            '<|begin_of_text|>\n<|start_header_id|>user<|end_header_id|>\n%s <|eot_id|>\n<|start_header_id|>assistant<|end_header_id|>\n', ...
            prompt);
        nativeSpec = struct('prompt', instruction);
    case "mistral.mistral-large-2402-v1:0"
        instruction = sprintf('<s>[INST] %s [/INST]\n', prompt);
        nativeSpec = struct('prompt', instruction);

    case { ...
            "amazon.nova-micro-v1:0", ...
            "amazon.nova-lite-v1:0", ...
            "amazon.nova-pro-v1:0", ...
            "amazon.nova-premier-v1:0", ...
            "amazon.nova-2-lite-v1:0", ...
            "amazon.nova-2-pro-v1:0", ...
            "amazon.nova-2-sonic-v1:0", ...
            "amazon.nova-canvas-v1:0", ...
            "amazon.nova-reel-v1:0" ...
            }

        nativeSpec = struct( ...
            'messages', {{ struct( ...
            'role', 'user', ...
            'content', {{ struct('text', prompt) }} ...
            ) }} ...
            );

    case { ...
            "anthropic.claude-3-5-sonnet-20240620-v1:0", ...
            "anthropic.claude-sonnet-4-5-20250929-v1:0", ...   % Sonnet 4.5
            "anthropic.claude-opus-4-5-20251101-v1:0", ...     % Opus 4.5
            "anthropic.claude-sonnet-4-20250514-v1:0", ...     % Sonnet 4.0
            "anthropic.claude-opus-4-20250514-v1:0", ...       % Opus 4.0
            "anthropic.claude-3-7-sonnet-20250219-v1:0" ...    % Sonnet 3.7
            }

        nativeSpec = struct( ...
            'anthropic_version', 'bedrock-2023-05-31', ...   % Required constant on Bedrock
            'max_tokens', 1024, ...
            'temperature', 0.5, ...
            'messages', {{ struct( ...
            'role', 'user', ...
            'content', {{ struct('type','text','text', prompt) }} ...
            ) }} ...
            );


    otherwise
        error('aws:bedrock:buildModelPayload:UnsupportedModel', ...
            ['Model %s requires a structured payload. ' ...
            'Update aws.bedrock.runtime.utils.buildModelPayload to include ' ...
            ' the Model %s.'], modelId, modelId);
end
end

function s = dictionaryToStruct(d)
s = struct();
keyArray = keys(d);
for idx = 1:numel(keyArray)
    key = matlab.lang.makeValidName(keyArray{idx});
    value = d(keyArray{idx});
    if isa(value, 'dictionary')
        value = dictionaryToStruct(value);
    elseif iscell(value) && numel(value) == 1
        value = value{1};
    end
    s.(key) = value;
end
end

function tf = isStringOrCharScalar(value)
tf = (isstring(value) && isscalar(value)) || ischar(value);
end

function nativeSpec = normalizeStructuredPayload(modelId, nativeSpec)
switch modelId
    case "amazon.titan-image-generator-v1"
        nativeSpec = ensureTitanImageSpec(nativeSpec);
    case "stability.stable-diffusion-xl-v1"
        nativeSpec = ensureStableDiffusionSpec(nativeSpec);
    otherwise
        % Caller provided the full structure; no additional validation.
end
end

function nativeSpec = ensureTitanImageSpec(spec)
if isfield(spec, 'taskType') || isfield(spec, 'textToImageParams')
    nativeSpec = spec;
    return
end
text = requireStringField(spec, 'text', 'text prompt');
seed = requireNumericField(spec, 'seed', 'seed');
nativeSpec = struct( ...
    'taskType', 'TEXT_IMAGE', ...
    'textToImageParams', struct('text', char(text)), ...
    'imageGenerationConfig', struct('seed', seed));
if isfield(spec, 'style')
    nativeSpec.imageGenerationConfig.style = spec.style;
end
end

function nativeSpec = ensureStableDiffusionSpec(spec)
if isfield(spec, 'text_prompts') || (isfield(spec, 'seed') && isfield(spec, 'style_preset'))
    nativeSpec = spec;
    return
end
text = requireStringField(spec, 'text', 'text');
seed = requireNumericField(spec, 'seed', 'seed');
style = requireStringField(spec, 'style', 'style');
nativeSpec = struct( ...
    'text_prompts', struct('text', char(text)), ...
    'style_preset', char(style), ...
    'seed', seed);
end

function value = requireStringField(spec, fieldName, description)
if ~isfield(spec, fieldName)
    error('aws:bedrock:buildModelPayload:MissingField', ...
        'Field "%s" (%s) is required.', fieldName, description);
end
value = spec.(fieldName);
if ~(ischar(value) || (isstring(value) && isscalar(value)))
    error('aws:bedrock:buildModelPayload:InvalidFieldType', ...
        'Field "%s" must be a scalar string or char.', fieldName);
end
end

function value = requireNumericField(spec, fieldName, description)
if ~isfield(spec, fieldName)
    error('aws:bedrock:buildModelPayload:MissingField', ...
        'Field "%s" (%s) is required.', fieldName, description);
end
value = spec.(fieldName);
if ~(isnumeric(value) && isscalar(value))
    error('aws:bedrock:buildModelPayload:InvalidFieldType', ...
        'Field "%s" must be a numeric scalar.', fieldName);
end
end
