classdef WriteRequest < aws.Object
    % WRITEREQUEST Wrapper for DynamoDB batch write entries.
    %
    % Syntax
    %   wr = aws.dynamodb.model.WriteRequest(putRequest=putReq);
    %   wr = aws.dynamodb.model.WriteRequest(deleteRequest=delReq);
    %
    % Name-Value Arguments
    %   putRequest    - (aws.dynamodb.model.PutRequest) One or more put requests.
    %   deleteRequest - (aws.dynamodb.model.DeleteRequest) One or more delete requests.
    % Exactly one of the above must be supplied.
    %
    % Example
    %   wr = aws.dynamodb.model.WriteRequest(putRequest=putReq);

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = WriteRequest(options)
            % Constructor for WriteRequest
            %
            % Usage:
            %   wr = WriteRequest(putRequest=PutRequestObj);
            %   wr = WriteRequest(deleteRequest=DeleteRequestObj);
            arguments
                %item is for one item
                options.putRequest aws.dynamodb.model.PutRequest
                options.deleteRequest aws.dynamodb.model.DeleteRequest

            end
            % Only putRequest or deleteRequest is allowed
            if isfield(options, "putRequest") && isfield(options, "deleteRequest")
                error("can only pass one option putRequest or deleteRequest");
            end

            builder = software.amazon.awssdk.services.dynamodb.model.WriteRequest.builder();

            if isfield(options, "putRequest")
                % isa(options.putRequest, "aws.dynamodb.model.PutRequest")
                for index=1:numel(options.putRequest)
                    writeOptions.putRequest= options.putRequest(index);
                    writeR = aws.internal.builder.build(builder,writeOptions);
                end
            end
            if isfield(options, "deleteRequest")
                % isa(options.deleteRequest,"aws.dynamodb.model.DeleteRequest")
                % options.putRequest should be a PutRequest MATLAB wrapper or Java object
                for index=1:numel(options.deleteRequest)
                    writeOptions.deleteRequest= options.deleteRequest(index);
                    writeR = aws.internal.builder.build(builder,writeOptions);
                end

            end
            obj.Handle = writeR;
        end
    end
end
