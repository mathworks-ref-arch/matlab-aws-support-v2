classdef ItemCollectionMetrics < aws.Object
    % ITEMCOLLECTIONMETRICS MATLAB wrapper for item collection metrics.
    %
    % Syntax
    %   metrics = aws.dynamodb.model.ItemCollectionMetrics(javaResponse);
    %
    % Properties
    %   itemCollectionKey   - dictionary identifying the partition key of the collection.
    %   sizeEstimateRangeGB - double array with lower/upper size estimates (GB).
    %
    % Example
    %   metrics = resp.itemCollectionMetrics;
    %   disp(metrics.sizeEstimateRangeGB);

    % Copyright 2025 The MathWorks, Inc.

    properties
        itemCollectionKey dictionary
        sizeEstimateRangeGB double
    end

    methods
        function obj = ItemCollectionMetrics(varargin)
            %ITEMCOLLECTIONMETRICS Construct an instance of this class
            % Constructor for TableDescription
            % Handles the creation of the TableDescription object from a Java object
            if nargin == 1
                if ~isa(varargin{1}, 'software.amazon.awssdk.services.dynamodb.model.ItemCollectionMetrics')
                    logObj = Logger.getLogger();
                    write(logObj, 'error', 'argument not of type software.amazon.awssdk.services.dynamodb.model.ItemCollectionMetrics');
                else
                    obj.Handle = varargin{1};
                    obj.sizeEstimateRangeGB = obj.Handle.sizeEstimateRangeGB();
                    obj.itemCollectionKey = obj.extractAttributes(obj.Handle.itemCollectionKey());
                end
            else
                logObj = Logger.getLogger();
                write(logObj, 'error', 'Invalid number of arguments');
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

