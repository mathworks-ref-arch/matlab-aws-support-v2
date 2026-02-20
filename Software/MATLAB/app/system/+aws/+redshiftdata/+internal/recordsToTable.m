function resultSetTable = recordsToTable(recordRows, columnMetadata)
% RECORDSTOTABLE Convert Redshift record rows into a typed MATLAB table.
%
% Syntax
%   tbl = aws.redshiftdata.internal.recordsToTable(recordRows, columnMetadata);
%
% Inputs
%   recordRows     - Cell array where each element is a row cell array of
%                    `aws.redshiftdata.model.Field` objects.
%   columnMetadata - Struct array describing each column (name, typeName, etc.).
%
% Returns
%   resultSetTable - MATLAB table with variables typed according to
%                    Redshift metadata (strings, doubles, datetimes,
%                    durations, logicals, or cell arrays for binary/JSON).
%
% Notes
%   - NULL numeric values become `NaN`.
%   - NULL date/time values become `NaT`.
%   - NULL strings become `missing`.

% Copyright 2025 The MathWorks, Inc.

arguments
    recordRows (:,1) cell
    columnMetadata (1,:) struct
end

if isempty(recordRows) || isempty(columnMetadata)
    resultSetTable = table();
    return
end

columnNames = arrayfun(@(meta) char(meta.name), columnMetadata, 'UniformOutput', false);
validNames = matlab.lang.makeValidName(columnNames, 'ReplacementStyle', 'delete');
columnKinds = classifyColumnKinds(columnMetadata);

numRows = numel(recordRows);
numCols = numel(columnMetadata);
columnCells = cell(1, numCols);
nullMasks = false(numRows, numCols);

for colIdx = 1:numCols
    columnCells{colIdx} = cell(numRows, 1);
end

for rowIdx = 1:numRows
    fields = recordRows{rowIdx};
    for colIdx = 1:numCols
        field = fields{colIdx};
        [convertedValue, isNull] = convertFieldValue(field, columnKinds{colIdx});
        columnCells{colIdx}{rowIdx} = convertedValue;
        nullMasks(rowIdx, colIdx) = isNull;
    end
end

tableVars = cell(1, numCols);
for colIdx = 1:numCols
    tableVars{colIdx} = finalizeColumn(columnCells{colIdx}, columnKinds{colIdx}, nullMasks(:, colIdx));
end

resultSetTable = table(tableVars{:}, 'VariableNames', validNames);
end

function kinds = classifyColumnKinds(metadata)
numCols = numel(metadata);
kinds = cell(1, numCols);
for idx = 1:numCols
    rawType = metadata(idx).typeName;
    if strlength(rawType) == 0
        kinds{idx} = "string";
        continue
    end
    typeName = lower(strtrim(string(rawType)));
    if contains(typeName, "timestamp")
        kinds{idx} = "timestamp";
    elseif contains(typeName, "time")
        kinds{idx} = "time";
    elseif typeName == "date"
        kinds{idx} = "date";
    elseif any(strcmp(typeName, ["bool","boolean"]))
        kinds{idx} = "boolean";
    elseif any(strcmp(typeName, ["varchar","character varying","char","character","bpchar","text","name"]))
        kinds{idx} = "string";
    elseif any(strcmp(typeName, ["json","jsonb","super"]))
        kinds{idx} = "json";
    elseif any(strcmp(typeName, ["varbyte","bytea"]))
        kinds{idx} = "binary";
    elseif contains(typeName, "int") || any(strcmp(typeName, ["integer","smallint","bigint"]))
        kinds{idx} = "numeric";
    elseif contains(typeName, "float") || contains(typeName, "double") || any(strcmp(typeName, ["numeric","decimal","real"]))
        kinds{idx} = "numeric";
    else
        kinds{idx} = "string";
    end
end
end

function [value, isNull] = convertFieldValue(fieldObj, kind)
if fieldObj.isNull
    value = [];
    isNull = true;
    return
end

rawValue = fieldObj.getValue();
isNull = false;

switch kind
    case "numeric"
        value = double(rawValue);
    case "boolean"
        value = logical(rawValue);
    case "timestamp"
        value = parseTimestampValue(string(rawValue));
    case "date"
        value = parseDateValue(string(rawValue));
    case "time"
        value = parseTimeValue(string(rawValue));
    case "json"
        value = parseJsonValue(rawValue);
    case "string"
        value = string(rawValue);
    otherwise
        value = rawValue;
end
end

function column = finalizeColumn(values, kind, nullMask)
numRows = numel(values);
switch kind
    case "string"
        column = strings(numRows, 1);
        column(:) = missing;
        for idx = 1:numRows
            val = values{idx};
            if ~isempty(val)
                column(idx) = string(val);
            end
        end
    case "numeric"
        column = nan(numRows, 1);
        for idx = 1:numRows
            val = values{idx};
            if ~isempty(val)
                column(idx) = double(val);
            end
        end
    case "boolean"
        logicalValues = false(numRows, 1);
        for idx = 1:numRows
            val = values{idx};
            if ~isempty(val)
                logicalValues(idx) = logical(val);
            end
        end
        if any(nullMask)
            column = nan(numRows, 1);
            column(~nullMask) = double(logicalValues(~nullMask));
        else
            column = logicalValues;
        end
    case "timestamp"
        column = NaT(numRows, 1, 'TimeZone', 'UTC');
        for idx = 1:numRows
            val = values{idx};
            if ~isempty(val)
                column(idx) = val;
            end
        end
    case "date"
        column = NaT(numRows, 1);
        for idx = 1:numRows
            val = values{idx};
            if ~isempty(val)
                column(idx) = val;
            end
        end
    case "time"
        column = seconds(nan(numRows, 1));
        for idx = 1:numRows
            val = values{idx};
            if ~isempty(val)
                column(idx) = val;
            end
        end
    case {"binary","json"}
        column = values;
    otherwise
        column = values;
end
end

function dt = parseTimestampValue(value)
candidates = {
    "uuuu-MM-dd HH:mm:ss.SSSSSSXXX"
    "uuuu-MM-dd'T'HH:mm:ss.SSSSSSXXX"
    "uuuu-MM-dd HH:mm:ss.SSSSSS"
    "uuuu-MM-dd'T'HH:mm:ss.SSSSSS"
    "uuuu-MM-dd HH:mm:ssXXX"
    "uuuu-MM-dd'T'HH:mm:ssXXX"
    "uuuu-MM-dd HH:mm:ss"
    "uuuu-MM-dd'T'HH:mm:ss"
    };
for idx = 1:numel(candidates)
    fmt = candidates{idx};
    try
        dt = datetime(value, 'InputFormat', fmt, 'TimeZone', 'UTC');
        return
    catch
        % try next format
    end
end
dt = datetime(value, 'TimeZone', 'UTC');
end

function d = parseDateValue(value)
formats = ["uuuu-MM-dd", "yyyy-MM-dd"];
for fmt = formats
    try
        d = datetime(value, 'InputFormat', fmt, 'TimeZone', 'UTC');
        return
    catch
    end
end
d = datetime(value, 'TimeZone', 'UTC');
end

function dur = parseTimeValue(value)
pattern = '^(?<h>\d{1,2}):(?<m>\d{1,2}):(?<s>\d+(?:\.\d+)?)';
tokens = regexp(value, pattern, 'names');
if isempty(tokens)
    dur = seconds(NaN);
    return
end
hoursVal = str2double(tokens.h);
minutesVal = str2double(tokens.m);
secondsVal = str2double(tokens.s);
dur = hours(hoursVal) + minutes(minutesVal) + seconds(secondsVal);
end

function parsed = parseJsonValue(rawValue)
if isstring(rawValue) || ischar(rawValue)
    text = string(rawValue);
    try
        parsed = jsondecode(text);
        return
    catch
        parsed = text;
        return
    end
end
parsed = rawValue;
end
