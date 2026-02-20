function objectArray = buildSdkObjectsFromDictionary(inputDictionary, sdkClass)
% BUILDSDKOBJECTSFROMDICTIONARY Convert MATLAB dictionaries into SDK objects.
%
% Syntax
%   objs = aws.internal.builder.buildSdkObjectsFromDictionary(dict, "software.amazon....Tag");
%
% Inputs
%   inputDictionary - (dictionary) Keys become the Java builder's name/key setters.
%   sdkClass        - (string) Fully qualified Java class that exposes a static builder().
%
% Returns
%   objectArray     - Java array containing the built SDK objects.
%
% Description
%   Iterates over each entry in INPUTDICTIONARY, populates the builder with
%   common `name`, `key`, and `value` setters when they exist, then stores
%   the result in a Java array. Empty dictionaries return [].

arguments
    inputDictionary (1,1) dictionary
    sdkClass (1,1) string {mustBeTextScalar, mustBeNonzeroLengthText}
end

% Copyright 2025 The MathWorks, Inc.

% Check if the input dictionary is not empty
if numEntries(inputDictionary) == 0
    objectArray = [];
    return;
end

% Preallocate the Java object array
paramKeys = keys(inputDictionary);
paramValues = values(inputDictionary);
numParams = numel(paramKeys);
javaObjectsArray = javaArray(sdkClass, numParams);

% Retrieve the builder method list once
builder = javaMethod('builder', sdkClass);
methodList = methods(builder);

% Loop through parameters and build each Java object
for idx = 1:numParams
    % Set name if method exists
    if ismember('name', methodList)
        builder.name(paramKeys{idx});
    end
    % Set key if method exists
    if ismember('key', methodList)
        builder.key(paramKeys{idx});
    end
    % Set value if method exists
    if ismember('value', methodList)
        builder.value(paramValues{idx});
    end

    % Build the object and store it in the array
    javaObjectsArray(idx) = builder.build();
end

% Return the constructed Java object array
objectArray = javaObjectsArray;
end
