classdef RegisterTaskDefinitionRequest < aws.Object
    % REGISTERTASKDEFINITIONREQUEST Wrapper for SDK RegisterTaskDefinitionRequest.
    %
    % Syntax
    %   req = aws.ecs.model.RegisterTaskDefinitionRequest(structArgs);
    %   req = aws.ecs.model.RegisterTaskDefinitionRequest(sdkRequest);

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = RegisterTaskDefinitionRequest(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ecs.model.RegisterTaskDefinitionRequest')
                obj.Handle = varargin{1};

            elseif nargin == 1 && isstruct(varargin{1})

                taskDefinitionBuilder = software.amazon.awssdk.services.ecs.model.RegisterTaskDefinitionRequest.builder();
                obj.Handle = aws.internal.builder.build(taskDefinitionBuilder, varargin{1});

            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end
    end
end

