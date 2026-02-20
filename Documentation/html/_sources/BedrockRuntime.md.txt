## ☁️ 6.2 Bedrock Runtime

A MATLAB client for the Amazon Bedrock Runtime service. It provides API operations for running inference against Bedrock foundation models.

```matlab
bedrock = aws.bedrock.runtime.Client('region', 'us-east-1');
```
```{note}
Bedrock Runtime is not available in some default regions (e.g., `us-west-1`). Use a supported region such as `us-east-1`.
```

### 🔧 6.2.1 List of Available Methods

- [converse](AWSSDKAPI.md#awsbedrockruntimeclientconverse)
- [invokeModel](AWSSDKAPI.md#awsbedrockruntimeclientinvokemodel)

### 🧩 6.2.2 Examples

#### 🔸 Invoke a Model (Text Generation)
```matlab
textPrompt = "What is your name?";

response = bedrock.invokeModel( ...
    modelId = "amazon.titan-text-express-v1", ...
    body    = textPrompt);

disp(response.outputText);
```

#### 🔸 Invoke a Model (Image Generation)
```matlab
spec = struct(text="Neon skyline at dusk", seed=42, style="photographic");
resp = bedrock.invokeModel(modelId="amazon.titan-image-generator-v1", body=spec);
disp(resp.responseBody);
```

#### 🔸 Stateful Conversation (Multi-Turn; Text)
```matlab
firstPrompt = "Tell me about yourself in 50 words?";
message1 = aws.bedrock.runtime.model.Message(text = firstPrompt, role = "user");

fullConversationMessages = aws.bedrock.runtime.model.Message.empty;
fullConversationMessages(end+1) = message1;

response1 = bedrock.converse( ...
    modelId  = "amazon.titan-text-lite-v1", ...
    messages = fullConversationMessages);

fullConversationMessages(end+1) = response1.message; % keep context

secondPrompt = "Can you elaborate to 600 words?";
message2 = aws.bedrock.runtime.model.Message(text = secondPrompt);
fullConversationMessages(end+1) = message2;

response2 = bedrock.converse( ...
    modelId   = "amazon.titan-text-lite-v1", ...
    messages  = fullConversationMessages, ...
    maxTokens = 600);

disp(response2.message.text);
```

#### 🔸 Converse with Image (Vision Models Only)
```matlab
imgMsg = aws.bedrock.runtime.model.Message(imageData = imageArray); % numeric image

resp = bedrock.converse( ...
    modelId  = "<vision-capable-model-id>", ...
    messages = imgMsg);

disp(resp.message.text);
```

### 📘 6.2.3 Method Reference (Summary)

#### 🔸 `invokeModel`
```matlab
response = bedrock.invokeModel(modelId = "<model-id>", body = <string>);
```
*   Returns: `aws.bedrock.runtime.model.InvokeModelResponse`
    *   `outputText`, `completionReason`, `tokenCount` (optional)

#### 🔸 `converse`
```matlab
response = bedrock.converse( ...
    modelId   = "<model-id>", ...
    messages  = <Message | Message[]>, ...
    maxTokens = <int>);  % optional
```
*   Returns: `aws.bedrock.runtime.model.ConverseResponse`
    *   `message` (assistant message), `stopReason`, `usage`

### 💡 Notes & Best Practices

- Prefer name-value argument style for clarity and forward compatibility.
- Maintain the conversation array by appending both user and assistant turns to preserve context.
- Use a supported region like `us-east-1` for Bedrock Runtime availability.
- Roles supported here are `user` and `assistant`.
- Pass a scalar string for quick text prompts. Provide a struct/dictionary (or JSON string) when the model
  requires additional parameters (for example, image generation seed or style).

```{seealso}
🔗 Data Models:
- [ConverseResponse](AWSSDKAPI.md#aws-bedrock-runtime-model-converseresponse)
- [InvokeModelResponse](AWSSDKAPI.md#aws-bedrock-runtime-model-invokemodelresponse)
- [Message](AWSSDKAPI.md#aws-bedrock-runtime-model-message)
```
