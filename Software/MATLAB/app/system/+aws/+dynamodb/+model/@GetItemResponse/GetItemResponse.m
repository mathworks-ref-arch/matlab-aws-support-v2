classdef GetItemResponse < aws.Object
    % GETITEMRESPONSE MATLAB wrapper for GetItem results.
    %
    % Syntax
    %   resp = aws.dynamodb.model.GetItemResponse(javaResponse);
    %
    % Properties
    %   item              - dictionary(string -> aws.dynamodb.model.AttributeValue) for the retrieved item.
    %   consumedCapacity  - aws.dynamodb.model.ConsumedCapacity metrics when requested.
    %
    % Example
    %   resp = ddb.getItem(tableName="Users", key=keyDict);
    %   name = resp.item("name").getValue();

    % Copyright 2025 The MathWorks, Inc.

    properties
        item dictionary
        consumedCapacity aws.dynamodb.model.ConsumedCapacity
    end

    methods
        function obj = GetItemResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.dynamodb.model.GetItemResponse')
                obj.Handle = varargin{1};
                obj.item = obj.extractAttributes(obj.Handle.item());
                % consumedCapacity() may be empty
                cc = obj.Handle.consumedCapacity();
                if ~isempty(cc)
                    obj.consumedCapacity = aws.dynamodb.model.ConsumedCapacity(cc);
                end
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end

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
