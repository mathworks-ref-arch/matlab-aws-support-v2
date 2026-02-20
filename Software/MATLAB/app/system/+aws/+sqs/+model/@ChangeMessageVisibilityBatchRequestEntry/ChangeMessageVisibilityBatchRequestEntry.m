classdef ChangeMessageVisibilityBatchRequestEntry < aws.Object
    % CHANGEMESSAGEVISIBILITYBATCHREQUESTENTRY Builder for SQS batch request entry.
    %
    % Creates a single entry for use with the SQS
    % ChangeMessageVisibilityBatch API.
    %
    % Syntax
    %   e = aws.sqs.model.ChangeMessageVisibilityBatchRequestEntry( ...
    %       id="m1", receiptHandle=handle, visibilityTimeout=int32(90));
    %
    % Name-Value Arguments
    %   id                - (string, required) Caller-supplied identifier (unique within the batch).
    %   receiptHandle     - (string, required) Receipt handle from receiveMessage.
    %   visibilityTimeout - (int32, required) New visibility timeout in seconds [0..43200].
    %
    % Example
    %   e1 = aws.sqs.model.ChangeMessageVisibilityBatchRequestEntry( ...
    %           id="msg1", receiptHandle=handle1, visibilityTimeout=60);
    %   e2 = aws.sqs.model.ChangeMessageVisibilityBatchRequestEntry( ...
    %           id="msg2", receiptHandle=handle2, visibilityTimeout=120);
    %
    %   % If your client supports passing Java list directly:
    %   jList = aws.sqs.model.ChangeMessageVisibilityBatchRequestEntry.toJavaList([e1,e2]);
    %   % (Or pass a struct array to your existing helper.)
    %
    % Notes
    % - AWS SQS limits batch size to 10 entries.

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = ChangeMessageVisibilityBatchRequestEntry(options)
            arguments
                options.id (1,1) string {mustBeNonempty}
                options.receiptHandle (1,1) string {mustBeNonempty}
                options.visibilityTimeout (1,1) int32 {mustBeGreaterThanOrEqual(options.visibilityTimeout, 0), mustBeLessThanOrEqual(options.visibilityTimeout, 43200)}
            end

            initializeLogger(obj, 'Amazon:SQS:ChangeMessageVisibilityBatchRequestEntry');

            % Build the AWS SDK v2 request entry
            jBuilder = software.amazon.awssdk.services.sqs.model. ...
                ChangeMessageVisibilityBatchRequestEntry.builder();
            jBuilder = jBuilder.id(char(options.id));
            jBuilder = jBuilder.receiptHandle(char(options.receiptHandle));
            jBuilder = jBuilder.visibilityTimeout(java.lang.Integer.valueOf(options.visibilityTimeout));

            obj.Handle = jBuilder.build();
        end
    end

    methods (Static)
        function jList = toJavaList(entries)
            % TOJAVALIST Convert entries to a java.util.List of SDK entries.
            %
            % Accepts either:
            %   - array of aws.sqs.model.ChangeMessageVisibilityBatchRequestEntry, or
            %   - struct array with fields: id, receiptHandle, visibilityTimeout
            %
            % Returns:
            %   java.util.List<software.amazon.awssdk.services.sqs.model.ChangeMessageVisibilityBatchRequestEntry>

            jList = java.util.ArrayList();

            if isempty(entries)
                return;
            end

            if isa(entries, 'aws.sqs.model.ChangeMessageVisibilityBatchRequestEntry')
                % Already wrapped objects
                for k = 1:numel(entries)
                    jList.add(entries(k).Handle);
                end
            elseif isstruct(entries)
                % Build from struct array (each element must have scalar fields)
                for k = 1:numel(entries)
                    e = entries(k);

                    % Basic shape checks to fail fast with a clear message
                    if ~all(isfield(e, ["id","receiptHandle","visibilityTimeout"]))
                        error('aws:sqs:InvalidEntryStruct', ...
                            'Each struct must have fields: id, receiptHandle, visibilityTimeout.');
                    end

                    jBuilder = software.amazon.awssdk.services.sqs.model. ...
                        ChangeMessageVisibilityBatchRequestEntry.builder();
                    jBuilder = jBuilder.id(char(string(e.id)));
                    jBuilder = jBuilder.receiptHandle(char(string(e.receiptHandle)));
                    jBuilder = jBuilder.visibilityTimeout( ...
                        java.lang.Integer.valueOf(int32(e.visibilityTimeout)));

                    jList.add(jBuilder.build());
                end
            else
                error('aws:sqs:InvalidEntriesType', ...
                    'entries must be an array of this class or a struct array with the required fields.');
            end
        end
    end
end