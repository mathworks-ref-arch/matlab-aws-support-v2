classdef TaskDefinitionResponse < aws.Object
    % TASKDEFINITIONRESPONSE MATLAB wrapper for ECS task definition responses.
    %
    % Syntax
    %   resp = aws.ecs.model.TaskDefinitionResponse(javaResponse);
    %
    % Properties
    %   taskDefinitionArn - (string or cell array) ARN(s) referenced in the response.

    % Copyright 2025 The MathWorks, Inc.

    properties
        taskDefinitionArn string
    end

    methods
        function obj = TaskDefinitionResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ecs.model.RegisterTaskDefinitionResponse')
                obj.Handle = varargin{1};
                obj.taskDefinitionArn = varargin{1}.taskDefinition.taskDefinitionArn;
            elseif nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ecs.model.DeregisterTaskDefinitionResponse')
                obj.Handle = varargin{1};
                obj.taskDefinitionArn = varargin{1}.taskDefinition.taskDefinitionArn;
            elseif nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ecs.model.DeleteTaskDefinitionsResponse')
                obj.Handle = varargin{1};
                taskDefinitionsArray = varargin{1}.taskDefinitions.toArray();
                obj.taskDefinitionArn = arrayfun(@(td) td.taskDefinitionArn, ...
                    taskDefinitionsArray, 'UniformOutput', false);
            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end
    end
end

