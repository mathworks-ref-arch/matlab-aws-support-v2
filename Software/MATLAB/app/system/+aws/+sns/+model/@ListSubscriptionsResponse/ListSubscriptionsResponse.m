classdef ListSubscriptionsResponse < aws.Object
    % LISTSUBSCRIPTIONSRESPONSE MATLAB wrapper for SNS subscription listings.
    %
    % Syntax
    %   resp = aws.sns.model.ListSubscriptionsResponse(javaResponse);
    %
    % Properties
    %   subscriptions - (struct array) SubscriptionArn/TopicArn/Protocol/Endpoint/Owner.
    %   nextToken     - (string) Continuation token when more results remain.
    %   numOfSubscriptions - (double) number of subscriptions
    %
    % Example
    %   resp = sns.listSubscriptions();
    %   disp(resp.subscriptions(1).subscriptionArn);

    % Copyright 2025 The MathWorks, Inc.

    properties
        subscriptions struct % TO DO create a model class instead of struct
        nextToken string
        numOfSubscriptions int32
    end

    methods
        function obj = ListSubscriptionsResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sns.model.ListSubscriptionsResponse')
                obj.Handle = varargin{1};
                javaSubscriptionsList = varargin{1}.subscriptions();
                obj.numOfSubscriptions = javaSubscriptionsList.size();
                obj.subscriptions = obj.buildSubscriptionStruct(javaSubscriptionsList);
                obj.nextToken = string(varargin{1}.nextToken());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end

    methods (Access = private)
        function subs = buildSubscriptionStruct(~, javaList)
            if isempty(javaList) || javaList.isEmpty()
                subs = struct('subscriptionArn', string.empty, ...
                    'topicArn', string.empty, ...
                    'protocol', string.empty, ...
                    'endpoint', string.empty, ...
                    'owner', string.empty);
                subs(1) = [];
                return
            end

            n = javaList.size();
            subs(1:n) = struct('subscriptionArn', "", ...
                               'topicArn', "", ...
                               'protocol', "", ...
                               'endpoint', "", ...
                               'owner', "");
            for idx = 1:n
                jSub = javaList.get(idx-1);
                subs(idx).subscriptionArn = localString(jSub.subscriptionArn());
                subs(idx).topicArn = localString(jSub.topicArn());
                subs(idx).protocol = localString(jSub.protocol());
                subs(idx).endpoint = localString(jSub.endpoint());
                subs(idx).owner = localString(jSub.owner());
            end
        end
    end
end

function str = localString(val)
if isempty(val)
    str = "";
else
    str = string(val);
end
end
