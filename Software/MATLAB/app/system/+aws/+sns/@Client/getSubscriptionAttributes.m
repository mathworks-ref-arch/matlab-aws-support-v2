function getSubscriptionAttributesResponse = getSubscriptionAttributes(obj, options)
% GETSUBSCRIPTIONATTRIBUTES Retrieve subscription metadata.
%
% Syntax
%   resp = sns.getSubscriptionAttributes(subscriptionArn=arn);
%
% Name-Value Arguments
%   subscriptionArn - (string, required) Subscription ARN to inspect.
%
% Returns
%   getSubscriptionAttributesResponse - aws.sns.model.GetSubscriptionAttributesResponse containing attribute map.
%
% Example
%   resp = sns.getSubscriptionAttributes(subscriptionArn=arn);
%   disp(resp.attributes);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.subscriptionArn (1,1) string {mustBeNonempty}
end

% Create a GetSubscriptionAttributesRequest
getSubscriptionAttributesRequestBuilder = software.amazon.awssdk.services.sns.model.GetSubscriptionAttributesRequest.builder();


% Build the request
getSubscriptionAttributesRequest = aws.internal.builder.build(getSubscriptionAttributesRequestBuilder, options);

% Call the getSubscriptionAttributes method of the SNS client
getSubscriptionAttributesResponseJ = obj.Handle.getSubscriptionAttributes(getSubscriptionAttributesRequest);
getSubscriptionAttributesResponse = aws.sns.model.GetSubscriptionAttributesResponse(getSubscriptionAttributesResponseJ);

end
