classdef PortMapping < aws.Object
    % PORTMAPPING Describe container/host port mappings for ECS tasks.
    %
    % Syntax
    %   pm = aws.ecs.model.PortMapping(containerPort=80, hostPort=8080, protocol="tcp");
    %
    % Name-Value Arguments
    %   containerPort - (double, required) Container port (1-65535).
    %   hostPort      - (double, required) Host port (1-65535).
    %   protocol      - (string) "tcp" (default) or "udp".

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = PortMapping(options)
            arguments
                options.containerPort (1,1) double {mustBePositive, mustBeLessThanOrEqual(options.containerPort, 65535)}
                options.hostPort (1,1) double {mustBePositive, mustBeLessThanOrEqual(options.hostPort, 65535)}
                options.protocol (1,1) string {mustBeMember(options.protocol, ["tcp", "udp"])} = "tcp"
            end

            initializeLogger(obj, 'Amazon:ECS:PortMapping');

            % Build the port mapping using AWS SDK
            import software.amazon.awssdk.services.ecs.model.*;
            portMappingBuilder = PortMapping.builder();
            obj.Handle = aws.internal.builder.build(portMappingBuilder, options);
        end
    end
end
