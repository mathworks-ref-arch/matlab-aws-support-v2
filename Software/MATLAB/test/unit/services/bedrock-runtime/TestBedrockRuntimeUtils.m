classdef TestBedrockRuntimeUtils < matlab.unittest.TestCase
    % Tests for buildModelPayload and parseModelResponse
    %
    % This suite validates:
    %   - JSON payload schema for all supported modelIds in buildModelPayload
    %   - Response parsing for all implemented modelIds in parseModelResponse
    %   - Error behavior for unknown/unsupported modelIds
    %   - Missing argument behavior for payload builders that expect >1 arg
    %
    % Notes:
    % - Tests use jsondecode(jsonString) to validate payload shapes.
    % - For response parsing tests, we fabricate minimal JSON bodies that match
    %   your parse switch's expected fields.

    % Copyright 2025 The MathWorks, Inc.

    %% ---------- buildModelPayload tests ----------
    methods(Test, TestTags = {'Unit'})
        function testBuild_ai21_mid(testCase)
            prompt = 'Hello world';
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('ai21.j2-mid-v1', prompt));
            testCase.verifyEqual(s.prompt, prompt);
        end

        function testBuild_titan_image_generator(testCase)
            prompt = 'a cat in space';
            seed = 12345;
            spec = struct( ...
                'taskType', 'TEXT_IMAGE', ...
                'textToImageParams', struct('text', prompt), ...
                'imageGenerationConfig', struct('seed', seed));
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('amazon.titan-image-generator-v1', spec));
            testCase.verifyEqual(s.taskType, 'TEXT_IMAGE');
            testCase.verifyEqual(s.textToImageParams.text, prompt);
            testCase.verifyEqual(s.imageGenerationConfig.seed, seed);
        end

        function testBuild_titan_text_premier(testCase)
            prompt = 'Summarize:';
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('amazon.titan-text-premier-v1:0', prompt));
            testCase.verifyEqual(s.inputText, prompt);
        end

        function testBuild_titan_text_express(testCase)
            prompt = 'Explain:';
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('amazon.titan-text-express-v1', prompt));
            testCase.verifyEqual(s.inputText, prompt);
        end

        function testBuild_titan_text_lite(testCase)
            prompt = 'Draft:';
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('amazon.titan-text-lite-v1', prompt));
            testCase.verifyEqual(s.inputText, prompt);
        end

        function testBuild_titan_embed_text_v2(testCase)
            txt = 'embed this';
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('amazon.titan-embed-text-v2:0', txt));
            testCase.verifyEqual(s.inputText, txt);
        end

        function testBuild_anthropic_claude3_haiku(testCase)
            prompt = "Who won?";
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('anthropic.claude-3-haiku-20240307-v1:0', prompt));
            testCase.verifyEqual(s.anthropic_version, 'bedrock-2023-05-31');
            testCase.verifyEqual(s.max_tokens, 512);
            testCase.verifyEqual(s.temperature, 0.5, 'AbsTol', 1e-12);
            testCase.verifyTrue(isfield(s, 'messages'));
            testCase.verifyEqual(numel(s.messages), 1);
            testCase.verifyEqual(string(s.messages(1).role), "user");
            testCase.verifyEqual(string(s.messages(1).content), prompt);
        end

        function testBuild_cohere_command_r(testCase)
            prompt = 'Plan a trip';
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('cohere.command-r-v1:0', prompt));
            testCase.verifyEqual(s.message, prompt);
        end

        function testBuild_cohere_command_light(testCase)
            prompt = 'Rewrite:';
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('cohere.command-light-text-v14', prompt));
            testCase.verifyEqual(s.prompt, prompt);
        end

        function testBuild_llama2_13b_chat(testCase)
            prompt = 'Greet me';
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('meta.llama2-13b-chat-v1', prompt));
            testCase.verifyTrue(isfield(s, 'prompt'));
            % Prompt contains the original text (formatting tokens may vary)
            testCase.verifyNotEmpty(contains(string(s.prompt), prompt));
        end

        function testBuild_llama3_8b_instruct(testCase)
            prompt = 'List 3 items';
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('meta.llama3-8b-instruct-v1:0', prompt));
            testCase.verifyTrue(isfield(s, 'prompt'));
            testCase.verifyNotEmpty(contains(string(s.prompt), prompt));
        end

        function testBuild_mistral_large(testCase)
            prompt = 'Translate this';
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('mistral.mistral-large-2402-v1:0', prompt));
            testCase.verifyTrue(isfield(s, 'prompt'));
            testCase.verifyNotEmpty(contains(string(s.prompt), prompt));
        end

        function testBuild_stability_sdxl(testCase)
            prompt = 'A mountain lake at sunrise';
            seed = 42;
            style = 'photographic';

            spec = struct( ...
                'style_preset', style, ...
                'text_prompts', struct('text', prompt), ...
                'seed', seed);
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('stability.stable-diffusion-xl-v1', spec));
            testCase.verifyTrue(isfield(s, 'text_prompts'));
            testCase.verifyEqual(s.text_prompts.text, prompt);
            testCase.verifyEqual(s.style_preset, style);
            testCase.verifyEqual(s.seed, seed);
        end

        function testBuild_MissingArgs_stabilityAndTitanImage(testCase)
            % Expect indexing error when required args are missing
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('amazon.titan-image-generator-v1', "p"), 'aws:bedrock:buildModelPayload:UnsupportedModel');
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('stability.stable-diffusion-xl-v1', struct("p", int64(1))), 'aws:bedrock:buildModelPayload:MissingField');
        end

        function testBuild_UnknownModelId_throws(testCase)
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('unknown.model', "prompt"), 'aws:bedrock:buildModelPayload:UnsupportedModel');
        end

    end

    %% ---------- parseModelResponse tests ----------
    methods(Test, TestTags = {'Unit'})
        function testParse_ai21_mid(testCase)
            body = jsonencode(struct( ...
                'completions', struct( ...
                'data', struct('text', "OK", 'tokens', 12, 'completionReason', "stop") ...
                ) ...
                ));
            r = aws.bedrock.runtime.utils.parseModelResponse('ai21.j2-mid-v1', body);
            testCase.verifyEqual(r.outputText, 'OK');
            testCase.verifyEqual(r.tokenCount, 12);
            testCase.verifyEqual(r.completionReason, 'stop');
        end

        function testParse_titan_image_generator(testCase)
            body = jsonencode(struct( ...
                'images', {{'BASE64DATA'}}, ...
                'tokenCount', 77, ...
                'completionReason', "ok" ...
                ));
            r = aws.bedrock.runtime.utils.parseModelResponse('amazon.titan-image-generator-v1', body);
            testCase.verifyEqual(r.outputText, {'BASE64DATA'});
            testCase.verifyEqual(r.tokenCount, 77);
            testCase.verifyEqual(r.completionReason, 'ok');
        end

        function testParse_titan_text_premier(testCase)
            body = jsonencode(struct( ...
                'results', struct('outputText', "resp", 'tokenCount', 33, 'completionReason', "stop") ...
                ));
            r = aws.bedrock.runtime.utils.parseModelResponse('amazon.titan-text-premier-v1:0', body);
            testCase.verifyEqual(r.outputText, 'resp');
            testCase.verifyEqual(r.tokenCount, 33);
            testCase.verifyEqual(r.completionReason, 'stop');
        end

        function testParse_titan_text_express(testCase)
            body = jsonencode(struct( ...
                'results', struct('outputText', "resp2", 'completionReason', "len") ...
                ));
            r = aws.bedrock.runtime.utils.parseModelResponse('amazon.titan-text-express-v1', body);
            testCase.verifyEqual(r.outputText, 'resp2');            
            testCase.verifyEqual(r.completionReason, 'len');
        end

        function testParse_anthropic_claude3_haiku(testCase)
            body = jsonencode(struct( ...
                'content', struct('text', "Answer"), ...
                'usage', struct('output_tokens', 101), ...
                'stop_reason', "end_turn" ...
                ));
            r = aws.bedrock.runtime.utils.parseModelResponse('anthropic.claude-3-haiku-20240307-v1:0', body);
            testCase.verifyEqual(r.outputText, 'Answer');
            testCase.verifyEqual(r.tokenCount, 101);
            testCase.verifyEqual(r.completionReason, 'end_turn');
        end

        function testParse_cohere_command_r(testCase)
            body = jsonencode(struct( ...
                'text', "Cohere reply", ...
                'tokenCount', 9, ...
                'completionReason', "stop" ...
                ));
            r = aws.bedrock.runtime.utils.parseModelResponse('cohere.command-r-v1:0', body);
            testCase.verifyEqual(r.outputText, 'Cohere reply');
            testCase.verifyEqual(r.tokenCount, 9);
            testCase.verifyEqual(r.completionReason, 'stop');
        end

        function testParse_cohere_command_light(testCase)
            body = jsonencode(struct( ...
                'generations', struct('text', "Light reply", 'tokenCount', 7, 'completionReason', "stop") ...
                ));
            r = aws.bedrock.runtime.utils.parseModelResponse('cohere.command-light-text-v14', body);
            testCase.verifyEqual(r.outputText, 'Light reply');
            testCase.verifyEqual(r.tokenCount, 7);
            testCase.verifyEqual(r.completionReason, 'stop');
        end

        function testParse_llama2_chat(testCase)
            body = jsonencode(struct( ...
                'generation', "Hi!", ...
                'generation_token_count', 4, ...
                'stop_reason', "eos" ...
                ));
            r = aws.bedrock.runtime.utils.parseModelResponse('meta.llama2-13b-chat-v1', body);
            testCase.verifyEqual(r.outputText, 'Hi!');
            testCase.verifyEqual(r.tokenCount, 4);
            testCase.verifyEqual(r.completionReason, 'eos');
        end

        function testParse_llama3_instruct(testCase)
            body = jsonencode(struct( ...
                'generation', "OK", ...
                'generation_token_count', 5, ...
                'stop_reason', "eos" ...
                ));
            r = aws.bedrock.runtime.utils.parseModelResponse('meta.llama3-8b-instruct-v1:0', body);
            testCase.verifyEqual(r.outputText, 'OK');
            testCase.verifyEqual(r.tokenCount, 5);
            testCase.verifyEqual(r.completionReason, 'eos');
        end

        function testParse_mistral_large(testCase)
            body = jsonencode(struct( ...
                'outputs', struct('text', "Mistral out", 'tokenCount', 21, 'completionReason', "stop") ...
                ));
            r = aws.bedrock.runtime.utils.parseModelResponse('mistral.mistral-large-2402-v1:0', body);
            testCase.verifyEqual(r.outputText, 'Mistral out');
            testCase.verifyEqual(r.tokenCount, 21);
            testCase.verifyEqual(r.completionReason, 'stop');
        end

        function testParse_stability_sdxl(testCase)
            body = jsonencode(struct( ...
                'artifacts', struct('base64', "BASE64IMG"), ...
                'tokenCount', 12, ...
                'completionReason', "ok" ...
                ));
            r = aws.bedrock.runtime.utils.parseModelResponse('stability.stable-diffusion-xl-v1', body);
            testCase.verifyEqual(r.outputText, 'BASE64IMG');
            testCase.verifyEqual(r.tokenCount, 12);
            testCase.verifyEqual(r.completionReason, 'ok');
        end

        function testParse_UnknownModelId_throws(testCase)
            body = jsonencode(struct('foo', 1));
            testCase.verifyError(@() aws.bedrock.runtime.utils.parseModelResponse('unknown.model', body), 'aws:bedrock:UnsupportedResponse');
        end

        function testParse_ModelsWithoutParseCases_throw(testCase)
            % These modelIds have build payloads but no parse cases in your switch
            body = jsonencode(struct('foo', 1));
            testCase.verifyError(@() aws.bedrock.runtime.utils.parseModelResponse('amazon.titan-text-lite-v1', body), 'aws:bedrock:UnsupportedResponse');
            testCase.verifyError(@() aws.bedrock.runtime.utils.parseModelResponse('amazon.titan-embed-text-v2:0', body), 'MATLAB:nonExistentField');
        end

        function testParse_missingFieldsInKnownModel(testCase)
            body = jsonencode(struct('results', struct())); % Missing outputText, tokenCount, etc.
            testCase.verifyError(@() aws.bedrock.runtime.utils.parseModelResponse('amazon.titan-text-premier-v1:0', body), 'MATLAB:nonExistentField');
        end

        function testParse_multipleCompletions(testCase)
            body = jsonencode(struct( ...
                'completions', [ ...
                struct('data', struct('text', "First", 'tokens', 10, 'completionReason', "stop")), ...
                struct('data', struct('text', "Second", 'tokens', 20, 'completionReason', "stop")) ...
                ] ...
                ));
            r = aws.bedrock.runtime.utils.parseModelResponse('ai21.j2-mid-v1', body);
            testCase.verifyEqual(r.outputText, 'First'); % Still uses first completion
        end


        function testBuild_RawJSONString_PassThrough_Object(testCase)
            % JSON object should pass through unchanged
            raw = '{"key":"value","n":5}';
            out = aws.bedrock.runtime.utils.buildModelPayload('ai21.j2-mid-v1', raw);
            testCase.verifyClass(out, 'char');
            s = jsondecode(out);
            testCase.verifyEqual(s.key, 'value');
            testCase.verifyEqual(s.n, 5);
        end

        function testBuild_RawJSONString_PassThrough_Array(testCase)
            % JSON array should also pass through unchanged
            raw = '["a", 1, {"x":true}]';
            out = aws.bedrock.runtime.utils.buildModelPayload('ai21.j2-mid-v1', raw);
            % Should not throw or wrap; verify starts with '['
            testCase.verifyEqual(out(1), '[');
            v = jsondecode(out);
            testCase.verifyEqual(v{1}, 'a');
            testCase.verifyEqual(v{2}, 1);
            testCase.verifyTrue(v{3}.x);
        end

        function testBuild_PromptWithWhitespace_StillRecognizedAsRawJSON(testCase)
            % Leading whitespace should not block "{"/"[" detection (trimmed)
            raw = sprintf('   { "a": 1 }   ');
            out = aws.bedrock.runtime.utils.buildModelPayload('ai21.j2-mid-v1', raw);
            s = jsondecode(out);
            testCase.verifyEqual(s.a, 1);
        end

        function testBuild_CharInputVsStringInput_Equivalent(testCase)
            % Ensure char input works same as string for supported models
            promptChar = 'Hello as char';
            promptStr = "Hello as char";
            s1 = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('ai21.j2-mid-v1', promptChar));
            s2 = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('ai21.j2-mid-v1', promptStr));
            testCase.verifyEqual(s1.prompt, char(promptStr));
            testCase.verifyEqual(s2.prompt, char(promptStr));
        end

        function testBuild_Dictionary_Simple(testCase)
            d = dictionary(["text","seed","style"], { "castle", 777, "cinematic" });
            out = aws.bedrock.runtime.utils.buildModelPayload('stability.stable-diffusion-xl-v1', d);
            s = jsondecode(out);
            testCase.verifyEqual(s.text_prompts.text, 'castle');
            testCase.verifyEqual(s.seed, 777);
            testCase.verifyEqual(s.style_preset, 'cinematic');

        end

        function testBuild_Dictionary_NestedAndCellUnwrap(testCase)
            % Nested dictionary becomes nested struct; single-element cell unwraps.
            inner = dictionary(["text","seed","style"], { "castle", 777, "cinematic" });
            d = dictionary("spec", inner);

            % Pass the *value* for 'spec' (use key indexing, not dot)
            spec = d("spec"); % returns the inner dictionary object
            payload = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('stability.stable-diffusion-xl-v1', spec));

            % ensureStableDiffusionSpec builds canonical payload
            testCase.verifyTrue(isfield(payload, "text_prompts"));
            testCase.verifyEqual(payload.text_prompts.text, 'castle');
            testCase.verifyEqual(payload.style_preset, 'cinematic');
            testCase.verifyEqual(payload.seed, 777);
        end


        function testBuild_SDXL_AutoNormalize_MinimalFields(testCase)
            % Provide minimal fields to trigger ensureStableDiffusionSpec
            spec = struct('text', "a lake", 'seed', int64(101), 'style', "photographic");
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('stability.stable-diffusion-xl-v1', spec));
            testCase.verifyTrue(isfield(s, 'text_prompts'));
            testCase.verifyEqual(s.text_prompts.text, 'a lake');
            testCase.verifyEqual(s.style_preset, 'photographic');
            testCase.verifyEqual(double(s.seed), 101);
        end

        function testBuild_SDXL_PassThrough_WhenAlreadyNormalized(testCase)
            % If text_prompts present, normalization should pass through
            spec = struct('text_prompts', struct('text', 'fox'), 'style_preset', 'analog-film', 'seed', 5);
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('stability.stable-diffusion-xl-v1', spec));
            testCase.verifyEqual(s.text_prompts.text, 'fox');
            testCase.verifyEqual(s.style_preset, 'analog-film');
            testCase.verifyEqual(s.seed, 5);
        end

        function testBuild_TitanImage_AutoNormalize_MinimalFields(testCase)
            % Provide minimal fields to trigger ensureTitanImageSpec
            spec = struct('text', "a cat in space", 'seed', uint32(123));
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('amazon.titan-image-generator-v1', spec));
            testCase.verifyEqual(s.taskType, 'TEXT_IMAGE');
            testCase.verifyEqual(s.textToImageParams.text, 'a cat in space');
            testCase.verifyEqual(double(s.imageGenerationConfig.seed), 123);
        end

        function testBuild_TitanImage_AutoNormalize_WithOptionalStyle(testCase)
            spec = struct('text', "portrait", 'seed', 9, 'style', 'ANIME');
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('amazon.titan-image-generator-v1', spec));
            testCase.verifyEqual(s.taskType, 'TEXT_IMAGE');
            testCase.verifyEqual(s.textToImageParams.text, 'portrait');
            testCase.verifyEqual(s.imageGenerationConfig.seed, 9);
            testCase.verifyEqual(s.imageGenerationConfig.style, 'ANIME');
        end

        function testBuild_TitanImage_PassThrough_WhenAlreadyNormalized(testCase)
            prompt = 'nebula';
            seed = 77;
            spec = struct( ...
                'taskType', 'TEXT_IMAGE', ...
                'textToImageParams', struct('text', prompt), ...
                'imageGenerationConfig', struct('seed', seed, 'style', 'PHOTOREALISTIC'));
            s = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('amazon.titan-image-generator-v1', spec));
            testCase.verifyEqual(s.textToImageParams.text, prompt);
            testCase.verifyEqual(s.imageGenerationConfig.seed, seed);
            testCase.verifyEqual(s.imageGenerationConfig.style, 'PHOTOREALISTIC');
        end

        function testBuild_UnsupportedPayloadType_Throws(testCase)
            % Non string/char/struct/dictionary should error
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('ai21.j2-mid-v1', 123), ...
                'aws:bedrock:buildModelPayload:UnsupportedPayload');
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('ai21.j2-mid-v1', datetime('now')), ...
                'aws:bedrock:buildModelPayload:UnsupportedPayload');
        end

        function testBuild_SDXL_MissingRequiredField_ErrorMessages(testCase)
            % Missing text
            specNoText = struct('seed', 1, 'style', 'cinematic');
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('stability.stable-diffusion-xl-v1', specNoText), ...
                'aws:bedrock:buildModelPayload:MissingField');
            % Missing seed
            specNoSeed = struct('text', "x", 'style', 'cinematic');
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('stability.stable-diffusion-xl-v1', specNoSeed), ...
                'aws:bedrock:buildModelPayload:MissingField');
            % Missing style
            specNoStyle = struct('text', "x", 'seed', 1);
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('stability.stable-diffusion-xl-v1', specNoStyle), ...
                'aws:bedrock:buildModelPayload:MissingField');
        end

        function testBuild_TitanImage_MissingRequiredField_ErrorMessages(testCase)
            % Missing text
            specNoText = struct('seed', 123);
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('amazon.titan-image-generator-v1', specNoText), ...
                'aws:bedrock:buildModelPayload:MissingField');
            % Missing seed
            specNoSeed = struct('text', "hi");
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('amazon.titan-image-generator-v1', specNoSeed), ...
                'aws:bedrock:buildModelPayload:MissingField');
        end

        function testBuild_SDXL_InvalidType_ErrorMessages(testCase)
            % Wrong types hit requireStringField / requireNumericField
            specBadText = struct('text', 123, 'seed', 1, 'style', 'cinematic');
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('stability.stable-diffusion-xl-v1', specBadText), ...
                'aws:bedrock:buildModelPayload:InvalidFieldType');

            specBadSeed = struct('text', "ok", 'seed', [1 2], 'style', 'cinematic');
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('stability.stable-diffusion-xl-v1', specBadSeed), ...
                'aws:bedrock:buildModelPayload:InvalidFieldType');

            specBadStyle = struct('text', "ok", 'seed', 1, 'style', ["a","b"]);
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('stability.stable-diffusion-xl-v1', specBadStyle), ...
                'aws:bedrock:buildModelPayload:InvalidFieldType');
        end

        function testBuild_TitanImage_InvalidType_ErrorMessages(testCase)
            specBadText = struct('text', 123, 'seed', 1);
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('amazon.titan-image-generator-v1', specBadText), ...
                'aws:bedrock:buildModelPayload:InvalidFieldType');

            specBadSeed = struct('text', "ok", 'seed', [1 2]);
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('amazon.titan-image-generator-v1', specBadSeed), ...
                'aws:bedrock:buildModelPayload:InvalidFieldType');
        end

        function testBuild_isStringOrCharScalar_PositiveAndNegative(testCase)
            % Indirect exercise via supported types; but we can also call private logic by behavior
            % Positive (string scalar)
            s1 = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('ai21.j2-mid-v1', "x"));
            testCase.verifyEqual(s1.prompt, 'x');
            % Positive (char)
            s2 = jsondecode(aws.bedrock.runtime.utils.buildModelPayload('ai21.j2-mid-v1', 'y'));
            testCase.verifyEqual(s2.prompt, 'y');
            % Negative (string array -> should error UnsupportedPayload)
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('ai21.j2-mid-v1', ["a","b"]), ...
                'aws:bedrock:buildModelPayload:UnsupportedPayload');
        end

        function testBuild_buildTemplateFromPrompt_UnknownModel_throws(testCase)
            % Verifies the "requires a structured payload" path for unknown-in-switch model
            testCase.verifyError(@() aws.bedrock.runtime.utils.buildModelPayload('unknown.model', "prompt"), ...
                'aws:bedrock:buildModelPayload:UnsupportedModel');
        end

    end
end