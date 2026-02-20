function createClusterResponse = createCluster(obj, options)
% CREATECLUSTER Create an Amazon ECS cluster.
%
% Syntax
%   resp = ecs.createCluster(clusterName="demoCluster");
%   resp = ecs.createCluster(clusterName="demoCluster", ...
%       capacityProviders=["FARGATE"], tags=dictionary("env","dev"));
%
% Name-Value Arguments
%   clusterName                     - (string, required) Friendly name for the cluster.
%   capacityProviders               - (string array) Capacity providers to associate.
%   executeCommandKmsKeyId          - (string) KMS key for ECS Exec encryption.
%   executeCommandLogConfiguration  - (struct) Pre-built ExecuteCommandLogConfiguration.
%   executeCommandLogging           - (string) Logging mode ("NONE","DEFAULT","OVERRIDE").
%   managedStorageKmsKeyId          - (string) KMS key for managed storage.
%   fargateEphemeralStorageKmsKeyId - (string) KMS key for Fargate ephemeral storage.
%   tags                            - (dictionary) Tags to attach to the cluster.
%   settings                        - (dictionary) Cluster settings (name/value pairs).
%
% Returns
%   createClusterResponse - aws.ecs.model.ClusterResponse describing the new cluster.
%
% Example
%   ecs = aws.ecs.Client('region',"us-east-1");
%   resp = ecs.createCluster(clusterName="demoCluster", ...
%       capacityProviders=["FARGATE"], tags=dictionary("env","dev"));

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.clusterName (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.capacityProviders (1,:) string {mustBeText}
    options.executeCommandKmsKeyId (1,1) string {mustBeTextScalar}
    options.executeCommandLogConfiguration struct = struct()
    options.executeCommandLogging (1,1) string {mustBeTextScalar, ...
        mustBeMember(options.executeCommandLogging, ["NONE", "DEFAULT", "OVERRIDE"])} = ["DEFAULT"]
    options.managedStorageKmsKeyId (1,1) string {mustBeTextScalar}
    options.fargateEphemeralStorageKmsKeyId (1,1) string {mustBeTextScalar}
    options.tags dictionary
    options.settings dictionary
end

write(obj.logObj, 'info', 'Creating Cluster in Elastic Container Service');

createClusterRequestBuilder = software.amazon.awssdk.services.ecs.model.CreateClusterRequest.builder();

createClusterRequestBuilder.clusterName(options.clusterName);
createClusterRequestBuilder.configuration(setClusterConfiguration(options));
if isfield(options, 'capacityProviders')
    createClusterRequestBuilder.capacityProviders(options.capacityProviders);
end
if isfield(options, 'tags')
    createClusterRequestBuilder.tags(aws.internal.builder.buildSdkObjectsFromDictionary(options.tags, ...
        'software.amazon.awssdk.services.ecs.model.Tag'));
end
if isfield(options, 'settings')
    createClusterRequestBuilder.settings(aws.internal.builder.buildSdkObjectsFromDictionary(options.settings, ...
        'software.amazon.awssdk.services.ecs.model.ClusterSetting'));
end

createClusterRequest = createClusterRequestBuilder.build();

% Call the createCluster method from the AWS SDK
responseJ = obj.Handle.createCluster(createClusterRequest);

% Wrap the Java response in a MATLAB CreateClusterResponse object
createClusterResponse = aws.ecs.model.ClusterResponse(responseJ);

end

function clusterConfig = setClusterConfiguration(options)

clusterConfigBuilder = software.amazon.awssdk.services.ecs.model.ClusterConfiguration.builder();
isEmptyClusterConfig = true;

% Set the excecute command configuration if provided
executeCommandConfigBuilder = software.amazon.awssdk.services.ecs.model.ExecuteCommandConfiguration.builder();
if isfield(options, "executeCommandKmsKeyId")
    executeCommandConfigBuilder.kmsKeyId(options.executeCommandKmsKeyId);
    isEmptyClusterConfig = false;
end
if isfield(options, "executeCommandLogging")
    executeCommandConfigBuilder.logging(options.executeCommandLogging);
    isEmptyClusterConfig = false;
end
if isfield(options, "executeCommandLogConfiguration") ...
        && ~isempty(fieldnames(options.executeCommandLogConfiguration))
    executeCommandConfigBuilder.logConfiguration(options.executeCommandLogConfiguration);
    isEmptyClusterConfig = false;
end
if ~isEmptyClusterConfig
    clusterConfigBuilder.executeCommandConfiguration(executeCommandConfigBuilder.build());
end

% Set the managed storage configuration if provided
managedStorageConfigurationBuilder = software.amazon.awssdk.services.ecs.model.ManagedStorageConfiguration.builder();
isEmptyManagedStorage = true;
if isfield(options, 'managedStorageKmsKeyId')
    managedStorageConfigurationBuilder.managedStorageKmsKeyId(options.managedStorageKmsKeyId);
    isEmptyManagedStorage = false;
end
if isfield(options, 'fargateEphemeralStorageKmsKeyId')
    managedStorageConfigurationBuilder.fargateEphemeralStorageKmsKeyId(options.fargateEphemeralStorageKmsKeyId);
    isEmptyManagedStorage = false;
end
if ~isEmptyManagedStorage
    clusterConfigBuilder.managedStorageConfiguration(managedStorageConfigurationBuilder.build());
end

clusterConfig = clusterConfigBuilder.build();

end
