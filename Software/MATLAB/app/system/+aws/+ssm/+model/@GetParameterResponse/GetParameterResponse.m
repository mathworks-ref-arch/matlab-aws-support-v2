classdef GetParameterResponse < aws.Object
    % GETPARAMETERRESPONSE MATLAB wrapper for getParameter results.
    %
    % Syntax
    %   resp = aws.ssm.model.GetParameterResponse(javaResponse);
    %
    % Properties
    %   name    - (string) Parameter name.
    %   arn     - (string) Amazon Resource Name for the parameter.
    %   type    - (string) Parameter type ("String", "StringList", "SecureString").
    %   value   - (string) Parameter value (decrypted when requested).
    %   version - (double) Version number of the returned value.

    % Copyright 2025 The MathWorks, Inc.

    properties
        name string
        arn string
        type string
        value string
        version double
    end
    methods
        function obj = GetParameterResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ssm.model.GetParameterResponse')
                obj.Handle = varargin{1};
                paramJ = obj.Handle.parameter();
                if ~isempty(paramJ)
                    obj.name = string(paramJ.name());
                    obj.arn = string(paramJ.arn());
                    obj.type = string(paramJ.typeAsString());
                    obj.value = string(paramJ.value());
                    obj.version = double(paramJ.version());
                else
                    obj.name = string.empty;
                    obj.arn = string.empty;
                    obj.type = string.empty;
                    obj.value = string.empty;
                    obj.version = double.empty;
                end
            else
                error('Input must be a software.amazon.awssdk.services.ssm.model.GetParameterResponse object');
            end
        end
    end
end
