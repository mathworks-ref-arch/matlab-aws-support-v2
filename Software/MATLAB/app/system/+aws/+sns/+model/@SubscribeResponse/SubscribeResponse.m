classdef SubscribeResponse < aws.Object
    % SUBSCRIBERESPONSE MATLAB wrapper for Subscribe results.
    %
    % Syntax
    %   resp = aws.sns.model.SubscribeResponse(javaResponse);
    %
    % Properties
    %   subscriptionArn - (string) ARN returned by SNS (or "pending confirmation").
    %
    % Example
    %   resp = sns.subscribe(topicArn=arn, protocol="lambda", endpoint=lambdaArn);
    %   disp(resp.subscriptionArn);

    % Copyright 2025 The MathWorks, Inc.

    properties
        subscriptionArn string
    end

    methods
        function obj = SubscribeResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sns.model.SubscribeResponse')
                obj.Handle = varargin{1};
                obj.subscriptionArn = string(varargin{1}.subscriptionArn());
            else
                logObj = Logger.getLogger();
                write(logObj, 'error', 'Invalid arguments');
            end
        end
    end

end
