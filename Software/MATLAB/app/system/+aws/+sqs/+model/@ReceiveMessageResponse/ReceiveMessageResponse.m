classdef ReceiveMessageResponse < aws.Object
    % RECEIVEMESSAGERESPONSE MATLAB wrapper for ReceiveMessage results.
    %
    % Syntax
    %   resp = aws.sqs.model.ReceiveMessageResponse(javaResponse);
    %
    % Properties
    %   messages - (1xN cell) Each entry is an `aws.sqs.model.Message` instance.

    % Copyright 2025 The MathWorks, Inc.

    properties
        messages
    end

    methods
        function obj = ReceiveMessageResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sqs.model.ReceiveMessageResponse')
                obj.Handle = varargin{1};

                % Extract messages from the Java response
                messagesListJ = obj.Handle.messages();
                messagesListIterator = messagesListJ.iterator;
                obj.messages = {};

                while messagesListIterator.hasNext()
                    messageJ = messagesListIterator.next();
                    messageObj = aws.sqs.model.Message(messageJ);
                    obj.messages{end+1} = messageObj;
                end

            else
                write(obj.logObj, 'error', 'Invalid arguments');
                error('AWS:SQS:InvalidInput', 'Invalid arguments for ReceiveMessageResponse');
            end
        end
    end
end
