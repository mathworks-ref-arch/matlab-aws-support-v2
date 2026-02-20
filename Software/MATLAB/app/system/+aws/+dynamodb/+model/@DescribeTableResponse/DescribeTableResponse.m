classdef DescribeTableResponse < aws.Object
    % DESCRIBETABLERESPONSE MATLAB wrapper for DescribeTable results.
    %
    % Syntax
    %   resp = aws.dynamodb.model.DescribeTableResponse(javaResponse);
    %
    % Properties
    %   table - aws.dynamodb.model.TableDescription containing metadata for the table.
    %
    % Example
    %   resp = ddb.describeTable(tableName="Users");
    %   throughput = resp.table.provisionedThroughput;

    % Copyright 2025 The MathWorks, Inc.

    properties
        table aws.dynamodb.model.TableDescription
    end

    methods
        function obj = DescribeTableResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.dynamodb.model.DescribeTableResponse')
                obj.Handle = varargin{1};
                obj.table = aws.dynamodb.model.TableDescription( ...
                    varargin{1}.table());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
