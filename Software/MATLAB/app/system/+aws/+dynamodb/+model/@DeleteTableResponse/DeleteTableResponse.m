classdef DeleteTableResponse < aws.Object
    % DELETETABLERESPONSE MATLAB wrapper for DeleteTable results.
    %
    % Syntax
    %   resp = aws.dynamodb.model.DeleteTableResponse(javaResponse);
    %
    % Properties
    %   tableDescription - aws.dynamodb.model.TableDescription for the deleted table.
    %
    % Example
    %   resp = ddb.deleteTable(tableName="Obsolete");
    %   disp(resp.tableDescription.tableStatus);

    % Copyright 2025 The MathWorks, Inc.

    properties
        tableDescription aws.dynamodb.model.TableDescription
    end

    methods
        function obj = DeleteTableResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.dynamodb.model.DeleteTableResponse')
                obj.Handle = varargin{1};
                obj.tableDescription = aws.dynamodb.model.TableDescription( ...
                    varargin{1}.tableDescription());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
