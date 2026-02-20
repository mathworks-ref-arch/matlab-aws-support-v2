function deleteTopicResponse = deleteTopic(obj, options)
% DELETETOPIC Delete an SNS topic.
%
% Syntax
%   resp = sns.deleteTopic(topicArn="arn:aws:sns:...");
%
% Name-Value Arguments
%   topicArn - (string, required) ARN of the topic to delete.
%
% Returns
%   deleteTopicResponse - aws.sns.model.DeleteTopicResponse containing HTTP metadata.
%
% Example
%   resp = sns.deleteTopic(topicArn="arn:aws:sns:us-east-1:111122223333:demoTopic");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.topicArn (1,1) string {mustBeTextScalar, mustBeNonempty}
end

write(obj.logObj, 'info', 'Deleting Topic in Simple Notification Service');

deleteTopicRequestBuilder = software.amazon.awssdk.services.sns.model.DeleteTopicRequest.builder();
deleteTopicRequest = aws.internal.builder.build(deleteTopicRequestBuilder,options);
responseJ = obj.Handle.deleteTopic(deleteTopicRequest);
deleteTopicResponse = aws.sns.model.DeleteTopicResponse(responseJ);
write(obj.logObj, 'info', 'Deleted Topic in Simple Notification Service');

end
