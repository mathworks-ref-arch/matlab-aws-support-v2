classdef AttributeValue < aws.Object
    % ATTRIBUTEVALUE Builder/wrapper for DynamoDB AttributeValue objects.
    %
    % Syntax
    %   attr = aws.dynamodb.model.AttributeValue(s="user#1");
    %   attr = aws.dynamodb.model.AttributeValue(attributeValue=javaAttr);
    %
    % Name-Value Arguments
    %   s   - (string) String attribute.
    %   n   - (string) Numeric attribute stored as text.
    %   b   - (uint8 vector or aws.core.model.SdkBytes) Binary attribute.
    %   ss  - (string array) String set.
    %   ns  - (string array) Number set stored as text.
    %   bs  - (cell) Binary set.
    %   m   - (dictionary) Map of attribute names to AttributeValue objects.
    %   bool - (logical) Boolean attribute.
    %   nul - (logical) true to represent NULL.
    %   attributeValue - (software.amazon.awssdk.services.dynamodb.model.AttributeValue) Wrap an existing Java handle.
    %
    % Example
    %   attr = aws.dynamodb.model.AttributeValue(n="42");
    %   attrFromJava = aws.dynamodb.model.AttributeValue(attributeValue=javaAttr);

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = AttributeValue(options)
            arguments
                options.s string
                options.n string
                options.b
                options.ss string
                options.ns string
                options.bs
                options.m dictionary
                options.bool
                options.nul

                options.attributeValue
            end

            % Validate exclusivity:
            % - If attributeValue is provided and non-empty, it must be the only thing set.
            % - Otherwise, exactly one primary shape (s,n,b,ss,ns,bs,m,bool,null) must be set.
            isJava = isfield(options, "attributeValue") && ~isempty(options.attributeValue);
            attrTypes = [isfield(options, "s"), isfield(options, "n"), isfield(options, "b"), ...
                isfield(options, "ss"), isfield(options, "ns"), isfield(options, "bs"), ...
                isfield(options, "m"), isfield(options, "bool"), isfield(options, "nul")];
            nAttrTypes = nnz(attrTypes);

            if isJava
                if ~(isa(options.attributeValue, 'software.amazon.awssdk.services.dynamodb.model.AttributeValue'))
                    error('attributeValue must be a software.amazon.awssdk.services.dynamodb.model.AttributeValue.');
                end
                if nAttrTypes > 0
                    error('When attributeValue is provided, no other shape options (s,n,b,ss,ns,bs,m,bool,null) may be set.');
                end
                % Wrap existing Java object
                obj.Handle = options.attributeValue;
                return
            else
                if nAttrTypes ~= 1
                    error('Specify exactly one of: s, n, b, ss, ns, bs, m, bool, or null.');
                end
            end

            % Convert to builder format
            attributeValueBuilder = software.amazon.awssdk.services.dynamodb.model.AttributeValue.builder();
            obj.Handle = aws.internal.builder.build(attributeValueBuilder,options);

        end
    end
end
