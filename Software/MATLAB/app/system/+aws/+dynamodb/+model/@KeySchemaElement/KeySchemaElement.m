classdef KeySchemaElement < aws.Object
    % KEYSCHEMAELEMENT Builder for DynamoDB key schema elements.
    %
    % Syntax
    %   keyElem = aws.dynamodb.model.KeySchemaElement(attributeName="pk", keyType="HASH");
    %
    % Name-Value Arguments
    %   attributeName - (string, required) Attribute name used in the key.
    %   keyType       - (string) Key role: "HASH" for partition key or "RANGE" for sort key.
    %
    % Example
    %   hashKey = aws.dynamodb.model.KeySchemaElement(attributeName="pk", keyType="HASH");

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = KeySchemaElement(options)
            % Constructor for KeySchemaElement
            % Usage:
            %   keyElem = KeySchemaElement(attributeName="UserId", keyTypeAsString="HASH");
            arguments
                options.attributeName (1,1) string
                options.keyType (1,1) string {mustBeMember(options.keyType, ["HASH", "RANGE", "UNKNOWN_TO_SDK_VERSION"])} = "HASH"
            end

            builderClass = software.amazon.awssdk.services.dynamodb.model.KeySchemaElement.builder();

            % Build the Java object
            obj.Handle = aws.internal.builder.build(builderClass,options);
        end
    end
end
