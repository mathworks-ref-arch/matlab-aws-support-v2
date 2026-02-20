function deleteClusterResponse = deleteCluster(obj, options)
% DELETECLUSTER Delete an Amazon ECS cluster.
%
% Syntax
%   resp = ecs.deleteCluster(cluster="arn:aws:ecs:region:acct:cluster/demo");
%
% Name-Value Arguments
%   cluster - (string, required) Cluster name or ARN to delete (must be inactive).
%
% Returns
%   deleteClusterResponse - aws.ecs.model.ClusterResponse reflecting the removal.
%
% Example
%   ecs = aws.ecs.Client();
%   resp = ecs.deleteCluster(cluster="arn:aws:ecs:us-east-1:123456789012:cluster/demo");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.cluster (1,1) string {mustBeTextScalar, mustBeNonempty}
end

write(obj.logObj, 'info', 'Deleting cluster in Elastic Container Service');


% Build the DeleteClusterRequest
deleteClusterRequestBuilder = software.amazon.awssdk.services.ecs.model.DeleteClusterRequest.builder();
deleteClusterRequest = aws.internal.builder.build(deleteClusterRequestBuilder, options);

% Call the deleteCluster method from the AWS SDK
responseJ = obj.Handle.deleteCluster(deleteClusterRequest);

% Wrap the Java response in a MATLAB ClusterResponse object
deleteClusterResponse = aws.ecs.model.ClusterResponse(responseJ);

end
