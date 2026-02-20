classdef GetQueueAttributesResponse < aws.Object
    % GETQUEUEATTRIBUTESRESPONSE Wrapper for queue attribute results.
    %
    % Syntax
    %   resp = aws.sqs.model.GetQueueAttributesResponse(javaResponse);
    %
    % Properties
    %   attributes - (dictionary) Map of attribute name -> string value.

    % Copyright 2025 The MathWorks, Inc.

    properties
        attributes % A dictionary to store attribute keys and values
    end

    methods
        function obj = GetQueueAttributesResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sqs.model.GetQueueAttributesResponse')
                obj.Handle = varargin{1};

                % Extract attributes from the Java response
                attributesMapJ = obj.Handle.attributesAsStrings();

                % Convert Java Map to MATLAB dictionary
                entrySetJ = attributesMapJ.entrySet();
                iteratorJ = entrySetJ.iterator();

                % Initialize the attributes dictionary
                dkeys = {};
                dvalues = {};

                while iteratorJ.hasNext()
                    entryJ = iteratorJ.next();
                    attributeKey = entryJ.getKey();
                    attributeValue = entryJ.getValue();
                    dkeys{end+1} = attributeKey;
                    dvalues{end+1} = attributeValue;
                end

                % Create the dictionary
                obj.attributes = dictionary(string(dkeys), string(dvalues));

            else
                write(obj.logObj, 'error', 'Invalid arguments');
                error('AWS:SQS:InvalidInput', 'Invalid arguments for GetQueueAttributesResponse');
            end
        end
    end
end
