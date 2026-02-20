function resultSetTable = getResultSet(obj)
% GETRESULTSET Convert the records into a MATLAB table.
%
% Syntax
%   tbl = resp.getResultSet();
%
% Returns
%   resultSetTable - table whose variables match the Redshift column metadata.

% Copyright 2025 The MathWorks, Inc.

rows = obj.records();
if isempty(rows)
    resultSetTable = table();
    return
end

columnNames = arrayfun(@(meta) char(meta.name), obj.columnMetadata, 'UniformOutput', false);
numRows = numel(rows);
numColumns = numel(columnNames);
data = cell(numRows, numColumns);

for rowIndex = 1:numRows
    fields = rows{rowIndex};
    for colIndex = 1:numColumns
        field = fields{colIndex};
        data{rowIndex, colIndex} = field.getValue();
    end
end

resultSetTable = cell2table(data, 'VariableNames', matlab.lang.makeValidName(columnNames));
end
