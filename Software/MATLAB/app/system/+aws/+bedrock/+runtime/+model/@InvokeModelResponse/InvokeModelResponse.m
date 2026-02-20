classdef InvokeModelResponse < aws.Object
    %INVOKEMODELRESPONSE MATLAB wrapper for Bedrock Invoke Model response.
    %
    % Properties
    %   inputTextTokenCount - (int32) Number of input tokens processed.
    %   outputText          - (string) The generated text output.
    %   tokenCount          - (int32) Total tokens counted (input + output), if provided.
    %   completionReason    - (string) Reason the generation completed (e.g., "LENGTH", "STOP").
    %
    % Example
    %   % After calling bedrock.invokeModel(...)
    %   resp = bedrock.invokeModel(modelId="...", body=payload);
    %   disp(resp.outputText)
    %   disp(resp.completionReason)

    % Copyright 2025 The MathWorks, Inc.


    properties
        inputTextTokenCount int32;
        outputText string;
        tokenCount int32;
        completionReason string;
    end

    methods
        function obj = InvokeModelResponse(varargin)

            if nargin == 1 && isa(varargin{1}, 'software.amazon.awssdk.services.bedrockruntime.model.InvokeModelResponse')
                obj.Handle = varargin{1};
            elseif nargin == 2 && isStringScalar(varargin{1}) ...
                    && isa(varargin{2}, 'software.amazon.awssdk.services.bedrockruntime.model.InvokeModelResponse')
                responseData = aws.bedrock.runtime.utils.parseModelResponse( ...
                    char(varargin{1}), varargin{2}.body.asUtf8String());
                obj.outputText = responseData.outputText;
                obj.completionReason = responseData.completionReason;
                if isfield(responseData, 'tokenCount')
                    obj.tokenCount = responseData.tokenCount;
                end
            else
                write(obj.logObj,'error','Invalid argument type');
            end
        end

    end
end

