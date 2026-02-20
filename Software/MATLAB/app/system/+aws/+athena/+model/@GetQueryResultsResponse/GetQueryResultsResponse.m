classdef GetQueryResultsResponse < aws.Object
    %GETQUERYRESULTSRESPONSE MATLAB wrapper for Athena GetQueryResults output.
    %
    % Properties
    %   resultSet - (software.amazon.awssdk.services.athena.model.ResultSet) Raw result set payload.
    %   nextToken - (char) Pagination token returned by Athena (empty if final page).
    %   updateCount - (double) Number of rows updated, when applicable.
    %
    % Example
    %   resp = athena.getQueryResults(queryExecutionId="1234-abcd");
    %   rows = resp.resultSet.rows();

    % Copyright 2025 The MathWorks, Inc.

    properties
        resultSet
        nextToken
        updateCount
    end

    methods
        function obj = GetQueryResultsResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.athena.model.GetQueryResultsResponse')
                obj.Handle = varargin{1};
                obj.resultSet = varargin{1}.resultSet();
                obj.nextToken = varargin{1}.nextToken();
                obj.updateCount = varargin{1}.updateCount();
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
