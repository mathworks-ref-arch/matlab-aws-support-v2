classdef PublishResponse < aws.Object
    % PUBLISHRESPONSE MATLAB wrapper for SNS Publish results.
    %
    % Syntax
    %   resp = aws.sns.model.PublishResponse(javaResponse);
    %
    % Properties
    %   messageId - (string) Identifier assigned by SNS to the published message.
    %
    % Example
    %   resp = sns.publish(topicArn=arn, message="Hello");
    %   disp(resp.messageId);

    % Copyright 2025 The MathWorks, Inc.

    properties
        messageId string
    end

    methods
        function obj = PublishResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sns.model.PublishResponse')
                obj.Handle = varargin{1};
                obj.messageId = string(varargin{1}.messageId());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
