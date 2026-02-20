function unsubscribeResponse = unsubscribe(obj, options)
% UNSUBSCRIBE Remove an endpoint from an SNS subscription.
%
% Syntax
%   resp = sns.unsubscribe(subscriptionArn=arn);
%
% Name-Value Arguments
%   subscriptionArn - (string, required) Subscription ARN to cancel.
%
% Returns
%   unsubscribeResponse - aws.sns.model.UnsubscribeResponse containing HTTP metadata.
%
% Example
%   sns.unsubscribe(subscriptionArn=arn);

% Copyright 2025 The MathWorks, Inc.
arguments
    obj
    options.subscriptionArn (1,1) string {mustBeTextScalar, mustBeNonempty}
end

write(obj.logObj, "verbose", "Unsubscribing from topic with SubscriptionArn: " + options.subscriptionArn);

unsubscribeRequestBuilder = software.amazon.awssdk.services.sns.model.UnsubscribeRequest.builder();
unsubscribeRequest = aws.internal.builder.build(unsubscribeRequestBuilder,options);
unsubscribeResponseJ = obj.Handle.unsubscribe(unsubscribeRequest);
unsubscribeResponse = aws.sns.model.UnsubscribeResponse(unsubscribeResponseJ);
end
