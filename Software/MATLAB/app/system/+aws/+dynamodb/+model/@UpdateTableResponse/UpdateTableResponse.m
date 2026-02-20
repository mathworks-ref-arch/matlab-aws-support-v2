classdef UpdateTableResponse < aws.Object
    % UPDATETABLERESPONSE MATLAB wrapper for UpdateTable results.
    %
    % Syntax
    %   resp = aws.dynamodb.model.UpdateTableResponse(javaResponse);
    %
    % Properties
    %   tableDescription - aws.dynamodb.model.TableDescription reflecting the updated table.
    %
    % Example
    %   resp = ddb.updateTable(tableName="Orders", provisionedThroughput=pt);
    %   disp(resp.tableDescription.tableStatus);

    % Copyright 2025 The MathWorks, Inc.

    properties
        tableDescription aws.dynamodb.model.TableDescription
    end

    methods
        function obj = UpdateTableResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.dynamodb.model.UpdateTableResponse')
                obj.Handle = varargin{1};
                obj.tableDescription = aws.dynamodb.model.TableDescription( ...
                    obj.Handle.tableDescription());

            else
                logObj = Logger.getLogger();
                write(logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
