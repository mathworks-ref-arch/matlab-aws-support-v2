classdef MessageAttributeValue < aws.Object
    % MESSAGEATTRIBUTEVALUE Builder for SNS message attributes.
    %
    % Syntax
    %   attr = aws.sns.model.MessageAttributeValue( ...
    %       dataType="String", stringValue="high");
    %
    % Name-Value Arguments
    %   dataType    - (string) SNS data type (`"String"`, `"Number"`, `"Binary"`, etc.).
    %   stringValue - (string) Value provided as text.
    %   binaryValue - (aws.core.model.SdkBytes) Binary representation when `dataType` is `"Binary"`.
    %
    % Example
    %   attr = aws.sns.model.MessageAttributeValue(dataType="String", stringValue="critical");

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = MessageAttributeValue(options)
            arguments
                options.dataType (1,1) string
                options.stringValue (1,1) string
                options.binaryValue (1,1) aws.core.model.SdkBytes  % accepts java SdkBytes wrapper too
            end

            initializeLogger(obj, 'Amazon:SNS:MessageAttributeValue');

            % Build
            messageAttrBuilder = software.amazon.awssdk.services.sns.model.MessageAttributeValue.builder();
            obj.Handle = aws.internal.builder.build(messageAttrBuilder, options);
        end
    end

end
