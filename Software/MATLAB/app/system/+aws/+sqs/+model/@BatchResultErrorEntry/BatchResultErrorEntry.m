classdef BatchResultErrorEntry < aws.Object
    % BATCHRESULTERRORENTRY Error metadata for batch queue operations.
    %
    % Syntax
    %   entry = aws.sqs.model.BatchResultErrorEntry(javaEntry);
    %
    % Properties
    %   id          - (string) Identifier from the batch request.
    %   code        - (string) Error code returned by SQS.
    %   message     - (string) Human-readable description of the error.
    %   senderFault - (logical) True when the error is caused by the caller.

    % Copyright 2025 The MathWorks, Inc.

    properties
        id string
        code string
        message string
        senderFault logical
    end

    methods
        function obj = BatchResultErrorEntry(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sqs.model.BatchResultErrorEntry')
                obj.Handle = varargin{1};
                obj.id = string(varargin{1}.id());
                obj.code = string(varargin{1}.code());
                obj.message = string(varargin{1}.message());
                obj.senderFault = logical(varargin{1}.senderFault().booleanValue());
            else
                write(obj.logObj, 'error', ...
                    'Invalid arguments for BatchResultErrorEntry');
            end
        end
    end
end
