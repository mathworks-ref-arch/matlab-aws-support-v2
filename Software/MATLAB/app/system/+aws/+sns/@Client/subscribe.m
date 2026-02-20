function subscribeResponse = subscribe(obj, options)
% SUBSCRIBE Register an endpoint with an SNS topic.
%
% Syntax
%   resp = sns.subscribe(topicArn="arn:aws:sns:...", protocol="email", endpoint="user@example.com");
%
% Name-Value Arguments
%   topicArn - (string, required) Topic ARN to subscribe to.
%   protocol - (string, required) Delivery protocol (e.g., `"email"`, `"lambda"`, `"sqs"`).
%   endpoint - (string, required) Endpoint that receives notifications (email, ARN, URL, etc.).
%
% Returns
%   subscribeResponse - aws.sns.model.SubscribeResponse containing the subscription ARN (or "pending confirmation").
%
% Example
%   resp = sns.subscribe(topicArn=myTopicArn, protocol="lambda", endpoint=lambdaArn);

% Copyright 2025 The MathWorks, Inc.
arguments
    obj
    options.topicArn (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.protocol (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.endpoint (1,1) string {mustBeTextScalar, mustBeNonempty}
end

% Create a SubscribeRequest
subscribeRequestBuilder=software.amazon.awssdk.services.sns.model.SubscribeRequest.builder();
subscribeRequest = aws.internal.builder.build(subscribeRequestBuilder,options);

% Call the subscribe method of the SNS client
subscribeResponseJ = obj.Handle.subscribe(subscribeRequest);
subscribeResponse = aws.sns.model.SubscribeResponse(subscribeResponseJ);

end
