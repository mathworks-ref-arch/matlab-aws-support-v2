classdef GetStatementResultResponse < aws.Object
    % GETSTATEMENTRESULTRESPONSE Result of getStatementResult.
    %
    % Syntax
    %   resp = aws.redshiftdata.model.GetStatementResultResponse(javaResp);
    %
    % Properties
    %   columnMetadata - struct array describing each column (name, typeName, length, nullable).
    %   recordRows     - cell array where each row is a cell array of `aws.redshiftdata.model.Field`.
    %   nextToken      - (string) Pagination token when more rows remain.
    %   hasNextToken   - (logical) True when `nextToken` is populated.
    %   totalNumRows   - (double) Reported total number of rows (if provided).

    % Copyright 2025 The MathWorks, Inc.

    properties
        columnMetadata struct = struct('name', string.empty, 'typeName', string.empty, ...
            'length', double.empty, 'nullable', string.empty)
        recordRows cell = {}
        nextToken string = ""
        hasNextToken logical = false
        totalNumRows double = NaN
    end

    methods
        function obj = GetStatementResultResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.redshiftdata.model.GetStatementResultResponse')
                respJ = varargin{1};
                obj.Handle = respJ;
                obj.columnMetadata = buildColumnMetadata(respJ);
                obj.recordRows = buildRecordRows(respJ);
                if ~isempty(respJ.nextToken())
                    obj.nextToken = string(respJ.nextToken());
                    obj.hasNextToken = true;
                end
                if ~isempty(respJ.totalNumRows())
                    obj.totalNumRows = double(respJ.totalNumRows());
                end
            else
                logObj = Logger.getLogger();
                write(logObj, 'error', 'Invalid arguments');
            end
        end
    end
end

function metadata = buildColumnMetadata(respJ)
metaList = respJ.columnMetadata();
count = metaList.size();
if count == 0
    metadata = struct('name', string.empty, 'typeName', string.empty, ...
        'length', double.empty, 'nullable', string.empty);
    return
end
metadata(count,1) = struct('name',"",'typeName',"",'length',NaN,'nullable',""); %#ok<AGROW>
for idx = 0:count-1
    meta = metaList.get(idx);
    metadata(idx+1).name = string(meta.name());
    metadata(idx+1).typeName = string(meta.typeName());
    if ~isempty(meta.length())
        metadata(idx+1).length = double(meta.length());
    else
        metadata(idx+1).length = NaN;
    end
    if ~isempty(meta.nullable())
        metadata(idx+1).nullable = string(meta.nullable());
    else
        metadata(idx+1).nullable = "";
    end
end
end

function rows = buildRecordRows(respJ)
records = respJ.records();
rowCount = records.size();
rows = cell(rowCount, 1);
for rowIndex = 1:rowCount
    javaFields = records.get(rowIndex - 1);
    numFields = javaFields.size();
    rowCells = cell(1, numFields);
    for colIndex = 1:numFields
        javaField = javaFields.get(colIndex - 1);
        rowCells{colIndex} = aws.redshiftdata.model.Field(javaField);
    end
    rows{rowIndex} = rowCells;
end
end
