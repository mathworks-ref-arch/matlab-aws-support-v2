classdef InvokeFunctionResponse < aws.Object
    % INVOKEFUNCTIONRESPONSE MATLAB wrapper for Lambda invocation results.
    %
    % Syntax
    %   resp = aws.lambda.model.InvokeFunctionResponse(javaResponse);
    %
    % Properties
    %   statusCode      - (int32) HTTP status code returned by Lambda.
    %   executedVersion - (string) Version or alias that executed.
    %   functionError   - (string) Error type when invocation failed.
    %   logResult       - (string) Base64-encoded logs when requested.
    %   payload         - (string) UTF-8 payload returned by the function.
    %
    % Example
    %   resp = lambda.invokeFunction(...);
    %   disp(resp.statusCode);

    % Copyright 2025 The MathWorks, Inc.

    properties
        statusCode int32
        executedVersion string
        functionError string
        logResult string
        payload string
    end

    methods
        function obj = InvokeFunctionResponse(varargin)
            %INVOKEFUNCTIONRESPONSE Construct an instance of this class
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.lambda.model.InvokeResponse')
                obj.Handle = varargin{1};

                statusCodeVal = varargin{1}.statusCode();
                if ~isempty(statusCodeVal)
                    obj.statusCode = int32(statusCodeVal.intValue());
                end
                obj.executedVersion = localString(varargin{1}.executedVersion());
                obj.functionError = localString(varargin{1}.functionError());
                obj.logResult = localString(varargin{1}.logResult());

                payloadBytes = varargin{1}.payload();
                if ~isempty(payloadBytes)
                    obj.payload = string(char(payloadBytes.asUtf8String()));
                else
                    obj.payload = string.empty(1,0);
                end
            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end
        
        function payload = getPayload(obj)
            %GETPAYLOAD Get the payload from the response
            if isempty(obj.payload)
                payloadBytes = obj.Handle.payload();
                if isempty(payloadBytes)
                    payload = '';
                else
                    payload = char(payloadBytes.asUtf8String());
                end
            else
                payload = char(obj.payload);
            end
        end
    end
end

function str = localString(val)
if isempty(val)
    str = string.empty(1,0);
else
    str = string(val);
end
end
