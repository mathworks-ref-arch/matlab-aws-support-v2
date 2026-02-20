classdef DynamoDbWaiter < aws.Object
    %DYNAMODBWAITER MATLAB wrapper for AWS DynamoDB waiter utilities.
    %
    % Syntax
    %   w = aws.dynamodb.waiters.DynamoDbWaiter(javaWaiter);
    %
    % Name-Value / Positional Arguments
    %   javaWaiter - (software.amazon.awssdk.services.dynamodb.waiters.DynamoDbWaiter)
    %                Existing SDK waiter instance.
    %
    % Example
    %   ddb    = aws.dynamodb.Client();
    %   waiter = ddb.getWaiter();

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = DynamoDbWaiter(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.dynamodb.waiters.DynamoDbWaiter')
                obj.Handle = varargin{1};

            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end
    end
end