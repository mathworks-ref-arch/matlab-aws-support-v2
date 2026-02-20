function confirmSubscriptionResponse = confirmSubscription(obj, options)
% CONFIRMSUBSCRIPTION Confirm an SNS subscription token.
%
% Syntax
%   resp = sns.confirmSubscription(topicArn=arn, token=token);
%   resp = sns.confirmSubscription(topicArn=arn, token=token, authenticateOnUnsubscribe="true");
%
% Name-Value Arguments
%   topicArn                 - (string, required) ARN of the topic being confirmed.
%   token                    - (string, required) Token from the Subscribe confirmation message.
%   authenticateOnUnsubscribe - (string) `"true"` requires authenticated unsubscribe requests (default empty).
%
% Returns
%   confirmSubscriptionResponse - aws.sns.model.ConfirmSubscriptionResponse containing the subscription ARN.
%
% Example
%   resp = sns.confirmSubscription(topicArn=arn, token=token);
%   disp(resp.subscriptionArn);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.topicArn (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.token (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.authenticateOnUnsubscribe (1,1) string {mustBeTextScalar}
end

confirmSubscriptionRequestBuilder = software.amazon.awssdk.services.sns.model.ConfirmSubscriptionRequest.builder();
confirmSubscriptionRequest = aws.internal.builder.build(confirmSubscriptionRequestBuilder, options);

% Call the confirmSubscription method of the SNS client
confirmSubscriptionResponseJ = obj.Handle.confirmSubscription(confirmSubscriptionRequest);
confirmSubscriptionResponse = aws.sns.model.ConfirmSubscriptionResponse(confirmSubscriptionResponseJ);

end
