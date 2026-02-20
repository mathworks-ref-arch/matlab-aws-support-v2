classdef UnsubscribeResponse < aws.Object
    % UNSUBSCRIBERESPONSE Metadata returned by Unsubscribe.
    %
    % Syntax
    %   resp = aws.sns.model.UnsubscribeResponse(javaResponse);
    %
    % Properties
    %   statusCode - (double) HTTP status code reported by the SDK.
    %
    % Example
    %   resp = sns.unsubscribe(subscriptionArn=arn);
    %   disp(resp.statusCode);

    % Copyright 2025 The MathWorks, Inc.

    properties
        % Add properties here if the Unsubscribe operation returns any specific information
        statusCode double
    end

    methods
        function obj = UnsubscribeResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sns.model.UnsubscribeResponse')
                obj.Handle = varargin{1};
                % Capture any relevant information from the response if needed
                obj.statusCode = varargin{1}.sdkHttpResponse().statusCode();
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
