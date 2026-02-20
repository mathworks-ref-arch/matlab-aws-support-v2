classdef DeleteItemResponse < aws.Object
    % DELETEITEMRESPONSE MATLAB wrapper for DeleteItem results.
    %
    % Syntax
    %   resp = aws.dynamodb.model.DeleteItemResponse(javaResponse);
    %
    % Properties
    %   attributes        - dictionary(string -> aws.dynamodb.model.AttributeValue) returned when ReturnValues requested.
    %   consumedCapacity  - aws.dynamodb.model.ConsumedCapacity metrics.
    %
    % Example
    %   resp = ddb.deleteItem(tableName="Users", key=keyDict, returnValues="ALL_OLD");
    %   removedItem = resp.attributes;

    % Copyright 2025 The MathWorks, Inc.

    properties
        % Appears only if ReturnValues was specified
        attributes dictionary            % dictionary(string -> aws.dynamodb.model.AttributeValue)
        consumedCapacity aws.dynamodb.model.ConsumedCapacity
    end

    methods
        function obj = DeleteItemResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.dynamodb.model.DeleteItemResponse')
                obj.Handle = varargin{1};

                % attributes() is a java.util.Map<String, AttributeValue>
                obj.attributes = obj.extractAttributes(obj.Handle.attributes());

                % consumedCapacity() may be empty
                cc = obj.Handle.consumedCapacity();
                if ~isempty(cc)
                    obj.consumedCapacity = aws.dynamodb.model.ConsumedCapacity(cc);
                end
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end

    methods(Access = private)
        function dictOut = extractAttributes(~, javaAttributes)
            dictOut = dictionary(string.empty(1,0), cell.empty(1,0));
            if isempty(javaAttributes) || javaAttributes.isEmpty()
                return
            end

            jKeys = cell(javaAttributes.keySet().toArray()); % cellstr of Java keys
            % Fetch Java AttributeValue for each key
            jVals = cellfun(@(k) javaAttributes.get(k), jKeys, 'UniformOutput', false);
            % Wrap each Java AttributeValue using AttributeValue(attributeValue=...)
            mVals = cellfun(@(jv) aws.dynamodb.model.AttributeValue(attributeValue=jv), ...
                jVals, 'UniformOutput', false);

            dictOut = dictionary(string(jKeys), mVals);
        end
    end
end
