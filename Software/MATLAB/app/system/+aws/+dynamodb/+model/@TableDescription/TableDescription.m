classdef TableDescription < aws.Object
    % TABLEDESCRIPTION MATLAB wrapper for DynamoDB table metadata.
    %
    % Syntax
    %   desc = aws.dynamodb.model.TableDescription(javaResponse);
    %
    % Properties
    %   tableName            - (string) Name of the table.
    %   tableId              - (string) Internal table identifier.
    %   tableArn             - (string) Table Amazon Resource Name.
    %   itemCount            - (int64) Number of items reported by DynamoDB.
    %   tableStatus          - (string) Status text, e.g., "ACTIVE".
    %   creationDateTime     - (datetime) when the table was created.
    %   provisionedThroughput - (aws.dynamodb.model.ProvisionedThroughput) settings snapshot.
    %
    % Example
    %   desc = resp.tableDescription;
    %   disp(desc.tableStatus);

    % Copyright 2025 The MathWorks, Inc.

    properties
        tableName string
        tableId string
        tableArn string
        itemCount int64
        tableStatus string
        creationDateTime datetime
        provisionedThroughput aws.dynamodb.model.ProvisionedThroughput
    end

    methods
        function obj = TableDescription(varargin)
            % Constructor for TableDescription
            % Handles the creation of the TableDescription object from a Java object
            if nargin == 1
                if ~isa(varargin{1}, 'software.amazon.awssdk.services.dynamodb.model.TableDescription')
                    logObj = Logger.getLogger();
                    write(logObj, 'error', 'argument not of type software.amazon.awssdk.services.dynamodb.model.TableDescription');
                else
                    obj.Handle = varargin{1};
                    tableDesc = varargin{1};
                    obj.tableName = tableDesc.tableName();
                    obj.tableId = tableDesc.tableId();
                    obj.tableArn = tableDesc.tableArn();
                    obj.itemCount = tableDesc.itemCount().longValue();
                    obj.tableStatus = tableDesc.tableStatus().toString();
                    obj.creationDateTime = aws.internal.util.javaInstantToDatetime(tableDesc.creationDateTime());
                    obj.provisionedThroughput = aws.dynamodb.model.ProvisionedThroughput( ...
                        readCapacityUnits=tableDesc.provisionedThroughput().readCapacityUnits().longValue(), ...
                        writeCapacityUnits=tableDesc.provisionedThroughput().writeCapacityUnits().longValue());
                end
            else
                logObj = Logger.getLogger();
                write(logObj, 'error', 'Invalid number of arguments');
            end
        end
    end

end
