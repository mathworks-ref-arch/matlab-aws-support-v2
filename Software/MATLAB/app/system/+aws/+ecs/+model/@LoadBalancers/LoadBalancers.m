classdef LoadBalancers < aws.Object
    % LOADBALANCERS Helper to describe service load balancer attachments.
    %
    % Syntax
    %   lb = aws.ecs.model.LoadBalancers(loadBalancerName="alb", ...
    %       containerName="web", containerPort=80);
    %
    % Name-Value Arguments
    %   loadBalancerName - (string) Classic/ALB name.
    %   targetGroupArn   - (string) Target group ARN for ALB/NLB.
    %   containerName    - (string) Container to route traffic to.
    %   containerPort    - (double) Port exposed on the container.

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = LoadBalancers(options)
            arguments                
                options.loadBalancerName (1,1) string {mustBeTextScalar, mustBeNonempty}
                options.containerName (1,1) string {mustBeTextScalar}
                options.containerPort (1,1) int32 {mustBeInteger, mustBeNonnegative}
                options.targetGroupArn (1,1) string {mustBeTextScalar}
            end

            initializeLogger(obj, 'Amazon:ECS:LoadBalancers');

                loadBalancerBuilder = software.amazon.awssdk.services.ecs.model.LoadBalancer.builder();
                obj.Handle = aws.internal.builder.build(loadBalancerBuilder, options);
        end
    end
end
