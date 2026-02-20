function standardResponse = parseModelResponse(modelId, responseBody)
%PARSEMODELRESPONSE Parses the model-specific response into a standard format.
%   modelId: Identifier for the model.
%   responseBody: The raw response body from the model.

% Copyright 2025 The MathWorks, Inc.

% Decode the JSON response
data = jsondecode(string(responseBody));

% Initialize the standard response structure
standardResponse = struct('outputText', '', 'tokenCount', 0, 'completionReason', '');

% Parse the response based on the model ID
switch string(modelId)
    case 'ai21.j2-mid-v1'
        standardResponse.outputText = data.completions(1).data.text;
        standardResponse.tokenCount = data.completions(1).data.tokens;
        standardResponse.completionReason = data.completions(1).data.completionReason;

    case 'amazon.titan-image-generator-v1'
        standardResponse.outputText = data.images(1); % Base64 image data
        standardResponse.tokenCount = data.tokenCount;
        standardResponse.completionReason = data.completionReason;

    case 'amazon.titan-text-premier-v1:0'
        standardResponse.outputText = data.results(1).outputText;
        standardResponse.tokenCount = data.results(1).tokenCount;
        standardResponse.completionReason = data.results(1).completionReason;

    case 'amazon.titan-text-express-v1'
        standardResponse.outputText = data.results(1).outputText;        
        standardResponse.completionReason = data.results(1).completionReason;

    case 'amazon.titan-embed-text-v2:0'
        standardResponse.outputText = data.embedding;
        standardResponse.tokenCount = data.tokenCount;
        standardResponse.completionReason = data.completionReason;

    case 'cohere.command-r-v1:0'
        standardResponse.outputText = data.text;
        standardResponse.tokenCount = data.tokenCount;
        standardResponse.completionReason = data.completionReason;

    case 'cohere.command-light-text-v14'
        standardResponse.outputText = data.generations(1).text;
        standardResponse.tokenCount = data.generations(1).tokenCount;
        standardResponse.completionReason = data.generations(1).completionReason;

    case 'meta.llama2-13b-chat-v1'
        standardResponse.outputText = data.generation;
        standardResponse.tokenCount = data.generation_token_count;
        standardResponse.completionReason = data.stop_reason;

    case 'meta.llama3-8b-instruct-v1:0'
        standardResponse.outputText = data.generation;
        standardResponse.tokenCount = data.generation_token_count;
        standardResponse.completionReason = data.stop_reason;

    case 'mistral.mistral-large-2402-v1:0'
        standardResponse.outputText = data.outputs(1).text;
        standardResponse.tokenCount = data.outputs(1).tokenCount;
        standardResponse.completionReason = data.outputs(1).completionReason;

    case 'stability.stable-diffusion-xl-v1'
        standardResponse.outputText = data.artifacts(1).base64; % Base64 image data
        standardResponse.tokenCount = data.tokenCount;
        standardResponse.completionReason = data.completionReason;
    case { ...
            "anthropic.claude-3-haiku-20240307-v1:0", ...
            "anthropic.claude-3-7-sonnet-20250219-v1:0", ...
            "anthropic.claude-sonnet-4-20250514-v1:0", ...
            "anthropic.claude-opus-4-20250514-v1:0", ...
            "anthropic.claude-sonnet-4-5-20250929-v1:0", ...
            "anthropic.claude-opus-4-5-20251101-v1:0" ...
            }
        standardResponse.outputText = data.content.text;
        standardResponse.tokenCount = data.usage.output_tokens;
        standardResponse.completionReason = data.stop_reason;
        % ------------------- Amazon Nova (text families) ---------------------
    case { ...
            "amazon.nova-lite-v1:0", "amazon.nova-pro-v1:0", "amazon.nova-micro-v1:0", ...
            "amazon.nova-2-lite-v1:0", "amazon.nova-2-pro-v1:0", "amazon.nova-2-sonic-v1:0" ...
            }
        % Prefer Converse (already handled), else try common shapes
        if isfield(data, 'output')
            standardResponse.outputText = data.output.message.content.text;
        end
        if isfield(data, 'stopReason')
            standardResponse.completionReason = data.stopReason;
        end
        if isfield(data, 'usage')
            standardResponse.tokenCount = data.usage.outputTokens;
        end
        % ------------------- Default -----------------------------------------

    otherwise
        error('aws:bedrock:UnsupportedResponse',['Unknown model ID or unsupported response format.' ...
            'Update aws.bedrock.runtime.utils.parseModelResponse to include model %s'], modelId);
end
end