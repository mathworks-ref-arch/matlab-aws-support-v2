classdef ListQueuesResponse < aws.Object
    % LISTQUEUESRESPONSE MATLAB wrapper for ListQueues results.
    %
    % Syntax
    %   resp = aws.sqs.model.ListQueuesResponse(javaResponse);
    %
    % Properties
    %   queueUrls - (string array) Queue URLs returned in this page.
    %   nextToken - (string) Continuation token for additional pages.

    % Copyright 2025 The MathWorks, Inc.

    properties
        queueUrls string
        nextToken string
    end

    methods
        function obj = ListQueuesResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sqs.model.ListQueuesResponse')
                obj.Handle = varargin{1};

                queueUrlsJ = varargin{1}.queueUrls();
                if isempty(queueUrlsJ)
                    obj.queueUrls = strings(1,0);
                else
                    numUrls = queueUrlsJ.size();
                    tmp = strings(1,numUrls);
                    for idx = 1:numUrls
                        tmp(idx) = string(queueUrlsJ.get(idx-1));
                    end
                    obj.queueUrls = tmp;
                end
                obj.nextToken = string(varargin{1}.nextToken());
            else
                write(obj.logObj, 'error', 'Invalid arguments for ListQueuesResponse');
                error('AWS:SQS:InvalidArguments', 'Invalid arguments for ListQueuesResponse');
            end
        end
    end
end
