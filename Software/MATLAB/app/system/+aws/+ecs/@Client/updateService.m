function updateServiceResponse = updateService(obj, options)
% UPDATESERVICE Update configuration for an existing ECS service.
%
% Syntax
%   resp = ecs.updateService(cluster="default", serviceName="web", desiredCount=2);
%   resp = ecs.updateService(cluster="default", serviceName="web", ...
%       taskDefinition="myTaskDef:2", loadBalancers=[lbObj]);
%
% Name-Value Arguments
%   cluster        - (string, required) Cluster hosting the service.
%   serviceName    - (string, required) Service name/ARN to update.
%   taskDefinition - (string) New task definition revision to deploy.
%   desiredCount   - (double) New desired task count.
%   loadBalancers  - (vector) Updated `aws.ecs.model.LoadBalancers` definitions.
%
% Returns
%   updateServiceResponse - aws.ecs.model.ServiceResponse reflecting the updated service.
%
% Example
%   ecs = aws.ecs.Client();
%   resp = ecs.updateService(cluster="default", serviceName="web", desiredCount=3);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.cluster (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.serviceName (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.taskDefinition (1,1) string {mustBeTextScalar}
    options.desiredCount (1,1) double {mustBeInteger, mustBeNonnegative} = 1
    options.loadBalancers (1,:) aws.ecs.model.LoadBalancers
end

write(obj.logObj, 'info', 'Updating Service in Elastic Container Service');

% Build the Update Service Request
updateServiceRequestBuilder = software.amazon.awssdk.services.ecs.model.UpdateServiceRequest.builder();
updateServiceRequestBuilder.cluster(options.cluster);
updateServiceRequestBuilder.service(options.serviceName);

% Set optional parameters
if options.taskDefinition ~= ""
    updateServiceRequestBuilder.taskDefinition(options.taskDefinition);
end
updateServiceRequestBuilder.desiredCount(java.lang.Integer.valueOf(options.desiredCount));

% Handle optional load balancers
if isfield(options, "loadBalancers") && ~isempty(options.loadBalancers)
    numObjects = numel(options.loadBalancers);
    javaLBArray = javaArray('software.amazon.awssdk.services.ecs.model.LoadBalancer', numObjects);
    for index = 1:numObjects
        javaLBArray(index) = options.loadBalancers{index}.Handle;
    end
    updateServiceRequestBuilder.loadBalancers(javaLBArray);
end

% Build the request
updateServiceRequest = updateServiceRequestBuilder.build();

% Call the updateService method from the AWS SDK
responseJ = obj.Handle.updateService(updateServiceRequest);

% Wrap the Java response in a MATLAB UpdateServiceResponse object
updateServiceResponse = aws.ecs.model.ServiceResponse(responseJ);

end