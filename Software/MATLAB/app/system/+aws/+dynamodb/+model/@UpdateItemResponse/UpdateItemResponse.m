classdef UpdateItemResponse < aws.Object
    % UPDATEITEMRESPONSE MATLAB wrapper for UpdateItem results.
    %
    % Syntax
    %   resp = aws.dynamodb.model.UpdateItemResponse(javaResponse);
    %
    % Properties
    %   attributes            - dictionary(string -> aws.dynamodb.model.AttributeValue) returned per ReturnValues.
    %   consumedCapacity      - aws.dynamodb.model.ConsumedCapacity metrics.
    %   itemCollectionMetrics - aws.dynamodb.model.ItemCollectionMetrics for the affected partition.
    %
    % Example
    %   resp = ddb.updateItem(..., returnValues="ALL_NEW");
    %   updated = resp.attributes;

    % Copyright 2025 The MathWorks, Inc.

    properties
        attributes dictionary
        consumedCapacity aws.dynamodb.model.ConsumedCapacity
        itemCollectionMetrics aws.dynamodb.model.ItemCollectionMetrics
    end

    methods
        function obj = UpdateItemResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.dynamodb.model.UpdateItemResponse')
                obj.Handle = varargin{1};
                obj.attributes = obj.extractAttributes(obj.Handle.attributes());
                % consumedCapacity() may be empty
                cc = obj.Handle.consumedCapacity();
                if ~isempty(cc)
                    obj.consumedCapacity = aws.dynamodb.model.ConsumedCapacity(cc);
                end
                metrics = obj.Handle.itemCollectionMetrics();
                if ~isempty(metrics)
                    obj.itemCollectionMetrics = aws.dynamodb.model.ItemCollectionMetrics(metrics);
                end
            else
                logObj = Logger.getLogger();
                write(logObj, 'error', 'Invalid arguments');
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
