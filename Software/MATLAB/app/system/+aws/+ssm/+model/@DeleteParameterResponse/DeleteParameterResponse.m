classdef DeleteParameterResponse < aws.Object
    % DELETEPARAMETERRESPONSE MATLAB wrapper for deleteParameter results.
    %
    % Syntax
    %   resp = aws.ssm.model.DeleteParameterResponse(javaResponse);
    %
    % Properties
    %   status - (string) Operation status (always "Success" for AWS SDK v2).

    % Copyright 2025 The MathWorks, Inc.

    properties
        status string
    end
    methods
        function obj = DeleteParameterResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ssm.model.DeleteParameterResponse')
                obj.Handle = varargin{1};
                obj.status = "Success"; % No fields in response
            else
                error('Input must be a software.amazon.awssdk.services.ssm.model.DeleteParameterResponse object');
            end
        end
    end
end
