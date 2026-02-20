classdef ExecuteStatementResponse < aws.Object
    % EXECUTESTATEMENTRESPONSE Results returned by executeStatement.
    %
    % Syntax
    %   resp = aws.redshiftdata.model.ExecuteStatementResponse(javaResponse);
    %
    % Properties
    %   id                      - (string) Statement identifier.
    %   clusterIdentifier       - (string) Provisioned cluster identifier (if used).
    %   workgroupName           - (string) Serverless workgroup name.
    %   database                - (string) Target database.
    %   hasResultSet            - (logical) True when the statement produces rows.
    %   numberOfRecordsUpdated  - (double) Row count for DML statements.
    %   createdAt               - (datetime) Creation timestamp (UTC).
    %   updatedAt               - (datetime) Last update timestamp (UTC).

    % Copyright 2025 The MathWorks, Inc.

    properties
        id string = ""
        clusterIdentifier string = ""
        workgroupName string = ""
        database string = ""
        hasResultSet logical = false
        numberOfRecordsUpdated double = NaN
        createdAt datetime = NaT
        updatedAt datetime = NaT
    end

    methods
        function obj = ExecuteStatementResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.redshiftdata.model.ExecuteStatementResponse')
                respJ = varargin{1};
                obj.Handle = respJ;
                obj.id = string(respJ.id());
                obj.clusterIdentifier = stringOrEmpty(respJ.clusterIdentifier());
                obj.workgroupName = stringOrEmpty(respJ.workgroupName());
                obj.database = stringOrEmpty(respJ.database());
                obj.hasResultSet = logical(respJ.hasResultSet());
                if ~isempty(respJ.numberOfRecordsUpdated())
                    obj.numberOfRecordsUpdated = double(respJ.numberOfRecordsUpdated());
                end
                obj.createdAt = convertInstant(respJ.createdAt());
                obj.updatedAt = convertInstant(respJ.updatedAt());
            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end
    end
end

function out = stringOrEmpty(value)
if isempty(value)
    out = "";
else
    out = string(value);
end
end

function dt = convertInstant(instant)
if isempty(instant)
    dt = NaT;
else
    dt = datetime(double(instant.toEpochMilli())/1000, ...
        'ConvertFrom','posixtime','TimeZone','UTC');
end
end

