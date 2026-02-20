classdef AttributeDefinition < aws.Object
    % ATTRIBUTEDEFINITION builder for DynamoDB attribute definitions.
    %
    % Syntax
    %   attrDef = aws.dynamodb.model.AttributeDefinition( ...
    %       attributeName="Id", attributeType="S");
    %
    % Name-Value Arguments
    %   attributeName - (string, required) Attribute name as defined in the table schema.
    %   attributeType - (string, required) Scalar type: "S", "N", or "B".
    %
    % Example
    %   attrDef = aws.dynamodb.model.AttributeDefinition(attributeName="pk", attributeType="S");

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = AttributeDefinition(options)
            % Constructor for AttributeDefinition
            %
            % Usage:
            %   attrDef = AttributeDefinition(attributeName="Id", attributeType="S");
            arguments
                options.attributeName (1,1) string
                options.attributeType (1,1) string    % Should be 'S', 'N', or 'B'
            end

            builderClass = software.amazon.awssdk.services.dynamodb.model.AttributeDefinition.builder();

            % Convert MATLAB strings to Java Strings
            options.attributeName = java.lang.String(options.attributeName);
            % For attributeType, convert to Java enum
            javaAttrType = software.amazon.awssdk.services.dynamodb.model.ScalarAttributeType.valueOf(options.attributeType);

            % Prepare options for builder
            builderOpts = struct();
            builderOpts.attributeName = options.attributeName;
            builderOpts.attributeType = javaAttrType;

            obj.Handle = aws.internal.builder.build(builderClass, builderOpts);
        end
    end
end
