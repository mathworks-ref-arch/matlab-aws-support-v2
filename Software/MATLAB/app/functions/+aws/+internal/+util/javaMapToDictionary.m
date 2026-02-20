function resultDict = javaMapToDictionary(javaMap)
% Helper method to convert a Java Map to a MATLAB dictionary

% Copyright 2025 The MathWorks, Inc.

keySet = javaMap.keySet().toArray();
resultDict = dictionary();

for index = 1:length(keySet)
    key = string(keySet(index));
    value = javaMap.get(keySet(index));
    if isa(value, 'java.lang.String')
        value = string(value);
    elseif isa(value, 'java.lang.Integer') || isa(value, 'java.lang.Double')
        value = double(value);
    end
    resultDict(key) = value;    
end
end