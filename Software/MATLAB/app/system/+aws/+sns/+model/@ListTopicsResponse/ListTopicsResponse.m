classdef ListTopicsResponse < aws.Object
    % LISTTOPICSRESPONSE MATLAB wrapper for SNS topic listings.
    %
    % Syntax
    %   resp = aws.sns.model.ListTopicsResponse(javaResponse);
    %
    % Properties
    %   topics   - (string array) Topic ARNs returned in this page.
    %   nextToken - (string) Continuation token (empty when listing is complete).
    %
    % Example
    %   resp = sns.listTopics();
    %   disp(resp.topics);

    % Copyright 2025 The MathWorks, Inc.

    properties
        topics string
        nextToken string
    end

    methods
        function obj = ListTopicsResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sns.model.ListTopicsResponse')
                obj.Handle = varargin{1};
                javaTopicsList = varargin{1}.topics();
                if isempty(javaTopicsList)
                    obj.topics = strings(1,0);
                else
                    numTopics = javaTopicsList.size();
                    tmp = strings(1, numTopics);
                    for idx = 1:numTopics
                        topicArn = javaTopicsList.get(idx - 1).topicArn();
                        tmp(idx) = string(topicArn);
                    end
                    obj.topics = tmp;
                end
                obj.nextToken = string(varargin{1}.nextToken());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
