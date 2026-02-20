classdef ConfirmSubscriptionResponse < aws.Object
    % CONFIRMSUBSCRIPTIONRESPONSE MATLAB wrapper for ConfirmSubscription results.
    %
    % Syntax
    %   resp = aws.sns.model.ConfirmSubscriptionResponse(javaResponse);
    %
    % Properties
    %   subscriptionArn - (string) ARN assigned to the confirmed subscription.
    %
    % Example
    %   resp = sns.confirmSubscription(topicArn=arn, token=token);
    %   disp(resp.subscriptionArn);

    % Copyright 2025 The MathWorks, Inc.

    properties
        subscriptionArn string
    end

    methods
        function obj = ConfirmSubscriptionResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sns.model.ConfirmSubscriptionResponse')
                obj.Handle = varargin{1};
                obj.subscriptionArn = string(varargin{1}.subscriptionArn());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
