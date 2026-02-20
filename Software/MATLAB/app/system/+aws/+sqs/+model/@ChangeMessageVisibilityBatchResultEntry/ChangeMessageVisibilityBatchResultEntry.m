classdef ChangeMessageVisibilityBatchResultEntry < aws.Object
    % CHANGEMESSAGEVISIBILITYBATCHRESULTENTRY Successful batch entry metadata.
    %
    % Syntax
    %   entry = aws.sqs.model.ChangeMessageVisibilityBatchResultEntry(javaEntry);
    %
    % Properties
    %   id - (string) Identifier you supplied in the batch request.

    % Copyright 2025 The MathWorks, Inc.

    properties
        id string
    end

    methods
        function obj = ChangeMessageVisibilityBatchResultEntry(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sqs.model.ChangeMessageVisibilityBatchResultEntry')
                obj.Handle = varargin{1};
                obj.id = string(varargin{1}.id());
            else
                write(obj.logObj, 'error', ...
                    'Invalid arguments for ChangeMessageVisibilityBatchResultEntry');
            end
        end
    end
end
