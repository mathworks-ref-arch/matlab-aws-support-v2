classdef ConsumedCapacity < aws.Object
    % CONSUMEDCAPACITY MATLAB wrapper for DynamoDB capacity metrics.
    %
    % Syntax
    %   cc = aws.dynamodb.model.ConsumedCapacity(javaResponse);
    %
    % Properties
    %   capacityUnits         - Total capacity units consumed (double, NaN when absent).
    %   readCapacityUnits     - Read capacity units consumed.
    %   writeCapacityUnits    - Write capacity units consumed.
    %   tableName             - Table name associated with this measurement.
    %   tableCapacityUnits    - Capacity units consumed specifically by the table.
    %   tableReadCapacityUnits  - Table-level read capacity.
    %   tableWriteCapacityUnits - Table-level write capacity.
    %
    % Example
    %   resp = ddb.putItem(..., returnConsumedCapacity="TOTAL");
    %   disp(resp.consumedCapacity.capacityUnits);

    % Copyright 2025 The MathWorks, Inc.

    properties
        capacityUnits double = NaN
        readCapacityUnits double = NaN
        writeCapacityUnits double = NaN
        tableName string = ""
        tableCapacityUnits double = NaN
        tableReadCapacityUnits double = NaN
        tableWriteCapacityUnits double = NaN
        % For completeness, you may later extend this with local/global index maps
        % as needed, e.g., localSecondaryIndexes, globalSecondaryIndexes
    end

    methods
        function obj = ConsumedCapacity(varargin)
            % Constructor accepts a software.amazon.awssdk.services.dynamodb.model.ConsumedCapacity
            if nargin == 1
                in = varargin{1};
                if ~isa(in, 'software.amazon.awssdk.services.dynamodb.model.ConsumedCapacity')
                    write(obj.logObj, 'error', ...
                        'Argument not of type software.amazon.awssdk.services.dynamodb.model.ConsumedCapacity');
                    return
                end
                obj.Handle = in;

                % Top-level capacity units (may be null depending on API)
                if ~isempty(in.capacityUnits())
                    obj.capacityUnits = double(in.capacityUnits());
                end

                if ~isempty(in.readCapacityUnits())
                    obj.readCapacityUnits = double(in.readCapacityUnits());
                end

                if ~isempty(in.writeCapacityUnits())
                    obj.writeCapacityUnits = double(in.writeCapacityUnits());
                end

                if ~isempty(in.tableName())
                    obj.tableName = string(in.tableName());
                end

                % Table-level capacity (inside the "table" sub-structure)
                tableCap = in.table();
                if ~isempty(tableCap)
                    if ~isempty(tableCap.capacityUnits())
                        obj.tableCapacityUnits = double(tableCap.capacityUnits());
                    end
                    if ~isempty(tableCap.readCapacityUnits())
                        obj.tableReadCapacityUnits = double(tableCap.readCapacityUnits());
                    end
                    if ~isempty(tableCap.writeCapacityUnits())
                        obj.tableWriteCapacityUnits = double(tableCap.writeCapacityUnits());
                    end
                end

                % Note: localSecondaryIndexes and globalSecondaryIndexes are maps
                % from index name to Capacity (with the same fields). Add parsing
                % here if you need per-index details.

            else
                write(obj.logObj,'error','Invalid number of arguments');
            end
        end
    end

end
