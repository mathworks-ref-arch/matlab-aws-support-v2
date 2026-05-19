classdef TestBedrockRuntimeClient < matlab.unittest.TestCase
    % TESTCLIENT Unit Test for the Amazon Bedrock Runtime Client
    % The test suite exercises the basic operations on the Amazon Bedrock Runtime Client.

    % Copyright 2025 The MathWorks, Inc.

    properties
        logObj
        bedrockRuntime
        isOnGitlab
    end
    methods(TestClassSetup)
        % Shared setup for the entire test class
        function testSetup(testCase)
            testCase.logObj = Logger.getLogger();
            testCase.logObj.DisplayLogLevel = 'verbose';

        end
        function checkGitlab(testCase)
            host=getenv('CI_RUNNER_DESCRIPTION');
            testCase.isOnGitlab = ~isempty(host);
        end

        function initializeBedrockRuntimeClient(testCase)
            %Since bedrock is unavailable in default us-west-1 region,
            %overriding the region
            region = 'us-east-1';
            if testCase.isOnGitlab
                credentials = loadConfigurationSettings('credentials.json');
                credentialProvider = aws.auth.CredentialProvider.getSessionCredentialProvider( ...
                    credentials.aws_access_key_id, credentials.aws_secret_access_key, ...
                    credentials.aws_session_token);
                testCase.bedrockRuntime = aws.bedrock.runtime.Client( ...
                    'credentialsprovider', credentialProvider, 'region', region);

            else
                testCase.bedrockRuntime = aws.bedrock.runtime.Client('region', region);
            end

        end
    end

    methods(Test, TestTags = {'Unit'})
        % Test methods
        function testConstructor(testCase)
            write(testCase.logObj,'debug','Testing testConstructor');
            testCase.verifyClass(testCase.bedrockRuntime,'aws.bedrock.runtime.Client');
        end
        function testInvalidConversationRole(testCase)
            write(testCase.logObj,'debug','Testing testConverse');
            textPrompt = "What is your name?";
            createInvalidMessage = @() aws.bedrock.runtime.model.Message('text', textPrompt, ...
                'role', "invalid_role");

            write(testCase.logObj,'debug',"______________PROMPT_______________");
            write(testCase.logObj,'debug',textPrompt);
            testCase.verifyError(createInvalidMessage, "Amazon:BedrockRuntime:InvalidRole");

        end

        function testInvalidImage(testCase)
            write(testCase.logObj,'debug','Testing testConverse');
            textPrompt = "What is your name?";
            createInvalidMessage = @() aws.bedrock.runtime.model.Message('imageData', textPrompt, ...
                'role', "invalid_role");

            write(testCase.logObj,'debug',"______________PROMPT_______________");
            write(testCase.logObj,'debug',textPrompt);
            testCase.verifyError(createInvalidMessage, "Amazon:BedrockRuntime:InvalidImage");

        end

    end
    methods(Test, TestTags = {'Unit'})
        % Test the invoke method. This will call the bedrockruntime service
        % once with a test prompt.
        function testInvokeModel(testCase)
            write(testCase.logObj,'debug','Testing testInvokeModel');
            % Create the Client and initialize

            textPrompt = "What is your name?";
            response = testCase.bedrockRuntime.invokeModel( ...
                modelId='amazon.nova-lite-v1:0', body=textPrompt);

            write(testCase.logObj,'debug',"______________PROMPT_______________");
            write(testCase.logObj,'debug',textPrompt);
            write(testCase.logObj,'debug',"______________RESPONSE_______________");
            write(testCase.logObj,'debug',response.outputText);
            write(testCase.logObj,'debug',"___________________________________");

            testCase.verifyNotEmpty(response.outputText);

        end

        % Test the converse method.
        function testConverse(testCase)
            write(testCase.logObj,'debug','Testing testConverse');
            textPrompt = "What is your name?";
            message1 = aws.bedrock.runtime.model.Message(text = textPrompt);
            response = testCase.bedrockRuntime.converse(modelId="amazon.nova-lite-v1:0", ...
                messages=message1);

            write(testCase.logObj,'debug',"______________PROMPT_______________");
            write(testCase.logObj,'debug',textPrompt);
            write(testCase.logObj,'debug',"______________RESPONSE_______________");
            write(testCase.logObj,'debug',response.message.text);
            write(testCase.logObj,'debug',"___________________________________");

            testCase.verifyEqual(lower(response.message.role), "assistant");

        end

        % Test the stateful conversation. The second invocation of the
        % converse method justs asks for elaboration from the previous
        % invocation.
        function testStatefulConversation(testCase)
            write(testCase.logObj,'debug','Testing testConverse');

            % Prompt to ask the model for a short description
            firstPrompt = "Tell me about yourself in 50 words?";
            message1 = aws.bedrock.runtime.model.Message(text = firstPrompt, role = "user");

            % Track the conversation
            fullConversationMessages = aws.bedrock.runtime.model.Message.empty;
            fullConversationMessages(end+1) = message1;

            % First invocation
            response1 = testCase.bedrockRuntime.converse(modelId="amazon.nova-lite-v1:0", ...
                messages=fullConversationMessages);

            write(testCase.logObj,'debug',"______________PROMPT_______________");
            write(testCase.logObj,'debug',message1.text);
            write(testCase.logObj,'debug',"______________RESPONSE_______________");
            write(testCase.logObj,'debug',response1.message.text);
            write(testCase.logObj,'debug',"___________________________________");

            testCase.verifyEqual(response1.message.role, "assistant");

            % Append Output Messages
            fullConversationMessages(end+1) = response1.message;

            % Second Exchange of Messages
            secondPrompt = "Can you elaborate to 600 words?";
            message2 = aws.bedrock.runtime.model.Message(text = secondPrompt);

            fullConversationMessages(end+1) = message2;

            response2 = testCase.bedrockRuntime.converse(modelId="amazon.nova-lite-v1:0", ...
                messages = fullConversationMessages, maxTokens=600);

            write(testCase.logObj,'debug',"______________PROMPT_______________");
            write(testCase.logObj,'debug',message2.text);
            write(testCase.logObj,'debug',"______________RESPONSE_______________");
            write(testCase.logObj,'debug',response2.message.text);
            write(testCase.logObj,'debug',"___________________________________");

            testCase.verifyEqual(response2.message.role, "assistant");

        end

        % Test the stateful conversation. The second invocation of the
        % converse method justs asks for elaboration from the previous
        % invocation.
        function testImageModel(testCase)
            write(testCase.logObj,'debug','Testing testConverse');

            imageName = "peppers.png";
            fid = fopen(imageName, 'rb');
            imageBytes = fread(fid, inf, 'uint8');

            message1 = aws.bedrock.runtime.model.Message(imageData = imageBytes, role="user");

            % Track the conversation
            fullConversationMessages = aws.bedrock.runtime.model.Message.empty;
            fullConversationMessages(end+1) = message1;

            % First invocation
            response1 = testCase.bedrockRuntime.converse(modelId="amazon.nova-lite-v1:0", ...
                messages=fullConversationMessages);

            write(testCase.logObj,'debug',"______________IMAGE PROMPT_______________");
            write(testCase.logObj,'debug',imageName);
            write(testCase.logObj,'debug',"______________RESPONSE_______________");
            write(testCase.logObj,'debug',response1.message.text);
            write(testCase.logObj,'debug',"___________________________________");

            testCase.verifyEqual(response1.message.role, "assistant");

            % Append Output Messages
            fullConversationMessages(end+1) = response1.message;

            % Second Exchange of Messages
            secondPrompt = "List the Items Name and Quantity in a table format?";
            message2 = aws.bedrock.runtime.model.Message(text = secondPrompt);
            fullConversationMessages(end+1) = message2;

            response2 = testCase.bedrockRuntime.converse(modelId="amazon.nova-lite-v1:0", ...
                messages=fullConversationMessages);

            write(testCase.logObj,'debug',"______________PROMPT_______________");
            write(testCase.logObj,'debug',secondPrompt);
            write(testCase.logObj,'debug',"______________RESPONSE_______________");

            write(testCase.logObj,'debug',response2.message.text);
            write(testCase.logObj,'debug',"___________________________________");

            testCase.verifyEqual(response2.message.role, "assistant");

            fclose(fid);

        end
        % testStatefulConversation

        function testConverseWithoutTopP(testCase)
            % Verify converse succeeds when topP is omitted (default).
            write(testCase.logObj,'debug','Testing testConverseWithoutTopP');
            textPrompt = "Reply with one word: hello";
            message1 = aws.bedrock.runtime.model.Message(text = textPrompt);
            response = testCase.bedrockRuntime.converse( ...
                modelId="amazon.nova-lite-v1:0", ...
                messages=message1, temperature=single(0.5));

            testCase.verifyEqual(lower(response.message.role), "assistant");
            testCase.verifyNotEmpty(response.message.text);
        end

        function testConverseWithExplicitTopP(testCase)
            % Verify converse succeeds when topP is explicitly provided.
            write(testCase.logObj,'debug','Testing testConverseWithExplicitTopP');
            textPrompt = "Reply with one word: hello";
            message1 = aws.bedrock.runtime.model.Message(text = textPrompt);
            response = testCase.bedrockRuntime.converse( ...
                modelId="amazon.nova-lite-v1:0", ...
                messages=message1, topP=single(0.9));

            testCase.verifyEqual(lower(response.message.role), "assistant");
            testCase.verifyNotEmpty(response.message.text);
        end

        function testConverseWithSystemPrompt(testCase)
            % Verify converse passes system prompt correctly.
            write(testCase.logObj,'debug','Testing testConverseWithSystemPrompt');
            textPrompt = "What are you?";
            message1 = aws.bedrock.runtime.model.Message(text = textPrompt);
            response = testCase.bedrockRuntime.converse( ...
                modelId="amazon.nova-lite-v1:0", ...
                messages=message1, ...
                systemPrompt="You are a helpful assistant. Always respond in exactly one sentence.");

            testCase.verifyEqual(lower(response.message.role), "assistant");
            testCase.verifyNotEmpty(response.message.text);
        end

    end % Test

end % classdef
