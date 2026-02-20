function deleteServiceResponse = deleteService(obj, options)
% DELETESERVICE Delete an Amazon ECS service.
%
% Syntax
%   resp = ecs.deleteService(cluster="default", service="web");
%   resp = ecs.deleteService(cluster="default", service="web", force=true);
%
% Name-Value Arguments
%   cluster - (string, required) Cluster name/ARN that hosts the service.
%   service - (string, required) Service name/ARN to delete.
%   force   - (logical) Set true to bypass scaling safeguards (default false).
%
% Returns
%   deleteServiceResponse - aws.ecs.model.ServiceResponse describing the removed service.
%
% Example
%   ecs = aws.ecs.Client();
%   resp = ecs.deleteService(cluster="default", service="web", force=true);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.cluster (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.service (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.force (1,1) logical = 0
end

write(obj.logObj, 'info', 'Deleting service in Elastic Container Service');


% Build the DeleteServiceRequest
deleteServiceRequestBuilder = software.amazon.awssdk.services.ecs.model.DeleteServiceRequest.builder();
deleteServiceRequest = aws.internal.builder.build(deleteServiceRequestBuilder, options);

% Call the deleteService method from the AWS SDK
responseJ = obj.Handle.deleteService(deleteServiceRequest);

% Wrap the Java response in a MATLAB ServiceResponse object
deleteServiceResponse = aws.ecs.model.ServiceResponse(responseJ);

end
