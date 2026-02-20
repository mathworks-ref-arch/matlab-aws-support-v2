classdef PutParameterResponse < aws.Object
    % PUTPARAMETERRESPONSE MATLAB wrapper for putParameter results.
    %
    % Syntax
    %   resp = aws.ssm.model.PutParameterResponse(javaResponse);
    %
    % Properties
    %   version - (double) Version number assigned to the stored parameter.

    % Copyright 2025 The MathWorks, Inc.

    properties
        version double
    end
    methods
        function obj = PutParameterResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ssm.model.PutParameterResponse')
                obj.Handle = varargin{1};
                obj.version = double(obj.Handle.version());
            else
                error('Input must be a software.amazon.awssdk.services.ssm.model.PutParameterResponse object');
            end
        end
    end
end
