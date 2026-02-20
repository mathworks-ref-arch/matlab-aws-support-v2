classdef SetQueueAttributesResponse < aws.Object
    % SETQUEUEATTRIBUTESRESPONSE Metadata returned by SetQueueAttributes.
    %
    % Syntax
    %   resp = aws.sqs.model.SetQueueAttributesResponse(javaResponse);
    %
    % Properties
    %   statusCode - (int32) HTTP status reported by the SDK.

    % Copyright 2025 The MathWorks, Inc.

    properties
        statusCode int32
    end

    methods
        function obj = SetQueueAttributesResponse(varargin)
            if nargin == 1 && isa(varargin{1}, 'software.amazon.awssdk.services.sqs.model.SetQueueAttributesResponse')
                obj.Handle = varargin{1};
                sdkResp = varargin{1}.sdkHttpResponse();
                if isempty(sdkResp)
                    obj.statusCode = int32(0);
                else
                    obj.statusCode = int32(sdkResp.statusCode());
                end
            else
                write(obj.logObj,'error','Invalid number of arguments');
            end
        end
    end
end
