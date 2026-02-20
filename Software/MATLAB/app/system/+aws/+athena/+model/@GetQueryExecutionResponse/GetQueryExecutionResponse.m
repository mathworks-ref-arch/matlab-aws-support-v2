classdef GetQueryExecutionResponse < aws.Object
    %GETQUERYEXECUTIONRESPONSE MATLAB wrapper for Athena query execution metadata.
    %
    % Properties
    %   queryExecutionId   - (string) Unique identifier for the query execution.
    %   status             - (Java object) Underlying Athena status structure.
    %   state              - (string) Query state such as SUCCEEDED, FAILED, or CANCELLED.
    %   stateChangeReason  - (string) Failure detail text when available.
    %   submissionDateTime - (datetime) When the query was submitted (empty if unknown).
    %   completionDateTime - (datetime) When the query completed (empty if unknown).
    %
    % Example
    %   resp = athena.getQueryExecution(queryExecutionId="1234-abcd");
    %   disp(resp.state)

    % Copyright 2025 The MathWorks, Inc.

    properties
        queryExecutionId
        status
        state
        stateChangeReason
        submissionDateTime
        completionDateTime
    end

    methods
        function obj = GetQueryExecutionResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.athena.model.GetQueryExecutionResponse')
                obj.Handle = varargin{1};
                queryExecution = varargin{1}.queryExecution();
                obj.queryExecutionId = char(queryExecution.queryExecutionId());

                % Extract status object
                statusObj = queryExecution.status();
                if ~isempty(statusObj)
                    obj.status = statusObj; % Java object, if needed for advanced use
                    obj.state = char(statusObj.state().toString());
                    if ~isempty(statusObj.stateChangeReason())
                        obj.stateChangeReason = char(statusObj.stateChangeReason());
                    else
                        obj.stateChangeReason = '';
                    end
                    if ~isempty(statusObj.submissionDateTime())
                        obj.submissionDateTime = datetime(statusObj.submissionDateTime().toEpochMilli()/1000, 'ConvertFrom', 'posixtime');
                    else
                        obj.submissionDateTime = [];
                    end
                    if ~isempty(statusObj.completionDateTime())
                        obj.completionDateTime = datetime(statusObj.completionDateTime().toEpochMilli()/1000, 'ConvertFrom', 'posixtime');
                    else
                        obj.completionDateTime = [];
                    end
                else
                    obj.status = [];
                    obj.state = '';
                    obj.stateChangeReason = '';
                    obj.submissionDateTime = [];
                    obj.completionDateTime = [];
                end
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
