function response = deregisterTaskDefinition(obj, options)
% DEREGISTERTASKDEFINITION Mark a task definition revision as INACTIVE.
%
% Syntax
%   resp = ecs.deregisterTaskDefinition(taskDefinition="arn:aws:ecs:...:task-definition/app:2");
%
% Name-Value Arguments
%   taskDefinition - (string, required) Task definition ARN or family:revision to deregister.
%
% Returns
%   response - aws.ecs.model.TaskDefinitionResponse describing the inactive revision.
%
% Example
%   ecs = aws.ecs.Client();
%   resp = ecs.deregisterTaskDefinition(taskDefinition="app:2");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.taskDefinition (1,1) string {mustBeTextScalar, mustBeNonempty}
end

write(obj.logObj, 'info', 'Deleting task definition in Elastic Container Service');

% Build the DeregisterTaskDefinitionRequest
deregisterTaskDefinitionRequestBuilder = software.amazon.awssdk.services.ecs.model.DeregisterTaskDefinitionRequest.builder();
deregisterTaskDefinitionRequest = aws.internal.builder.build(deregisterTaskDefinitionRequestBuilder, options);

% Call the deregisterTaskDefinition method from the AWS SDK
responseJ = obj.Handle.deregisterTaskDefinition(deregisterTaskDefinitionRequest);

% Wrap the Java response in a MATLAB TaskDefinitionResponse object
response = aws.ecs.model.TaskDefinitionResponse(responseJ);

end

