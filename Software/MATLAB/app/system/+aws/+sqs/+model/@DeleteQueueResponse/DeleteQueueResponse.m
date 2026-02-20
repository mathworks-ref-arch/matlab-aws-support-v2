classdef DeleteQueueResponse < aws.Object
    % DELETEQUEUERESPONSE Metadata returned by DeleteQueue.
    %
    % Syntax
    %   resp = aws.sqs.model.DeleteQueueResponse(javaResponse);
    %
    % Properties
    %   statusCode - (int32) HTTP status reported by the SDK.

    % Copyright 2025 The MathWorks, Inc.

    properties
        statusCode int32
    end

    methods
        function obj = DeleteQueueResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sqs.model.DeleteQueueResponse')
                obj.Handle = varargin{1};
                sdkResponse = varargin{1}.sdkHttpResponse();
                if isempty(sdkResponse)
                    obj.statusCode = int32(0);
                else
                    obj.statusCode = int32(sdkResponse.statusCode());
                end
            else
                write(obj.logObj, 'error', 'Invalid arguments for DeleteQueueResponse');
            end
        end
    end

end
