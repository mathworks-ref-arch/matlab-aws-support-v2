classdef CreateQueueResponse < aws.Object
    % CREATEQUEUERESPONSE MATLAB wrapper for CreateQueue results.
    %
    % Syntax
    %   resp = aws.sqs.model.CreateQueueResponse(javaResponse);
    %
    % Properties
    %   queueUrl - (string) URL of the created queue.
    %
    % Example
    %   resp = sqs.createQueue(queueName="demoQueue");
    %   disp(resp.queueUrl);

    % Copyright 2025 The MathWorks, Inc.

    properties
        queueUrl string
    end

    methods
        function obj = CreateQueueResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sqs.model.CreateQueueResponse')
                obj.Handle = varargin{1};
                obj.queueUrl = string(varargin{1}.queueUrl());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
