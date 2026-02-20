classdef TestDynamoDBModel < matlab.unittest.TestCase
    % Test Class for AWS DynamoDB service

    % Copyright 2025 The MathWorks, Inc.

    properties
        % DynamoDB client

    end

    methods(Test, TestTags={'Unit'})
        function testKeySchema(testCase)
            keyElement1=aws.dynamodb.model.KeySchemaElement(attributeName="keyHash",keyType="HASH");
            keyElement2=aws.dynamodb.model.KeySchemaElement(attributeName="keyRange",keyType="RANGE");
            options.keySchema = {keyElement1,keyElement2};
            createTableBuilder = software.amazon.awssdk.services.dynamodb.model.CreateTableRequest.builder();
            createTableRquest = aws.internal.builder.build(createTableBuilder,options);
            testCase.verifyNotEmpty(createTableRquest);
        end

        function testAttributeValue(~)
            av1 = aws.dynamodb.model.AttributeValue(s="name");
            disp(av1.Handle);
            av2 = aws.dynamodb.model.AttributeValue(attributeValue=av1.Handle);
            disp(av2.getValue());
        end

    end
end
function javaValue = jcast(value)
matlabType = class(value);
switch matlabType
    case {'string', 'char'}
        javaValue = javaObject("java.lang.String",value);
    case {'double'}
        javaValue = javaObject("java.lang.Double",value);
    case {'logical'}
        javaValue = javaObject("java.lang.Boolean",vaue);
    case {'single'}
        javaValue = javaObject("java.lang.Float",value);
    case {'int8','uint8'}
        javaValue = javaObject("java.lang.Byte", value);
    case {'int16','uint16'}
        javaValue = javaObject("java.lang.Short",value);
    case {'int32','uint32'}
        javaValue = javaObject("java.lang.Integer",value);
    case {'int64','uint64'}
        javaValue = javaObject("java.lang.Long",value);
    case {"cell"}
        javaValue = cellCast(value);

    otherwise
        javaValue = value;


end
end

function javaValue = cellCast(value)
numCells= numel(value);
firstValue = jcast(value{1});
arrayClass = class(firstValue);
jArray = javaArray(arrayClass,numCells);
for index = 1:numCells
    javaValue = jcast(value{index});
    jArray(index)=javaValue;

end
javaValue = jArray;

end


