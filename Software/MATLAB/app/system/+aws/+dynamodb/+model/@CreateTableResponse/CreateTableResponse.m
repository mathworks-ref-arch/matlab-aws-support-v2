classdef CreateTableResponse < aws.Object
    % CREATETABLERESPONSE MATLAB wrapper for CreateTable results.
    %
    % Syntax
    %   resp = aws.dynamodb.model.CreateTableResponse(javaResponse);
    %
    % Properties
    %   tableDescription - aws.dynamodb.model.TableDescription describing the new table.
    %
    % Example
    %   resp = ddb.createTable(tableName="MyTable", ...);
    %   status = resp.tableDescription.tableStatus;

    % Copyright 2025 The MathWorks, Inc.

    properties
        tableDescription aws.dynamodb.model.TableDescription
    end

    methods
        function obj = CreateTableResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.dynamodb.model.CreateTableResponse')
                obj.Handle = varargin{1};
                obj.tableDescription = aws.dynamodb.model.TableDescription( ...
                    varargin{1}.tableDescription());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
