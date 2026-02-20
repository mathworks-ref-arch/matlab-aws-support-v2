function response = converse(obj, options)
% CONVERSE Send conversation turns to an Amazon Bedrock foundation model.
%
% Syntax
%   resp = bedrock.converse(modelId="amazon.titan-text-lite-v1", messages=history);
%
% Name-Value Arguments
%   modelId    - (string, required) Model identifier (e.g., "amazon.titan-text-lite-v1").
%   messages   - (aws.bedrock.runtime.model.Message vector, required) History of turns
%                alternating between user and assistant roles.
%   maxTokens  - (int32) Optional max tokens in the response (default 512).
%   temperature- (single) Optional sampling temperature in [0,1].
%   topP       - (single) Optional nucleus sampling parameter in [0,1].
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
    options.temperature (1,1) single {mustBeNonnegative, mustBeLessThanOrEqual(options.temperature, 1)} = 0.7
    options.topP (1,1) single {mustBeNonnegative, mustBeLessThanOrEqual(options.topP, 1)} = 0.9
end

messageArray = num2cell(options.messages);

msgHandleArray = cellfun(@(msg) msg.Handle, messageArray, 'UniformOutput', false);
sdkMessages = java.util.ArrayList();
arrayfun(@(i) sdkMessages.add(msgHandleArray{i}), 1:numel(msgHandleArray));

converseRequestbuilder = software.amazon.awssdk.services.bedrockruntime.model.ConverseRequest.builder();
converseRequestbuilder = converseRequestbuilder.modelId(options.modelId).messages(sdkMessages);

inferenceConfigBuilder = software.amazon.awssdk.services.bedrockruntime.model.InferenceConfiguration.builder();
options = rmfield(options, 'messages');
options = rmfield(options, 'modelId');
inferenceConfig = aws.internal.builder.build(inferenceConfigBuilder, options);

converseRequestbuilder = converseRequestbuilder.inferenceConfig(inferenceConfig);
converseRequest = converseRequestbuilder.build();

responseJ = obj.Handle.converse(converseRequest);

response = aws.bedrock.runtime.model.ConverseResponse(responseJ);

end

