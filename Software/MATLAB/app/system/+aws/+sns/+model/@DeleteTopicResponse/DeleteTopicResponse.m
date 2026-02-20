classdef DeleteTopicResponse < aws.Object
    % DELETETOPICRESPONSE Metadata returned by DeleteTopic.
    %
    % Syntax
    %   resp = aws.sns.model.DeleteTopicResponse(javaResponse);
    %
    % Properties
    %   statusCode - (int32) HTTP status reported by the SDK.
    %
    % Example
    %   resp = sns.deleteTopic(topicArn=arn);
    %   disp(resp.statusCode);

    % Copyright 2025 The MathWorks, Inc.

    properties
        % Add properties here if the DeleteTopic operation returns any specific information
        statusCode
    end

    methods
        function obj = DeleteTopicResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sns.model.DeleteTopicResponse')
                obj.Handle = varargin{1};
                % Capture any relevant information from the response if needed
                httpResponse = varargin{1}.sdkHttpResponse();
                obj.statusCode = httpResponse.statusCode();

            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
