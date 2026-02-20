function listTopicsResponse = listTopics(obj, options)
% LISTTOPICS List SNS topics with optional pagination.
%
% Syntax
%   resp = sns.listTopics();
%   resp = sns.listTopics(nextToken=token);
%
% Name-Value Arguments
%   nextToken - (string) Opaque token from a previous `listTopics` call to continue pagination.
%
% Returns
%   listTopicsResponse - aws.sns.model.ListTopicsResponse containing topic ARNs and the next token.
%
% Example
%   resp = sns.listTopics();
%   while ~isempty(resp.nextToken)
%       resp = sns.listTopics(nextToken=resp.nextToken);
%   end
%
% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.nextToken (1,1) string {mustBeTextScalar}
end

write(obj.logObj, 'info', 'Listing Topics in Simple Notification Service');

listTopicsRequestBuilder = software.amazon.awssdk.services.sns.model.ListTopicsRequest.builder();
listTopicsRequest = aws.internal.builder.build(listTopicsRequestBuilder, options);
responseJ = obj.Handle.listTopics(listTopicsRequest);
listTopicsResponse = aws.sns.model.ListTopicsResponse(responseJ);
write(obj.logObj, 'info', 'Listed Topics in Simple Notification Service');

end
