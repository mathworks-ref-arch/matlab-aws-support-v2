function response = invokeBedrockModels(modelId, inputPrompt)
%INVOKEBEDROCKMODELS basic Amazon Titan invoke model service in MATLAB

% Copyright 2025 The MathWorks, Inc.

region = 'us-east-1';
bedrockRuntime = aws.bedrock.runtime.Client('region', region);
if isempty(modelId)
    modelId = "amazon.titan-text-premier-v1:0";
end

rawResponse = bedrockRuntime.invokeModel(modelId=modelId, body=inputPrompt);

response = jsonencode(rawResponse);

end

