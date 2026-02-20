classdef DeleteMessageResponse < aws.Object
    % DELETEMESSAGERESPONSE Metadata returned by DeleteMessage.
    %
    % Syntax
    %   resp = aws.sqs.model.DeleteMessageResponse(javaResponse);
    %
    % Properties
    %   statusCode - (int32) HTTP status reported by the SDK.
    %
    % Copyright 2025 The MathWorks, Inc.

    properties
        statusCode int32
    end

    methods
        function obj = DeleteMessageResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sqs.model.DeleteMessageResponse')
                obj.Handle = varargin{1};
                sdkResp = varargin{1}.sdkHttpResponse();
                if isempty(sdkResp)
                    obj.statusCode = int32(0);
                else
                    obj.statusCode = int32(sdkResp.statusCode());
                end
            else
                write(obj.logObj, 'error', 'Invalid arguments');
                error('AWS:SQS:InvalidInput', 'Invalid arguments for DeleteMessageResponse');
            end
        end
    end
end
