classdef SendMessageResponse < aws.Object
    % SENDMESSAGERESPONSE MATLAB wrapper for SendMessage results.
    %
    % Syntax
    %   resp = aws.sqs.model.SendMessageResponse(javaResponse);
    %
    % Properties
    %   messageId             - (string) Identifier assigned by SQS.
    %   md5OfMessageBody      - (string) MD5 digest of the message body.
    %   md5OfMessageAttributes - (string) MD5 digest of message attributes (when provided).
    %   sequenceNumber        - (string) Sequence number for FIFO queues.

    % Copyright 2025 The MathWorks, Inc.

    properties
        messageId string
        md5OfMessageBody string
        md5OfMessageAttributes string
        sequenceNumber string
    end

    methods
        function obj = SendMessageResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sqs.model.SendMessageResponse')
                obj.Handle = varargin{1};
                obj.messageId = string(varargin{1}.messageId());
                obj.md5OfMessageBody = string(varargin{1}.md5OfMessageBody());
                obj.md5OfMessageAttributes = string(varargin{1}.md5OfMessageAttributes());
                obj.sequenceNumber = string(varargin{1}.sequenceNumber());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
