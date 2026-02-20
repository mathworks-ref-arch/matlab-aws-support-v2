function publishResponse = publish(obj, options)
% PUBLISH Publish a message to an SNS topic.
%
% Syntax
%   resp = sns.publish(topicArn="arn:aws:sns:...", message="Hello world");
%   resp = sns.publish(topicArn="arn:aws:sns:...", message="Hello", ...
%       subject="Greeting", messageAttributes=attrs);
%
% Name-Value Arguments
%   topicArn          - (string, required) ARN of the topic or endpoint to publish to.
%   message           - (string, required) Message payload (SNS delivers as UTF-8 text).
%   subject           - (string) Optional subject line (max 100 chars).
%   messageAttributes - (dictionary) Map of attribute name -> `aws.sns.model.MessageAttributeValue`.
%
% Returns
%   publishResponse - aws.sns.model.PublishResponse containing the message ID.
%
% Example
%   sns = aws.sns.Client();
%   attrs = dictionary("priority", aws.sns.model.MessageAttributeValue( ...
%       dataType="String", stringValue="high"));
%   resp = sns.publish(topicArn="arn:aws:sns:us-east-1:111122223333:demo", ...
%       message="Hello from MATLAB", messageAttributes=attrs);
%   disp(resp.messageId);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.topicArn (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.message (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.subject (1,1) string {mustBeTextScalar}
    options.messageAttributes dictionary
end

write(obj.logObj, 'info', 'Publishing message to Simple Notification Service');

% Create a publish request builder
publishRequestBuilder = software.amazon.awssdk.services.sns.model.PublishRequest.builder();

% Build the request
publishRequest = aws.internal.builder.build(publishRequestBuilder,options);

% Call the publish method from the AWS SDK
responseJ = obj.Handle.publish(publishRequest);

% Wrap the Java response in a MATLAB PublishResponse object
publishResponse = aws.sns.model.PublishResponse(responseJ);
write(obj.logObj, 'info', 'Published message to Simple Notification Service');

end
