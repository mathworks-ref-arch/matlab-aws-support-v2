function registerTaskDefinitionResponse = registerTaskDefinition(obj, options)
% REGISTERTASKDEFINITION Register a new ECS task definition revision.
%
% Syntax
%   resp = ecs.registerTaskDefinition(family="web", taskRoleArn=taskRole, ...
%       executionRoleArn=execRole, networkMode="awsvpc", ...
%       containerDefinitions=[containerDef], requiresCompatibilities="FARGATE", ...
%       cpu="1024", memory="2048");
%
% Name-Value Arguments
%   family                 - (string, required) Task definition family name.
%   taskRoleArn            - (string, required) IAM role ARN assumed by the task.
%   executionRoleArn       - (string, required) IAM role ARN used by ECS agent.
%   networkMode            - (string, required) Networking mode ("AWSVPC","BRIDGE","HOST","NONE").
%   containerDefinitions   - (array, required) `aws.ecs.model.ContainerDefinition` objects.
%   requiresCompatibilitiesWithStrings- (string array) Launch types supported ("FARGATE","EC2","EXTERNAL").
%   cpu                    - (string, required) CPU units (for example `"1024"`).
%   memory                 - (string, required) Memory in MiB (for example `"2048"`).
%
% Returns
%   registerTaskDefinitionResponse - aws.ecs.model.TaskDefinitionResponse containing the new revision.
%
% Example
%   ecs = aws.ecs.Client();
%   resp = ecs.registerTaskDefinition(family="web", taskRoleArn=taskRole, ...
%       executionRoleArn=execRole, networkMode="awsvpc", ...
%       containerDefinitions=[containerDef], requiresCompatibilitiesWithStrings=["FARGATE"], ...
%       cpu="1024", memory="2048");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.family (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.taskRoleArn (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.executionRoleArn (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.networkMode (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.containerDefinitions (1,:)
    options.requiresCompatibilitiesWithStrings (1,:) string {mustBeMember( ...
        options.requiresCompatibilitiesWithStrings, ...
        ["FARGATE", "EC2", "EXTERNAL", "UNKNOWN_TO_SDK_VERSION"])} = ["FARGATE"]
    options.cpu (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.memory (1,1) string {mustBeTextScalar, mustBeNonempty}
end

write(obj.logObj, 'info', 'Registering Task Definition in Elastic Container Service');

% Build the RegisterTaskDefinitionRequest
registerTaskDefinitionRequestBuilder = software.amazon.awssdk.services.ecs.model.RegisterTaskDefinitionRequest.builder();
registerTaskDefinitionRequest = aws.internal.builder.build(registerTaskDefinitionRequestBuilder, options);

% Call the registerTaskDefinition method from the AWS SDK
responseJ = obj.Handle.registerTaskDefinition(registerTaskDefinitionRequest);

% Wrap the Java response in a MATLAB RegisterTaskDefinitionResponse object
registerTaskDefinitionResponse = aws.ecs.model.TaskDefinitionResponse(responseJ);

end