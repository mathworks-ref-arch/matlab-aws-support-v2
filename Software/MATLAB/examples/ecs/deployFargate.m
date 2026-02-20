function result = deployFargate(varargin)
% DEPLOYFARGATE Deploys a Docker container to AWS Fargate using ECS.
% This function registers an ECS Task Definition, creates an ECS Cluster,
% and sets up an ECS Service. Task definition configurations are read from
% 'config/taskDefinitionConfig.json'. DEPLOYFARGATE Prerequisites,
%
% To successfully deploy a MATLAB Microservice to AWS Fargate using the deployFargate
% function, ensure the following AWS resources and configurations are set up:
%
% AWS Resources:
% 1. Elastic Container Registry (ECR)
%    - Create an ECR repository (e.g., 'matlab-ecs-ecr').
%    - Provide appropriate Permissions to the repository for ecsTaskExecutionRole
%
% 2. Elastic Container Service (ECS)
%    - Define an ECS Task Definition with necessary configurations in
%       'config/taskDefinitionConfig.json'.
%    - Define other paramters of ECS Service and Cluster in the below
%    function.
%
% 3. Networking
%    - Subnets: Ensure at least two subnets (public/private) in the same VPC.
%    - Security Groups (SG): Configure SGs to allow inbound/outbound traffic.
%      - Allow port 9910 traffic for ALB.
%
% 4. Application Load Balancer (ALB)
%    - Create an ALB with at least two subnets.
%    - Set up listeners and rules for traffic routing.
%
% 5. Target Group (TG)
%    - Create a target group to register ECS tasks.
%    - Configure health checks to point to /api/health.
%
% 6. Cloud Watch
%    -  Set up CloudWatch logs for ECS tasks and ALB access logs as required.
%    -  Configure logsDriver and awslogs-group in AWS Cloud Watch,
%    these values are provided in the ECS taskDefinitionConfig.json.
%
% IAM Roles and Policies:
% 1. ECS Task Execution Role includes following Policies. You can
% create and attach as appropriate
%    - Attach 'AmazonECSTaskExecutionRolePolicy' and 'AmazonEC2ContainerRegistryReadOnly'.
%    - Add custom policy for 'ecr:BatchGetImage' and 'ecr:GetDownloadUrlForLayer'.
%
% 2. ECS Task Role
%    - Define an ecsTaskExecutionRole for ECS task to access AWS
%    services that is accessed from within the microservice.
%
% 3. IAM Policies for Deployment
%    - ecsTaskExecutionRole with AmazonECSTaskExecutionRolePolicy and
%    other service specific policies required. e.g. BedrockInvokeFoundationModel
%
% Additional Considerations:
% - Ensure all components are within the same VPC.
% - Configure route tables and internet gateway for public subnets.
% - Set up CloudWatch logs for ECS tasks and ALB access logs.

% Copyright 2025 The MathWorks, Inc.

% Load Fargate configurations
fargateConfigData = loadConfigurationSettings('deployFargateConfig.json');

% Build MATLAB Microservice Image
ecrImageUri = buildECRImage(fargateConfigData);

% Load ECS Task Definition configurations
taskDefinition = loadConfigurationSettings('taskDefinitionConfig.json');

% Deploy MATLAB Algorithm to AWS ECS-Fargate
result = deployECS(fargateConfigData, taskDefinition, ecrImageUri);


end

function ecrImageUri = buildECRImage(fargateConfigData)

awsRegion = fargateConfigData.awsRegion;
functionNames = fargateConfigData.functionNames;
archiveName = fargateConfigData.archiveName;
ecrRepositoryName = fargateConfigData.ecrRepositoryName;

accountId = aws.sts.Client('region', awsRegion).getCallerIdentity().accountId;
imageName = lower(archiveName);

% MATLAB Algorithm (A Bedrock example) with dependent AWS interface
matlabFolder = fileparts(fileparts(fileparts(mfilename('fullpath'))));

functionFiles = cellfun(@(f) fullfile(fileparts(mfilename('fullpath')), f), functionNames, 'UniformOutput', false);
libFolder = fullfile(matlabFolder, 'lib');
configFolder = fullfile(matlabFolder, 'config');

libFiles = dir(fullfile(libFolder, '**', '*.*'));
libFiles = libFiles(~[libFiles.isdir]);

configFiles = dir(fullfile(configFolder, '**', '*.*'));
configFiles = configFiles(~[configFiles.isdir]);

additionalFiles = [fullfile({libFiles.folder}, {libFiles.name}), ...
    fullfile({configFiles.folder}, {configFiles.name})];

opts = compiler.build.ProductionServerArchiveOptions(functionFiles);
opts.Verbose = 'on';
opts.ArchiveName = archiveName;
opts.AdditionalFiles = additionalFiles;
results = compiler.build.productionServerArchive(opts);
compiler.package.microserviceDockerImage(results, "ImageName", imageName);

ecrImageUri = sprintf('%s.dkr.ecr.%s.amazonaws.com/%s:latest', accountId, ...
    awsRegion, ecrRepositoryName);

%Authenticate Docker with AWS ECR
dockerAuth = sprintf(['aws ecr get-login-password --region %s | ' ...
    'docker login --username AWS --password-stdin %s'], awsRegion, ecrImageUri);
status = system(dockerAuth);
if status ~= 0
    error('Failed to authenticate Docker with AWS ECR.');
end

% Push the Docker image to ECR
system(sprintf('docker tag %s:latest %s', imageName, ecrImageUri));
system(sprintf('docker push %s', ecrImageUri));
end

function clusterArn = createECSCluster(ecs, fargateConfigData)
% Create ECS Cluster
ecsClusterName = strcat(fargateConfigData.ecsClusterName, matlabRelease.Release);
clusterResponse = ecs.createCluster(clusterName=ecsClusterName);
clusterArn = clusterResponse.clusterArn;
end

function taskDefinitionArn = registerECSTaskDefinition(taskDefinition, ecrImageUri, ecs)
containerDef = taskDefinition.containerDefinitions(1); % Assuming a single container
% Create Port Mapping
ports = containerDef.portMappings(1); % Assuming a single port mapping
portMappings = [aws.ecs.model.PortMapping(containerPort= ports.containerPort, ...
    hostPort= ports.hostPort, ...
    protocol= ports.protocol)];

% Extract environment variables and create a MATLAB dictionary
envArray = containerDef.environment;
envKeys = arrayfun(@(e) e.name, envArray, 'UniformOutput', false);
envValues = arrayfun(@(e) e.value, envArray, 'UniformOutput', false);
environment = dictionary(envKeys, envValues);

% Create Log Configuration object
logConfiguration = aws.ecs.model.LogConfiguration(logDriver=containerDef.logConfiguration.logDriver, ...
    options=dictionary(fieldnames(containerDef.logConfiguration.options), ...
    struct2cell(containerDef.logConfiguration.options)));

% Create container definition object
container = [aws.ecs.model.ContainerDefinition(name= containerDef.name, ...
    image= ecrImageUri, ...
    memory= containerDef.memory, ...
    cpu= containerDef.cpu, ...
    essential= containerDef.essential, ...
    portMappings= portMappings, ...
    logConfiguration= logConfiguration, ...
    environment= environment)];

taskDefinitionResponse = ecs.registerTaskDefinition(...
    family= taskDefinition.family, ...
    taskRoleArn= taskDefinition.taskRoleArn, ...
    executionRoleArn= taskDefinition.executionRoleArn, ...
    networkMode= taskDefinition.networkMode, ...
    containerDefinitions= container, ...
    requiresCompatibilities= [string(taskDefinition.requiresCompatibilities{1})], ... % Use the first compatibility
    cpu= taskDefinition.cpu, ...
    memory= taskDefinition.memory);

taskDefinitionArn = taskDefinitionResponse.taskDefinitionArn;
end

function serviceArn = createECSService(fargateConfigData, taskDefinition, clusterArn, taskDefinitionArn, ecs)

subnets = fargateConfigData.subnets;
securityGroups = fargateConfigData.securityGroups;
loadBalancerContainerPort = fargateConfigData.loadBalancerContainerPort;
targetGroupArn = fargateConfigData.targetGroupArn;

ecsAssignPublicIp = fargateConfigData.ecsAssignPublicIp;

ecsServiceName = strcat(fargateConfigData.ecsServiceName, matlabRelease.Release);

% Use target group name instead pf  Application Load Balancer Name as it
% assumes it to be a Classical Load Balancer
loadBalancer = aws.ecs.model.LoadBalancers(targetGroupArn= targetGroupArn, ...
    containerName= taskDefinition.containerDefinitions(1).name, ... % Assuming a single container
    containerPort= loadBalancerContainerPort);
loadBalancers = [loadBalancer];

createServiceResponse = ecs.createService(cluster= clusterArn, ...
    serviceName= ecsServiceName, ...
    taskDefinition= taskDefinitionArn, ...
    loadBalancers= loadBalancers, ...
    launchType= "FARGATE", ...
    desiredCount= 2, ...
    subnets= subnets, ...
    securityGroups= securityGroups, ...
    assignPublicIp= ecsAssignPublicIp);

serviceArn = createServiceResponse.serviceArn;

end

function result = deployECS(fargateConfigData, taskDefinition, ecrImageUri)
ecs = aws.ecs.Client('region', fargateConfigData.awsRegion);

clusterArn = createECSCluster(ecs, fargateConfigData);

taskDefinitionArn = registerECSTaskDefinition(taskDefinition, ecrImageUri, ecs);

serviceArn = createECSService(fargateConfigData, taskDefinition, clusterArn, taskDefinitionArn, ecs);

% Output the result
result = struct();
result.ClusterArn = clusterArn;
result.ServiceArn = serviceArn;
result.TaskDefinitionArn = taskDefinitionArn;
result.EcrImageUri = ecrImageUri;

disp('Deployment to AWS Fargate completed successfully.');
disp('MATLAB ECS Fargate Endpoint URL');
disp('-------------------------------');
albDNS = sprintf('%s-%s.%s.elb.amazonaws.com', 'ALB_NAME', 'ACCOUNT_ID', fargateConfigData.awsRegion);
arrayfun(@(fn) fprintf('Function %s: http://%s:%d/%s/%s\n', fn{1}(1:end-2), albDNS, ...
    fargateConfigData.loadBalancerContainerPort, fargateConfigData.archiveName, ...
    fn{1}(1:end-2)), fargateConfigData.functionNames);

end