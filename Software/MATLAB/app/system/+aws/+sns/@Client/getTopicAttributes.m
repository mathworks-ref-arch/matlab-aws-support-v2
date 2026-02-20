function getTopicAttributesResponse = getTopicAttributes(obj, options)
% GETTOPICATTRIBUTES Retrieve topic metadata.
%
% Syntax
%   resp = sns.getTopicAttributes(topicArn=arn);
%
% Name-Value Arguments
%   topicArn - (string, required) Topic ARN to inspect.
%
% Returns
%   getTopicAttributesResponse - aws.sns.model.GetTopicAttributesResponse containing attribute map.
%
% Example
%   resp = sns.getTopicAttributes(topicArn=arn);
%   disp(resp.attributes);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.topicArn (1,1) string {mustBeNonempty}
end

% Create a GetTopicAttributesRequest
getTopicAttributesRequestBuilder = software.amazon.awssdk.services.sns.model.GetTopicAttributesRequest.builder();

% Build the request
getTopicAttributesRequest = aws.internal.builder.build(getTopicAttributesRequestBuilder, options);

% Call the getTopicAttributes method of the SNS client
getTopicAttributesResponseJ = obj.Handle.getTopicAttributes(getTopicAttributesRequest);
getTopicAttributesResponse = aws.sns.model.GetTopicAttributesResponse(getTopicAttributesResponseJ);

end
