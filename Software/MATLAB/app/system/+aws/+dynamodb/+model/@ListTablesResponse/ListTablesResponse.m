classdef ListTablesResponse < aws.Object
    % LISTTABLESRESPONSE MATLAB wrapper for ListTables results.
    %
    % Syntax
    %   resp = aws.dynamodb.model.ListTablesResponse(javaResponse);
    %
    % Properties
    %   tableNames            - String array of table names returned in this page.
    %   lastEvaluatedTableName - String continuation token (empty when listing completed).
    %
    % Example
    %   resp = ddb.listTables(limit=10);
    %   moreToken = resp.lastEvaluatedTableName;

    % Copyright 2025 The MathWorks, Inc.

    properties
        tableNames string
        lastEvaluatedTableName string
    end

    methods
        function obj = ListTablesResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.dynamodb.model.ListTablesResponse')
                obj.Handle = varargin{1};
                obj.tableNames = varargin{1}.tableNames();
                obj.lastEvaluatedTableName = varargin{1}.lastEvaluatedTableName();
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
