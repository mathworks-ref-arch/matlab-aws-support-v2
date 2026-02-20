classdef Message < aws.Object
    %MESSAGE MATLAB representation of a Bedrock Converse message.
    %
    % The conversation history (state) is expected to be maintained on the
    % client side. Applicable only for Bedrock Runtime Converse APIs.
    %
    % Syntax
    %   msg = aws.bedrock.runtime.model.Message(text="Hello", role="user");
    %   msg = aws.bedrock.runtime.model.Message( ...
    %             text="Here is an image", imageData=imgBytes, role="user");
    %   msg = aws.bedrock.runtime.model.Message(sdkMessage=javaObj);
    %
    % Name-Value Arguments
    %   text       - (string) Message text content.
    %   imageData  - (uint8[] | struct) Image data or SDK-compatible image payload.
    %   role       - (string) "user" | "assistant" | "system" (default "user").
    %   sdkMessage - (object) Use an existing SDK Message object instead of building a new one.
    %
    % Example
    %   msg = aws.bedrock.runtime.model.Message(text="Hi", role="user");

    % Copyright 2025 The MathWorks, Inc.

    properties
        text string
        imageData
        role string
    end

    methods
        function obj = Message(options)

            arguments
                options.sdkMessage = []
                options.text {mustBeNonzeroLengthText}
                options.imageData {mustBeImage}
                options.role {mustBeValidRole} = "user"
            end

            initializeLogger(obj, 'Amazon:BedrockRuntime:Message');
            import software.amazon.awssdk.services.bedrockruntime.model.ConversationRole;
            import software.amazon.awssdk.services.bedrockruntime.model.ContentBlock;
            import software.amazon.awssdk.services.bedrockruntime.model.ImageSource;
            import software.amazon.awssdk.services.bedrockruntime.model.ImageBlock;

            if isempty(options.sdkMessage)

                % Ensure either text or imageData is provided
                if (isfield(options, "text") && isempty(options.text)) ...
                        && (isfield(options, "imageData") && isempty(options.imageData))
                    write(obj.logObj,'error','Either text or imageData must be provided.');
                end

                if isfield(options, "text")
                    obj.text = options.text;
                    contentBlock = ContentBlock.fromText(options.text);
                elseif isfield(options, "imageData")

                    obj.imageData = options.imageData;
                    sdkBytes = software.amazon.awssdk.core.SdkBytes.fromByteArray(options.imageData);
                    imageSource = ImageSource.fromBytes(sdkBytes);

                    imageBlockBuilder = ImageBlock.builder();
                    imageBlockBuilder.source(imageSource);
                    imageBlockBuilder.format(obj.getImageFormat(options.imageData));
                    imageBlock = imageBlockBuilder.build();

                    contentBlock = ContentBlock.fromImage(imageBlock);

                else
                    write(obj.logObj,'error','Invalid inputPrompt type for Message');
                    return;
                end

                % Build the Message object
                contentBlockList = java.util.ArrayList();
                contentBlockList.add(contentBlock);

                messageBuilder = software.amazon.awssdk.services.bedrockruntime.model.Message.builder();
                messageBuilder = messageBuilder.content(contentBlockList).role(ConversationRole.valueOf(upper(options.role)));
                obj.Handle = messageBuilder.build();

            else
                obj.Handle = options.sdkMessage;
                if isa(options.sdkMessage.content, 'java.util.Collections$UnmodifiableRandomAccessList')
                    obj.text = options.sdkMessage.content.get(0).text();
                end
                obj.role = char(options.sdkMessage.role);
            end
        end

        function imageFormat = getImageFormat(~, imageBytes)
            if numel(imageBytes) >= 8
                % PNG signature: 89 50 4E 47 0D 0A 1A 0A
                if isequal(imageBytes(1:8)', [137 80 78 71 13 10 26 10])
                    imageFormat = 'png';
                    % JPEG signature: FF D8 FF
                elseif isequal(imageBytes(1:3)', [255 216 255])
                    imageFormat = 'jpeg';
                    % GIF signature: GIF87a or GIF89a
                elseif isequal(char(imageBytes(1:6)'), 'GIF87a') || isequal(char(imageBytes(1:6)'), 'GIF89a')
                    imageFormat = 'gif';
                    % BMP signature: 42 4D
                elseif isequal(imageBytes(1:2)', [66 77])
                    imageFormat = 'bmp';
                else
                    imageFormat = 'unknown';
                end
            else
                imageFormat = 'unknown';
            end
        end
    end
end

function mustBeImage(input)

if ~(isnumeric(input) && (ismatrix(input) || ndims(input) == 3))    
    error('Amazon:BedrockRuntime:InvalidImage','Input must be a numeric matrix or a 3D array representing an image.');
end
end

function mustBeValidRole(input)

validRoles = ["user", "assistant", "unknown_to_sdk_version"];

if ~ismember(lower(input), validRoles)    
    error('Amazon:BedrockRuntime:InvalidRole','Role must be either "user", "assistant" or "unknown_to_sdk_version".');
end
end