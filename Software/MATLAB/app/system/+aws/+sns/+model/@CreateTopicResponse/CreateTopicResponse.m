classdef CreateTopicResponse < aws.Object
    % CREATETOPICRESPONSE MATLAB wrapper for CreateTopic results.
    %
    % Syntax
    %   resp = aws.sns.model.CreateTopicResponse(javaResponse);
    %
    % Properties
    %   topicArn - (string) ARN of the created (or retrieved) topic.
    %
    % Example
    %   resp = sns.createTopic(name="demoTopic");
    %   disp(resp.topicArn);

    % Copyright 2025 The MathWorks, Inc.

    properties
        topicArn string
    end

    methods
        function obj = CreateTopicResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sns.model.CreateTopicResponse')
                obj.Handle = varargin{1};
                obj.topicArn = string(varargin{1}.topicArn());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
