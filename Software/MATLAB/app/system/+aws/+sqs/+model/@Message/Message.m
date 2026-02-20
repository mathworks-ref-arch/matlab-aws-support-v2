classdef Message < aws.Object
    % MESSAGE MATLAB wrapper for SQS messages.
    %
    % Syntax
    %   msg = aws.sqs.model.Message(javaMessage);
    %
    % Properties
    %   body           - (string) Message payload.
    %   messageId      - (string) SQS message ID.
    %   receiptHandle  - (string) Receipt handle required for delete/change visibility.
    %   attributes     - (dictionary) System attributes returned with the message.
    %   messageAttributes - (dictionary) Custom message attributes.

    % Copyright 2025 The MathWorks, Inc.


    properties
        body string
        messageId string
        receiptHandle string
        attributes dictionary = dictionary(string.empty(1,0), string.empty(1,0))
        messageAttributes dictionary = dictionary(string.empty(1,0), struct.empty(1,0))
    end

    methods
        function obj = Message(varargin)
            if nargin == 1 && isa(varargin{1}, 'software.amazon.awssdk.services.sqs.model.Message')
                obj.Handle = varargin{1};
                msg = varargin{1};
                obj.body = string(msg.body());
                obj.messageId = string(msg.messageId());
                obj.receiptHandle = string(msg.receiptHandle());
                obj.attributes = obj.mapToDictionary(msg.attributes());
                obj.messageAttributes = obj.parseMessageAttributes(msg.messageAttributes());
            else
                write(obj.logObj,'error','Invalid number of arguments');
            end
        end
    end

    methods (Access = private)
        function dictOut = mapToDictionary(~, javaMap)
            if isempty(javaMap) || javaMap.isEmpty()
                dictOut = dictionary(string.empty(1,0), string.empty(1,0));
                return
            end
            entries = javaMap.entrySet().iterator();
            keys = strings(1, javaMap.size());
            values = strings(1, javaMap.size());
            idx = 0;
            while entries.hasNext()
                entry = entries.next();
                idx = idx + 1;
                keys(idx) = string(entry.getKey());
                values(idx) = string(entry.getValue());
            end
            keys = keys(1:idx);
            values = values(1:idx);
            dictOut = dictionary(keys, values);
        end

        function dictOut = parseMessageAttributes(~, javaMap)
            if isempty(javaMap) || javaMap.isEmpty()
                dictOut = dictionary(string.empty(1,0), struct.empty(1,0));
                return
            end
            entries = javaMap.entrySet().iterator();
            keys = strings(1, javaMap.size());
            vals(1:javaMap.size()) = struct('dataType', "", 'stringValue', "", 'binaryValue', []);
            idx = 0;
            while entries.hasNext()
                entry = entries.next();
                idx = idx + 1;
                keys(idx) = string(entry.getKey());
                value = entry.getValue();
                structVal = struct();
                structVal.dataType = string(value.dataType());
                if ~isempty(value.stringValue())
                    structVal.stringValue = string(value.stringValue());
                else
                    structVal.stringValue = "";
                end
                if ~isempty(value.binaryValue())
                    structVal.binaryValue = value.binaryValue().asByteArray();
                else
                    structVal.binaryValue = [];
                end
                vals(idx) = structVal;
            end
            keys = keys(1:idx);
            vals = vals(1:idx);
            dictOut = dictionary(keys, vals);
        end
    end

end
