classdef BatchWriteItemResponse < aws.Object
    % BATCHWRITEITEMRESPONSE MATLAB wrapper for BatchWriteItem results.
    %
    % Syntax
    %   resp = aws.dynamodb.model.BatchWriteItemResponse(javaResponse);
    %
    % Properties
    %   unprocessedItems - dictionary(tableName -> cell array of aws.dynamodb.model.WriteRequest)
    %   consumedCapacity - Cell array of aws.dynamodb.model.ConsumedCapacity entries (one per table).
    %
    % Example
    %   resp = ddb.batchWriteItem(requestItems=reqs);
    %   outstanding = resp.unprocessedItems;

    % Copyright 2025 The MathWorks, Inc.

    properties
        unprocessedItems dictionary = dictionary(string.empty(1,0), cell.empty(1,0));
        consumedCapacity cell
    end

    methods
        function obj = BatchWriteItemResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.dynamodb.model.BatchWriteItemResponse')
                obj.Handle = varargin{1};

                % Unprocessed items (java.util.Map<String, List<WriteRequest>>)
                obj.unprocessedItems = obj.extractUnprocessedItems(obj.Handle.unprocessedItems());

                % Consumed capacity
                consumedCapacityListJ = obj.Handle.consumedCapacity();
                if ~isempty(consumedCapacityListJ)
                    numItems = consumedCapacityListJ.size();
                    if numItems > 0
                        consumedCapacity = cell(1, numItems);
                        it = consumedCapacityListJ.iterator();
                        index = 1;
                        while it.hasNext()
                            consumedCapacityJ = it.next();
                            consumedCapacity{index} = aws.dynamodb.model.ConsumedCapacity(consumedCapacityJ);
                            index = index + 1;
                        end
                        obj.consumedCapacity = consumedCapacity;
                    end
                end

            else
                logObj = Logger.getLogger();
                write(logObj, 'error', 'Invalid arguments');
            end
        end
    end

    methods (Access = private)
        function dictOut = extractUnprocessedItems(~, javaMap)
            dictOut = dictionary(string.empty(1,0), cell.empty(1,0));
            if isempty(javaMap) || javaMap.isEmpty()
                return
            end
            keysJ = javaMap.keySet().iterator();
            keyList = strings(1, javaMap.size());
            values = cell(1, javaMap.size());
            idx = 0;
            while keysJ.hasNext()
                idx = idx + 1;
                key = string(keysJ.next());
                writesJ = javaMap.get(key);
                values{idx} = convertWriteRequests(writesJ);
                keyList(idx) = key;
            end
            keyList = keyList(1:idx);
            values = values(1:idx);
            dictOut = dictionary(keyList, values);

            function wrCell = convertWriteRequests(listJ)
                if isempty(listJ)
                    wrCell = cell(1,0);
                    return
                end
                N = listJ.size();
                wrCell = cell(1, N);
                for n = 1:N
                    wrCell{n} = aws.dynamodb.model.WriteRequest(listJ.get(n-1));
                end
            end
        end
    end
end
