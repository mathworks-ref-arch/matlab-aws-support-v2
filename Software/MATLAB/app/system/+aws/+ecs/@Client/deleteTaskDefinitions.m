function response = deleteTaskDefinitions(obj, options)
% DELETETASKDEFINITIONS Delete one or more ECS task definition revisions.
%
% Syntax
%   resp = ecs.deleteTaskDefinitions(taskDefinitions="arn:aws:ecs:us-east-1:123:task-definition/app:7");
%   resp = ecs.deleteTaskDefinitions(taskDefinitions=["arn:...:app:7","arn:...:app:8"]);
%
% Name-Value Arguments
%   taskDefinitions - (string array, required) One or more task definition ARNs to delete.
%
% Returns
%   response - aws.ecs.model.TaskDefinitionResponse summarizing the deleted revisions.
%
% Example
%   ecs = aws.ecs.Client();
%   resp = ecs.deleteTaskDefinitions(taskDefinitions=["arn:...:frontend:3","arn:...:frontend:4"]);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.taskDefinitions (1,:) string {mustBeText, mustBeNonempty}
end

write(obj.logObj, 'info', 'Deleting task definition in Elastic Container Service');

% Build the DeleteTaskDefinitionsRequest
deleteTaskDefinitionsRequestBuilder = software.amazon.awssdk.services.ecs.model.DeleteTaskDefinitionsRequest.builder();
deleteTaskDefinitionsRequest = aws.internal.builder.build(deleteTaskDefinitionsRequestBuilder, options);

% Call the deleteTaskDefinitions method from the AWS SDK
responseJ = obj.Handle.deleteTaskDefinitions(deleteTaskDefinitionsRequest);

% Wrap the Java response in a MATLAB TaskDefinitionResponse object
response = aws.ecs.model.TaskDefinitionResponse(responseJ);

end
