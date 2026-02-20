## ☁️ 6.4 ECS

MATLAB client for Amazon Elastic Container Service (ECS). Create clusters and services, register task definitions, and manage deployments.

```matlab
ecs = aws.ecs.Client('region', 'us-east-1');
```

### 🔧 6.4.1 List of Available Methods

- [createCluster](AWSSDKAPI.md#awsecsclientcreatecluster)  
- [deleteCluster](AWSSDKAPI.md#awsecsclientdeletecluster)  
- [createService](AWSSDKAPI.md#awsecsclientcreateservice)  
- [updateService](AWSSDKAPI.md#awsecsclientupdateservice)  
- [deleteService](AWSSDKAPI.md#awsecsclientdeleteservice)  
- [registerTaskDefinition](AWSSDKAPI.md#awsecsclientregistertaskdefinition)  
- [deregisterTaskDefinition](AWSSDKAPI.md#awsecsclientderegistertaskdefinition)  
- [deleteTaskDefinitions](AWSSDKAPI.md#awsecsclientdeletetaskdefinitions)

### 🧩 6.4.2 Examples

Create a cluster and a Fargate service (simplified)
```matlab
ecs = aws.ecs.Client('region', 'us-east-1');
ecs.createCluster(clusterName="matlab-demo-cluster");

ecs.createService( ...
    cluster="matlab-demo-cluster", ...
    serviceName="matlab-demo-service", ...
    taskDefinition="<task-def-arn>", ...
    desiredCount=1, ...
    launchType="FARGATE");
```

### 📘 6.4.3 Method Reference (Summary)

#### 🔸 `createCluster`
```matlab
cr = ecs.createCluster(clusterName="<name>");
```
*   Returns: `aws.ecs.model.ClusterResponse`

#### 🔸 `deleteCluster`
```matlab
dr = ecs.deleteCluster(cluster="<cluster-arn-or-name>");
```
*   Returns: `aws.ecs.model.ClusterResponse`

#### 🔸 `createService`
```matlab
cs = ecs.createService(cluster="<name>", serviceName="<name>", taskDefinition="<arn>", desiredCount=1, launchType="FARGATE");
```
*   Returns: `aws.ecs.model.ServiceResponse`

#### 🔸 `updateService`
```matlab
us = ecs.updateService(cluster="<name>", serviceName="<name>", desiredCount=2);
```
*   Returns: `aws.ecs.model.ServiceResponse`

#### 🔸 `deleteService`
```matlab
ds = ecs.deleteService(cluster="<name>", service="<arn>", force=true);
```
*   Returns: `aws.ecs.model.ServiceResponse`

#### 🔸 `registerTaskDefinition`
```matlab
rt = ecs.registerTaskDefinition(...);
```
*   Returns: `aws.ecs.model.TaskDefinitionResponse`

#### 🔸 `deregisterTaskDefinition`
```matlab
dg = ecs.deregisterTaskDefinition(taskDefinition="<arn>");
```
*   Returns: `aws.ecs.model.TaskDefinitionResponse`

#### 🔸 `deleteTaskDefinitions`
```matlab
dt = ecs.deleteTaskDefinitions(taskDefinitions=["<arn>", "<arn2>"]);
```
*   Returns: `aws.ecs.model.TaskDefinitionResponse`

```{seealso}
🔗 Data Models: ClusterResponse, ServiceResponse, TaskDefinitionResponse, AwsVpcConfiguration, LoadBalancers, NetworkConfiguration
```
