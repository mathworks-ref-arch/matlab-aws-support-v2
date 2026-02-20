classdef StartQueryExecutionResponse < aws.Object
    %STARTQUERYEXECUTIONRESPONSE MATLAB wrapper for Athena StartQueryExecution output.
    %
    % Properties
    %   queryExecutionId - (string) Query identifier assigned by Athena.
    %
    % Example
    %   resp = athena.startQueryExecution(queryString="SELECT 1", resultConfiguration=rc);
    %   disp(resp.queryExecutionId)
    
    % Copyright 2025 The MathWorks, Inc.

    properties
        queryExecutionId
    end

    methods
        function obj = StartQueryExecutionResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.athena.model.StartQueryExecutionResponse')
                obj.Handle = varargin{1};
                obj.queryExecutionId = char(varargin{1}.queryExecutionId());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
