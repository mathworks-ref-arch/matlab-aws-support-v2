classdef ContainerDefinition < aws.Object
    % CONTAINERDEFINITION Builder for ECS container definition objects.
    %
    % Syntax
    %   def = aws.ecs.model.ContainerDefinition(name="app", image="repo:tag", ...
    %       cpu=1024, memory=2048, essential=true);
    %
    % Name-Value Arguments
    %   name             - (string, required) Container name.
    %   image            - (string, required) Container image.
    %   cpu              - (int32, required) CPU units reserved.
    %   memory           - (int32, required) Memory (MiB) reserved.
    %   essential        - (logical) Whether the container is essential.
    %   portMappings     - (vector) `aws.ecs.model.PortMapping` objects.
    %   logConfiguration - (aws.ecs.model.LogConfiguration) Log driver settings.
    %   environment      - (dictionary) Key/value environment variables.
    %
    % Example
    %   portMapping = aws.ecs.model.PortMapping(containerPort=8080, hostPort=8080, protocol="tcp");
    %   def = aws.ecs.model.ContainerDefinition(name="matlab", image="repo:tag", ...
    %       cpu=1024, memory=2048, essential=true, portMappings=portMapping);

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = ContainerDefinition(options)

            arguments
                options.name (1,1) string {mustBeNonempty}
                options.image (1,1) string {mustBeNonempty}
                options.cpu (1,1) int32 {mustBePositive}
                options.memory (1,1) int32 {mustBePositive}
                options.essential (1,1) logical
                options.portMappings (1,:) aws.ecs.model.PortMapping
                options.logConfiguration aws.ecs.model.LogConfiguration
                options.environment dictionary
            end

            initializeLogger(obj, 'Amazon:ECS:ContainerDefinition');

            % Build the container definition using AWS SDK
            import software.amazon.awssdk.services.ecs.model.*;

            % Build the container definition
            containerDefBuilder = ContainerDefinition.builder();
            containerDefBuilder.name(options.name);
            containerDefBuilder.image(options.image);
            containerDefBuilder.cpu(java.lang.Integer.valueOf(options.cpu));
            containerDefBuilder.memory(java.lang.Integer.valueOf(options.memory));
            containerDefBuilder.essential(java.lang.Boolean(options.essential));

            % Handle port mappings
            if isfield(options, "portMappings")
                portMappingsList = java.util.ArrayList();
                for index = 1:numel(options.portMappings)
                    portMappingsList.add(options.portMappings(index).Handle);
                end
                containerDefBuilder.portMappings(portMappingsList);
            end

            if isfield(options, "logConfiguration")
                containerDefBuilder.logConfiguration(options.logConfiguration.Handle);
            end
            if isfield(options, "environment")
                containerDefBuilder.environment(aws.internal.builder.buildSdkObjectsFromDictionary(options.environment, ...
                    'software.amazon.awssdk.services.ecs.model.KeyValuePair'));
            end

            obj.Handle = containerDefBuilder.build();
        end
    end
end
