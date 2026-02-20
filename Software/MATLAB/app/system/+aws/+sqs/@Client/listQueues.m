function listQueuesResponse = listQueues(obj, options)
% LISTQUEUES Enumerate SQS queues with optional prefix filtering.
%
% Syntax
%   resp = sqs.listQueues();
%   resp = sqs.listQueues(queueNamePrefix="demo", maxResults=10, nextToken=token);
%
% Name-Value Arguments
%   queueNamePrefix - (string) Only return queues starting with this prefix.
%   maxResults      - (double) Maximum URLs per page (1â€“1000).
%   nextToken       - (string) Pagination token from a previous response.
%
% Returns
%   listQueuesResponse - aws.sqs.model.ListQueuesResponse containing queue URLs and the next token.
%
% Example
%   resp = sqs.listQueues(queueNamePrefix="demo");
%   disp(resp.queueUrls);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.queueNamePrefix (1,1) string {mustBeTextScalar}
    options.maxResults (1,1) double {mustBePositive, mustBeInteger}
    options.nextToken (1,1) string {mustBeTextScalar}
end

write(obj.logObj, 'info', 'Listing queues from Simple Queue Service');

% Create the request builder for listing queues
listQueuesRequestBuilder = software.amazon.awssdk.services.sqs.model.ListQueuesRequest.builder();

listQueuesRequest = aws.internal.builder.build(listQueuesRequestBuilder, options);

% Call the listQueues method
responseJ = obj.Handle.listQueues(listQueuesRequest);

% Wrap the Java response in a MATLAB ListQueuesResponse object
listQueuesResponse = aws.sqs.model.ListQueuesResponse(responseJ);

end
