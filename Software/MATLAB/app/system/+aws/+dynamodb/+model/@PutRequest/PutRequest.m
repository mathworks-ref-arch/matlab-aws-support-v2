classdef PutRequest < aws.Object
    % PUTREQUEST Builder for DynamoDB put request payloads.
    %
    % Syntax
    %   req = aws.dynamodb.model.PutRequest(item=itemDictionary);
    %
    % Name-Value Arguments
    %   item - (dictionary, required) Map of attribute name -> aws.dynamodb.model.AttributeValue instances.
    %
    % Example
    %   item = dictionary("pk", aws.dynamodb.model.AttributeValue(s="order#1"));
    %   req = aws.dynamodb.model.PutRequest(item=item);

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = PutRequest(options)
            arguments
                options.item dictionary
            end

            builder = software.amazon.awssdk.services.dynamodb.model.PutRequest.builder();
            obj.Handle = aws.internal.builder.build(builder,options);
        end

    end
end
