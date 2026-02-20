classdef QueryResponse < aws.Object
    % QUERYRESPONSE MATLAB wrapper for Query results.
    %
    % Syntax
    %   resp = aws.dynamodb.model.QueryResponse(javaResponse);
    %
    % Properties
    %   items            - Cell array where each cell is dictionary(string -> aws.dynamodb.model.AttributeValue).
    %   consumedCapacity - aws.dynamodb.model.ConsumedCapacity metrics when requested.
    %   count            - int32 count of items returned after filters.
    %   scannedCount     - int32 number of items evaluated before filters.
    %
    % Example
    %   resp = ddb.query(...);
    %   fprintf(\"Returned %d items\\n\", resp.count);

    % Copyright 2025 The MathWorks, Inc.

    properties
        items cell % each cell: dictionary(string -> AttributeValue)
        consumedCapacity aws.dynamodb.model.ConsumedCapacity
        count int32
        scannedCount int32
    end

    methods
        function obj = QueryResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.dynamodb.model.QueryResponse')
                obj.Handle = varargin{1};

                % consumedCapacity() may be empty
                cc = obj.Handle.consumedCapacity();
                if ~isempty(cc)
                    obj.consumedCapacity = aws.dynamodb.model.ConsumedCapacity(cc);
                end

                itemsJ = obj.Handle.items();
                obj.items = obj.buildDictionaryItems(itemsJ);
                obj.count = obj.Handle.count().intValue();
                obj.scannedCount = obj.Handle.scannedCount().intValue();
            else
                logObj = Logger.getLogger();
                write(logObj, 'error', 'Invalid arguments');
            end
        end

        function dictItems = buildDictionaryItems(~, javaItems)
            % Return 1xN cell array, each cell is dictionary(string -> AttributeValue)

            if isempty(javaItems)
                dictItems = cell(1,0);
                return
            end
            if ~isa(javaItems, 'java.util.List')
                error('Input must be a java.util.List of java.util.Map<String, AttributeValue>.');
            end

            N = javaItems.size();
            if N == 0
                dictItems = cell(1,0);
                return
            end
            dictItems = cell(1, N);

            for index = 1:N
                jMap = javaItems.get(index-1);

                if isempty(jMap) || jMap.isEmpty()
                    dictItems{index} = dictionary(string.empty(1,0), cell.empty(1,0));
                    continue
                end

                % Iterate entries to avoid key lookups
                K = jMap.size();
                mKeys = strings(1, K);
                mVals = cell(1, K);

                it = jMap.entrySet().iterator();
                k = 0;
                while it.hasNext()
                    e = it.next(); % Map.Entry<String, AttributeValue>
                    k = k + 1;
                    mKeys(k) = string(e.getKey());
                    mVals{k} = aws.dynamodb.model.AttributeValue(attributeValue=e.getValue());
                end

                if k ~= K
                    mKeys = mKeys(1:k);
                    mVals = mVals(1:k);
                end

                dictItems{index} = dictionary(mKeys, mVals);
            end
        end

    end
end
