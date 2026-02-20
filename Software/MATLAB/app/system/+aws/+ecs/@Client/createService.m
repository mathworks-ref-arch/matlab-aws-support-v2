function createServiceResponse = createService(obj, options)
% CREATESERVICE Create an Amazon ECS service.
%
% Syntax
%   resp = ecs.createService(cluster="default", serviceName="web", ...
%       taskDefinition="myTaskDef");
%   resp = ecs.createService(cluster="default", serviceName="web", ...
%       taskDefinition="myTaskDef", launchType="FARGATE", ...
%       subnets=["subnet-1","subnet-2"], securityGroups=["sg-123"], ...
%       desiredCount=2, assignPublicIp="ENABLED");
%
% Name-Value Arguments
%   cluster        - (string, required) Cluster name/ARN that owns the service.
%   serviceName    - (string, required) Friendly name for the service.
%   taskDefinition - (string, required) Task definition family:revision or ARN.
%   launchType     - (string) Launch type ("FARGATE", "EC2", or "EXTERNAL"). Default "FARGATE".
%   desiredCount   - (double) Desired task count. When omitted, the existing value is preserved.
%   subnets        - (string array) Subnet IDs for awsvpc networking.
%   securityGroups - (string array) Security groups for awsvpc networking.
%   assignPublicIp - (string) "ENABLED" or "DISABLED" for awsvpc tasks.
%   loadBalancers  - (vector) Array of `aws.ecs.model.LoadBalancers` objects.
%
% Returns
%   createServiceResponse - aws.ecs.model.ServiceResponse describing the service.
%
% Example
%   ecs = aws.ecs.Client('region',"us-east-1");
%   resp = ecs.createService(cluster="default", serviceName="web", ...
%       taskDefinition="myTaskDef", subnets=["subnet-1"], ...
%       securityGroups=["sg-123"]);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.cluster (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.serviceName (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.taskDefinition (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.launchType (1,1) string {mustBeTextScalar, mustBeMember(options.launchType, ...
        ["FARGATE", "EC2", "EXTERNAL", "UNKNOWN_TO_SDK_VERSION"])} = "FARGATE";
    options.desiredCount (1,1) double {mustBeInteger, mustBeNonnegative} = 1
    options.subnets (1,:) string {mustBeText}
    options.securityGroups (1,:) string {mustBeText}
    options.loadBalancers (1,:) aws.ecs.model.LoadBalancers {mustBeVector}
    options.assignPublicIp (1,1) string {mustBeTextScalar} = "DISABLED"
end

write(obj.logObj, 'info', 'Creating Service in Elastic Container Service');

% Build the AWS VPC Configuration
awsvpcConfigBuilder = software.amazon.awssdk.services.ecs.model.AwsVpcConfiguration.builder();
awsvpcConfigBuilder.subnets(options.subnets);
awsvpcConfigBuilder.securityGroups(options.securityGroups);
awsvpcConfigBuilder.assignPublicIp(options.assignPublicIp);
vpcConfiguration = awsvpcConfigBuilder.build();

% Build the Network Configuration
networkConfigBuilder = software.amazon.awssdk.services.ecs.model.NetworkConfiguration.builder();
networkConfigBuilder.awsvpcConfiguration(vpcConfiguration);
networkConfiguration = networkConfigBuilder.build();

% Build the Create Service Request
createServiceRequestBuilder = software.amazon.awssdk.services.ecs.model.CreateServiceRequest.builder();
createServiceRequestBuilder.cluster(options.cluster);
createServiceRequestBuilder.serviceName(options.serviceName);
createServiceRequestBuilder.taskDefinition(options.taskDefinition);
createServiceRequestBuilder.launchType(software.amazon.awssdk.services.ecs.model.LaunchType.valueOf(char(options.launchType)));
createServiceRequestBuilder.desiredCount(java.lang.Integer.valueOf(options.desiredCount));
createServiceRequestBuilder.networkConfiguration(networkConfiguration);

% Handle optional load balancers
if isfield(options, "loadBalancers") && ~isempty(options.loadBalancers)
    numObjects = numel(options.loadBalancers);
    javaLBArray = javaArray('software.amazon.awssdk.services.ecs.model.LoadBalancer', numObjects);
    % If Array has only single member, MATLAB treats it like a single
    % object and invoking the index will fail. If single object,
    % directly assign otherwise use iteration.
    if numObjects > 1
        for index = 1:numObjects
            javaLBArray(index) = options.loadBalancers(index).Handle;
        end
    else
        javaLBArray(1) = options.loadBalancers.Handle;
    end
    createServiceRequestBuilder.loadBalancers(javaLBArray);
end

% Build the request
createServiceRequest = createServiceRequestBuilder.build();

% Call the createService method from the AWS SDK
responseJ = obj.Handle.createService(createServiceRequest);

% Wrap the Java response in a MATLAB CreateServiceResponse object
createServiceResponse = aws.ecs.model.ServiceResponse(responseJ);

end
