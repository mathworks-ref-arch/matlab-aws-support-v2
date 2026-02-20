classdef StopQueryExecutionResponse < aws.Object
    %STOPQUERYEXECUTIONRESPONSE MATLAB wrapper for Athena stop query response.
    %
    % Properties
    %   statusCode - (double) HTTP status code reported by the SDK.
    %   requestId  - (string) AWS request identifier useful for support cases.
    %
    % Example
    %   resp = athena.stopQueryExecution(queryExecutionId="...");
    %   disp(resp.statusCode)
    
    % Copyright 2025 The MathWorks, Inc.

    properties
        statusCode
        requestId
    end

    methods
        function obj = StopQueryExecutionResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.athena.model.StopQueryExecutionResponse')
                obj.Handle = varargin{1};
                % HTTP status code (int)
                obj.statusCode = varargin{1}.sdkHttpResponse().statusCode();
                % Request ID (string)
                obj.requestId = char(varargin{1}.responseMetadata().requestId());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
