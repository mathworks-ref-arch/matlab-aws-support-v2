classdef ScanResponse < aws.Object
    %SCANRESPONSE MATLAB wrapper for DynamoDB Scan responses.
    %
    % Syntax
    %   resp = aws.dynamodb.model.ScanResponse(javaResponse);
    %
    % Properties
    %   items            - (dictionary) Each cell is a dictionary(string -> aws.dynamodb.model.AttributeValue)
    %                      representing an item returned by the scan.
    %   count            - (int32) Number of items returned after filter evaluation.
    %   scannedCount     - (int32) Total items evaluated before filters.
    %   lastEvaluatedKey - (dictionary) Token to continue scanning (string -> AttributeValue).
    %   consumedCapacity - (aws.dynamodb.model.ConsumedCapacity) Optional capacity metrics.
    %
    % Example
    %   resp = ddb.scan(tableName="Users");
    %   if ~isempty(resp.lastEvaluatedKey)
    %       resp2 = ddb.scan(tableName="Users", exclusiveStartKey=resp.lastEvaluatedKey);
    %   end

    % Copyright 2025 The MathWorks, Inc.

    properties
        items
        count int32
        scannedCount int32
        lastEvaluatedKey
        consumedCapacity aws.dynamodb.model.ConsumedCapacity
    end

    methods
        function obj = ScanResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.dynamodb.model.ScanResponse')
                obj.Handle = varargin{1};

                obj.items = obj.extractAttributes(obj.Handle.items());
                obj.count = obj.Handle.count().intValue();
                obj.scannedCount = obj.Handle.scannedCount().intValue();
                obj.lastEvaluatedKey = obj.extractKeyDictionary(obj.Handle.lastEvaluatedKey());

                cc = obj.Handle.consumedCapacity();
                if ~isempty(cc)
                    obj.consumedCapacity = aws.dynamodb.model.ConsumedCapacity(cc);
                end
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
        function itemsCell = extractAttributes(~, jItems)
            %EXTRACTATTRIBUTES Convert List<Map<String, AttributeValue>> to
            % cell array of dictionary(string ⟼ cell{aws.dynamodb.model.AttributeValue})

            if isempty(jItems)
                itemsCell = {};
                return;
            end

            n = jItems.size();
            itemsCell = cell(1, n);

            for i = 1:n
                jMap = jItems.get(i-1);  % java.util.Map<String, AttributeValue>
                % Collect keys (Java Set<String> -> cellstr -> string)
                jKeySet = jMap.keySet();
                jIter = jKeySet.iterator();
                ks = strings(0);
                vs = {};
                while jIter.hasNext()
                    k = string(jIter.next());
                    jAv = jMap.get(k);
                    % Wrap the Java AttributeValue with your MATLAB wrapper:
                    avWrap = aws.dynamodb.model.AttributeValue(attributeValue = jAv);
                    ks(end+1,1) = k;             %#ok<AGROW>
                    vs{end+1,1} = {avWrap};       %#ok<AGROW> % 1x1 cell containing wrapper
                end

                if isempty(ks)
                    itemsCell{i} = dictionary(string.empty(1,0), cell.empty(1,0));
                else
                    itemsCell{i} = dictionary(ks, vs);
                end
            end
        end

        function d = extractKeyDictionary(~, jMap)
            %EXTRACTKEYDICTIONARY Convert Map<String, AttributeValue> into
            % dictionary(string ⟼ aws.dynamodb.model.AttributeValue)

            if isempty(jMap) || jMap.isEmpty()
                d = [];
                return;
            end

            % Build parallel string and object arrays (no cells!)
            ks   = strings(1, 0);
            vals = aws.dynamodb.model.AttributeValue.empty(1, 0);

            jKeySet = jMap.keySet();
            jIter   = jKeySet.iterator();
            while jIter.hasNext()
                k   = string(jIter.next());
                jAv = jMap.get(k);
                avWrap = aws.dynamodb.model.AttributeValue(attributeValue = jAv);

                ks(end+1)   = k;       %#ok<AGROW>
                vals(end+1) = avWrap;  %#ok<AGROW>
            end

            if isempty(ks)
                d = dictionary(string.empty(1,0), aws.dynamodb.model.AttributeValue.empty(1,0));
            else
                d = dictionary(ks, vals);   % <-- values are a typed object array
            end
        end
    end
end
