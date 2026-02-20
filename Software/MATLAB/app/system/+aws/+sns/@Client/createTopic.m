function createTopicResponse = createTopic(obj, options)
% CREATETOPIC Create or retrieve an SNS topic.
%
% Syntax
%   resp = sns.createTopic(name="demoTopic");
%   resp = sns.createTopic(name="demoTopic", attributesWithStrings=attrs, tags=tagsDict);
%
% Name-Value Arguments
%   name                 - (string, required) Topic name (1â€“256 characters).
%   attributesWithStrings - (dictionary) Topic attributes (e.g., `DisplayName` => value).
%   tags                 - (dictionary) Cost allocation tags (string -> string).
%
% Returns
%   createTopicResponse - aws.sns.model.CreateTopicResponse exposing the topic ARN.
%
% Example
%   sns = aws.sns.Client();
%   attrs = dictionary("DisplayName", "Notifications");
%   tags  = dictionary("project", "demo");
%   resp = sns.createTopic(name="demoTopic", attributesWithStrings=attrs, tags=tags);
%   disp(resp.topicArn);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.name (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.attributesWithStrings dictionary % Optional
    options.tags dictionary % Optional
end

write(obj.logObj, 'info', 'Creating Topic in Simple Notification Service');

% Create a topic request builder
createTopicRequestBuilder = software.amazon.awssdk.services.sns.model.CreateTopicRequest.builder();
createTopicRequest = aws.internal.builder.build(createTopicRequestBuilder,options);


% Call the createTopic method from the AWS SDK
responseJ = obj.Handle.createTopic(createTopicRequest);

% Wrap the Java response in a MATLAB CreateTopicResponse object
createTopicResponse = aws.sns.model.CreateTopicResponse(responseJ);
write(obj.logObj, 'info', 'Created Topic in Simple Notification Service');

end

