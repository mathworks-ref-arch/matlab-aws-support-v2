function listSubscriptionsResponse = listSubscriptions(obj, options)
% LISTSUBSCRIPTIONS Enumerate SNS subscriptions with optional pagination.
%
% Syntax
%   resp = sns.listSubscriptions();
%   resp = sns.listSubscriptions(nextToken=token);
%
% Name-Value Arguments
%   nextToken - (string) Continuation token from a prior response.
%
% Returns
%   listSubscriptionsResponse - aws.sns.model.ListSubscriptionsResponse containing subscription metadata.
%
% Example
%   resp = sns.listSubscriptions();
%   disp(resp.subscriptions);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.nextToken (1,1) string {mustBeTextScalar}
end

% Create a ListSubscriptionsRequest
listSubscriptionsRequestBuilder = software.amazon.awssdk.services.sns.model.ListSubscriptionsRequest.builder();
listSubscriptionsRequest = aws.internal.builder.build(listSubscriptionsRequestBuilder,options);

% Call the listSubscriptions method of the SNS client
listSubscriptionsResponseJ = obj.Handle.listSubscriptions(listSubscriptionsRequest);
listSubscriptionsResponse = aws.sns.model.ListSubscriptionsResponse(listSubscriptionsResponseJ);

end
