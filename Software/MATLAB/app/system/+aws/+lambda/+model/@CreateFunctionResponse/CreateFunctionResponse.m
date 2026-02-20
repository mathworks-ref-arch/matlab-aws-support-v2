classdef CreateFunctionResponse < aws.Object
    % CREATEFUNCTIONRESPONSE MATLAB wrapper for CreateFunction results.
    %
    % Syntax
    %   resp = aws.lambda.model.CreateFunctionResponse(javaResponse);
    %
    % Properties
    %   functionArn  - (string) ARN identifying the created Lambda function.
    %   runtime      - (string) Runtime identifier such as "python3.12".
    %   handler      - (string) Entry point executed by Lambda.
    %   role         - (string) IAM execution role ARN.
    %   codeSize     - (int64) Size of the uploaded deployment package (bytes).
    %   lastModified - (string) Timestamp reported by Lambda for the last code update.
    %   version      - (string) Published function version.
    %
    % Example
    %   resp = lambda.createFunction(...);
    %   disp(resp.functionArn);

    % Copyright 2025 The MathWorks, Inc.

    properties
        functionArn string
        runtime string
        handler string
        role string
        codeSize int64
        lastModified string
        version string
    end

    methods
        function obj = CreateFunctionResponse(varargin)
            %CREATEFUNCTIONRESPONSE Construct an instance of this class
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.lambda.model.CreateFunctionResponse')
                obj.Handle = varargin{1};

                obj.functionArn = localString(varargin{1}.functionArn());
                obj.runtime = localString(varargin{1}.runtimeAsString());
                obj.handler = localString(varargin{1}.handler());
                obj.role = localString(varargin{1}.role());
                codeSizeVal = varargin{1}.codeSize();
                if ~isempty(codeSizeVal)
                    obj.codeSize = int64(codeSizeVal.longValue());
                end
                obj.lastModified = localString(varargin{1}.lastModified());
                obj.version = localString(varargin{1}.version());
            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
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

