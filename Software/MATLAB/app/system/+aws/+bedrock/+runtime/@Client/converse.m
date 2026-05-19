function response = converse(obj, options)
% CONVERSE Send conversation turns to an Amazon Bedrock foundation model.
%
% Syntax
%   resp = bedrock.converse(modelId="amazon.titan-text-lite-v1", messages=history);
%
% Name-Value Arguments
%   modelId      - (string, required) Model identifier (e.g., "amazon.titan-text-lite-v1").
%   messages     - (aws.bedrock.runtime.model.Message vector, required) History of turns
%                  alternating between user and assistant roles.
%   maxTokens    - (int32) Optional max tokens in the response (default 512).
%   temperature  - (single) Optional sampling temperature in [0,1]. Not sent by
%                  default. Some models (e.g., Haiku) reject requests that include
%                  both temperature and topP; pass only one.
%   topP         - (single) Optional nucleus sampling parameter in [0,1]. Not sent
%                  by default.
%   systemPrompt - (string) Optional system prompt text. When non-empty, sent via
%                  the Converse API system field.
%
% Returns
%   response - aws.bedrock.runtime.model.ConverseResponse containing the assistant turn,
%              stop reason, and usage statistics.
%
% Example
%   msgs = aws.bedrock.runtime.model.Message.empty;
%   msgs(end+1) = aws.bedrock.runtime.model.Message(text="Hello?", role="user");
%   resp = bedrock.converse(modelId="amazon.titan-text-lite-v1", messages=msgs);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.modelId (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.messages (:,1) aws.bedrock.runtime.model.Message {mustBeNonempty}
    options.maxTokens (1,1) int32 {mustBePositive} = 512
    options.temperature (1,1) single = single(-1)
    options.topP (1,1) single = single(-1)
    options.systemPrompt (1,1) string = ""
end

messageArray = num2cell(options.messages);

msgHandleArray = cellfun(@(msg) msg.Handle, messageArray, 'UniformOutput', false);
sdkMessages = java.util.ArrayList();
arrayfun(@(i) sdkMessages.add(msgHandleArray{i}), 1:numel(msgHandleArray));

converseRequestbuilder = software.amazon.awssdk.services.bedrockruntime.model.ConverseRequest.builder();
converseRequestbuilder = converseRequestbuilder.modelId(options.modelId).messages(sdkMessages);

if strlength(options.systemPrompt) > 0
    sysBlock = software.amazon.awssdk.services.bedrockruntime.model.SystemContentBlock.fromText(options.systemPrompt);
    sysList = java.util.ArrayList();
    sysList.add(sysBlock);
    converseRequestbuilder = converseRequestbuilder.system(sysList);
end

inferenceConfigBuilder = software.amazon.awssdk.services.bedrockruntime.model.InferenceConfiguration.builder();
options = rmfield(options, 'messages');
options = rmfield(options, 'modelId');
options = rmfield(options, 'systemPrompt');
if options.temperature < 0
    options = rmfield(options, 'temperature');
end
if options.topP < 0
    options = rmfield(options, 'topP');
end
inferenceConfig = aws.internal.builder.build(inferenceConfigBuilder, options);

converseRequestbuilder = converseRequestbuilder.inferenceConfig(inferenceConfig);
converseRequest = converseRequestbuilder.build();

responseJ = obj.Handle.converse(converseRequest);

response = aws.bedrock.runtime.model.ConverseResponse(responseJ);

end

