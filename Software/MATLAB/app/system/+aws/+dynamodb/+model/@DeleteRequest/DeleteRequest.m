classdef DeleteRequest < aws.Object
    % DELETEREQUEST Builder for DynamoDB delete request payloads.
    %
    % Syntax
    %   req = aws.dynamodb.model.DeleteRequest(key=keyDictionary);
    %
    % Name-Value Arguments
    %   key - (dictionary, required) Map of attribute name -> aws.dynamodb.model.AttributeValue representing the primary key.
    %
    % Example
    %   key = dictionary("pk", aws.dynamodb.model.AttributeValue(s="order#1"));
    %   req = aws.dynamodb.model.DeleteRequest(key=key);

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = DeleteRequest(options)
            % Constructor for DeleteRequest
            %
            % Usage:
            %   delReq = DeleteRequest(key=dictionary(...));
            arguments
                % dictionary should be of type string, aws.dynamodb.model.AttributeValue
                options.key dictionary 
            end

                builder = software.amazon.awssdk.services.dynamodb.model.DeleteRequest.builder();
                obj.Handle = aws.internal.builder.build(builder, options);
        end
    end
end
