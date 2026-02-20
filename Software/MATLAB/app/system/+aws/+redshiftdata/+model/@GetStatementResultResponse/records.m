function recordsArray = records(obj)
% RECORDS Return the result rows as Field objects.
%
% Syntax
%   rows = resp.records();
%
% Returns
%   recordsArray - cell array (one cell per row). Each row contains a cell array
%                  of `aws.redshiftdata.model.Field` objects.

% Copyright 2025 The MathWorks, Inc.

if ~isempty(obj.recordRows)
    recordsArray = obj.recordRows;
    return
end

records = obj.Handle.records();
rowCount = records.size();
recordsArray = cell(rowCount, 1);

for rowIndex = 1:rowCount
    javaFields = records.get(rowIndex - 1);
    numFields = javaFields.size();
    matlabFields = cell(1, numFields);
    for colIndex = 1:numFields
        javaField = javaFields.get(colIndex - 1);
        matlabFields{colIndex} = aws.redshiftdata.model.Field(javaField);
    end
    recordsArray{rowIndex} = matlabFields;
end

obj.recordRows = recordsArray;
end

