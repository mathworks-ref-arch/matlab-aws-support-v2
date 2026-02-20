classdef ServiceResponse < aws.Object
    % SERVICERESPONSE MATLAB wrapper for ECS service responses.
    %
    % Syntax
    %   resp = aws.ecs.model.ServiceResponse(javaResponse);
    %
    % Properties
    %   serviceArn - (string) ARN of the service referenced in the response.

    % Copyright 2025 The MathWorks, Inc.

    properties
        serviceArn string
    end

    methods
        function obj = ServiceResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ecs.model.CreateServiceResponse')
                obj.Handle = varargin{1};
                obj.serviceArn = varargin{1}.service.serviceArn;
            elseif nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ecs.model.DeleteServiceResponse')
                obj.Handle = varargin{1};
                obj.serviceArn = varargin{1}.service.serviceArn;
            elseif nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ecs.model.UpdateServiceResponse')
                obj.Handle = varargin{1};
                obj.serviceArn = varargin{1}.service.serviceArn;
            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end
    end
end

