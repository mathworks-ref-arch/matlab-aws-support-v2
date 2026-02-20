function handle = build(builder, options)
% BUILD Populate an AWS SDK builder using MATLAB Name-Value arguments.
%
% Syntax
%   handle = aws.internal.builder.build(builder, optsStruct);
%
% Inputs
%   builder    - Java builder (e.g., software.amazon.awssdk.services.s3.model.GetObjectRequest$Builder).
%   options    - (struct) Scalar struct created by a MATLAB arguments block.
%
% Returns
%   handle     - Java object produced by invoking `builder.build()`.
%
% Description
%   Iterates over the fields of OPTIONS, calling the matching setter on the
%   Java builder while converting MATLAB values to their Java equivalents
%   (strings, numerics, logicals, dictionaries, aws.Object handles, etc.).

arguments
    builder
    options (1,1) struct
end

% Copyright 2025 The MathWorks, Inc.

fields = fieldnames(options);
for index = 1:numel(fields)
    fieldName = fields{index};

    fieldValue = options.(fieldName);
    if ~isStringScalar(fieldValue) && ~ischar(fieldValue)
        % fieldValue = convertNonStringJavaType(builder, fieldName, fieldValue);
        fieldValue = matlabToJava(fieldValue);
    end

    % Build
    try
        builder = builder.(fieldName)(fieldValue);
    catch ME
        error('aws:builder:UnknownField', ...
            'Builder %s does not support field "%s": %s', class(builder), fieldName, ME.message);
    end

end
handle = builder.build();

end

% Default convertion of MATLAB data types to Java data types
% Reference: https://www.mathworks.com/help/compiler_sdk/java/rules-for-data-conversion-between-java-and-matlab.html
% Array to ArrayList, complex type
function javaValue = matlabToJava(value)
% scalar is determined by isscalar
% complex type, cell to ArrayList, struct/dictionary to HashMap
% Convert scalar String
if isscalar(value) && ~iscell(value)
    if ischar(value) || isstring(value)
        javaValue = java.lang.String(value);
        % Convert scalar Numeric
    elseif isnumeric(value)
        javaValue = convertNumricJavaType(value);
        % Convert boolean
    elseif islogical(value)
        javaValue = java.lang.Boolean(value);
        % One value cell array,unbox element, e.g. {[1]}
        % elseif iscell(value)
        %     javaValue=matlabToJava(value{1});
        % convert struct to HashMap
    elseif  isstruct(value)
        javaValue = convertStructToJavaMap(value);
    elseif isa(value,"dictionary")
        javaValue = convertDictionaryToJavaMap(value);
    elseif isa(value,'aws.Object')
        javaValue = value.Handle;
    elseif isa(value, 'java.lang.Object')
        javaValue = value;
    else
        error('aws:builder:UnsupportedType', 'Not support MATLAB type %s', class(value));
    end

    % Convert cell and Array into ArrayList, cell with one element or the
    % method expect collection
else
    javaArrayList = java.util.ArrayList();
    sizeOfArrayList = numel(value);
    if iscell(value)
        for index=1:sizeOfArrayList
            javaArrayList.add(matlabToJava(value{index}));
        end
    else
        for index=1:sizeOfArrayList
            javaArrayList.add(matlabToJava(value(index)));
        end
    end

    javaValue = javaArrayList;
end


end
function javaValue = convertNumricJavaType(value)
matlabType = class(value);
switch matlabType
    case {'double'}
        javaValue = java.lang.Double(value);
    case {'single'}
        javaValue = java.lang.Float(value);
    case {'int8','uint8'}
        javaValue = java.lang.Byte(value);
    case {'int16','uint16'}
        javaValue = java.lang.Short(value);
    case {'int32','uint32'}
        %AWS doesn't always use complex data type,
        %https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/dynamodb/model/BackupNotFoundException.Builder.html
        %use int Instead of Integer
        javaValue = java.lang.Integer(value);
    case {'int64','uint64'}
        javaValue = java.lang.Long(value);
end
end

function javaMap = convertDictionaryToJavaMap(matlabDict)
% This function converts a MATLAB dictionary to a Java HashMap.

% Create a new Java HashMap
javaMap = java.util.HashMap();
isNotEmptyDict = (numEntries(matlabDict) > 0);


if isNotEmptyDict
    % Get keys and values from the MATLAB dictionary
    dkeys = keys(matlabDict);
    % dvalues = values(matlabDict);

    % Iterate over each key-value pair and add them to the Java HashMap
    for index = 1:numel(dkeys)
        % ToReview: Remove string cast, should pass string
        key = dkeys{index};
        value = matlabDict(key);
        if iscell(value)
            % Convert Array into Collection
            javaMapValue = convertCellArrayToArrayList(value{1});
            javaMap.put(key, javaMapValue);
        else
            javaMap.put(key,matlabToJava(value));
        end
    end

end

end
% Convert Struct to Java HashMap
function javaMap = convertStructToJavaMap(matlabStruct)
fields = fieldnames(matlabStruct);
javaMap = java.util.HashMap();
if ~isempty(fields)
    for index = 1:numel(fields)
        key = fields{index};
        val = matlabStruct.(key);
        javaMap.put(key, matlabToJava(val));
    end
end
end

% Convert MATLAB Cell Array to Java Collection -ArrayList
function javaCol = convertCellArrayToArrayList(matlabArray)
javaArrayList = java.util.ArrayList();
numObjects = numel(matlabArray);

% Fill the Java array with the Handle of each aws.Object
for index = 1:numObjects
    if isa(matlabArray(index),"aws.Object")
        javaArrayList.add(matlabArray(index).Handle);
    else
        javaArrayList.add(matlabArray(index));
    end
end
javaCol = javaArrayList ;
end
