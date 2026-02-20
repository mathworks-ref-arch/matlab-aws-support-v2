classdef DeleteFunctionResponse < aws.Object
    % DELETEFUNCTIONRESPONSE MATLAB wrapper for DeleteFunction results.
    %
    % Syntax
    %   resp = aws.lambda.model.DeleteFunctionResponse(javaResponse);
    %
    % Description
    %   The DeleteFunction API returns metadata only, so this wrapper primarily
    %   exposes the underlying Java response handle for logging/tracing.
    %
    % Example
    %   resp = lambda.deleteFunction(functionName="demoFunction");

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = DeleteFunctionResponse(varargin)
            %DELETEFUNCTIONRESPONSE Construct an instance of this class
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.lambda.model.DeleteFunctionResponse')
                obj.Handle = varargin{1};
            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end
    end
end
