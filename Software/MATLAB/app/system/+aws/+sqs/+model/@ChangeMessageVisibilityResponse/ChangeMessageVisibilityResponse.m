classdef ChangeMessageVisibilityResponse < aws.Object
    % CHANGEMESSAGEVISIBILITYRESPONSE Metadata returned by ChangeMessageVisibility.
    %
    % Syntax
    %   resp = aws.sqs.model.ChangeMessageVisibilityResponse(javaResponse);
    %
    % Properties
    %   statusCode - (int32) HTTP status reported by the SDK.

    % Copyright 2025 The MathWorks, Inc.

    properties
        statusCode int32
    end

    methods
        function obj = ChangeMessageVisibilityResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sqs.model.ChangeMessageVisibilityResponse')
                obj.Handle = varargin{1};
                sdkResponse = varargin{1}.sdkHttpResponse();
                if isempty(sdkResponse)
                    obj.statusCode = int32(0);
                else
                    obj.statusCode = int32(sdkResponse.statusCode());
                end
            else
                write(obj.logObj, 'error', ...
                    'Invalid arguments for ChangeMessageVisibilityResponse');
            end
        end
    end
end
