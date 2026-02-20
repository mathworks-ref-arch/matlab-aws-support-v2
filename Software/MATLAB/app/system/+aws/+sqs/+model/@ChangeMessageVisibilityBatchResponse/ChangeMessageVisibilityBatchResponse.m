classdef ChangeMessageVisibilityBatchResponse < aws.Object
    % CHANGEMESSAGEVISIBILITYBATCHRESPONSE Result of ChangeMessageVisibilityBatch.
    %
    % Syntax
    %   resp = aws.sqs.model.ChangeMessageVisibilityBatchResponse(javaResponse);
    %
    % Properties
    %   successful - (array) aws.sqs.model.ChangeMessageVisibilityBatchResultEntry objects.
    %   failed     - (array) aws.sqs.model.BatchResultErrorEntry objects.

    % Copyright 2025 The MathWorks, Inc.

    properties
        successful aws.sqs.model.ChangeMessageVisibilityBatchResultEntry
        failed aws.sqs.model.BatchResultErrorEntry
    end

    methods
        function obj = ChangeMessageVisibilityBatchResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sqs.model.ChangeMessageVisibilityBatchResponse')
                obj.Handle = varargin{1};
                successfulJ = varargin{1}.successful();
                if isempty(successfulJ) || successfulJ.size() == 0
                    sentries = aws.sqs.model.ChangeMessageVisibilityBatchResultEntry.empty(1,0);
                else
                    for idx = 1:successfulJ.size()
                        sentries(1, idx) = aws.sqs.model.ChangeMessageVisibilityBatchResultEntry( ...
                            successfulJ.get(idx-1));
                    end
                end
                obj.successful = sentries;

                failedJ = varargin{1}.failed();
                if isempty(failedJ) || failedJ.size() == 0
                    fentries = aws.sqs.model.BatchResultErrorEntry.empty(1,0);
                else
                    for idx = 1:failedJ.size()
                        fentries(1, idx) = aws.sqs.model.BatchResultErrorEntry(failedJ.get(idx-1));
                    end
                end
                obj.failed = fentries;
            else
                write(obj.logObj, 'error', ...
                    'Invalid arguments for ChangeMessageVisibilityBatchResponse');
            end
        end
    end
end
