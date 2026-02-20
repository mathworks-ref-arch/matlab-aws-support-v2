classdef ConverseResponse < aws.Object
    %CONVERSERESPONSE MATLAB wrapper for Bedrock Converse response.
    %
    % Properties
    %   message    - (aws.bedrock.runtime.model.Message) The returned assistant/user message.
    %   usage      - (struct | object) Token usage or model-specific usage details (if available).
    %   stopReason - (string) Reason why generation stopped (e.g., "max_tokens", "end_turn").
    %
    % Example
    %   resp = bedrock.converse(...);
    %   disp(resp.message.text)
    %   disp(resp.stopReason)

    % Copyright 2025 The MathWorks, Inc.

    properties
        message aws.bedrock.runtime.model.Message;
        usage;
        stopReason string;
    end

    methods
        function obj = ConverseResponse(varargin)
            if nargin == 1
                if isa(varargin{1}, 'software.amazon.awssdk.services.bedrockruntime.model.ConverseResponse')
                    obj.Handle = varargin{1};

                    %Aletrnatively can use obj.Handle.body.asByteArray() and native2unicode
                    %and
                    obj.message = aws.bedrock.runtime.model.Message(sdkMessage = obj.Handle.output.message());

                    obj.stopReason = obj.Handle.stopReason;
                    obj.usage = obj.Handle.usage;
                else
                    write(obj.logObj,'error','Invalid argument type');
                end
            elseif nargin == 0
                obj.Handle = software.amazon.awssdk.services.bedrockruntime.model.ConverseResponse();
            else
                write(obj.logObj,'error', 'Invalid arguments');
            end
        end
    end
end