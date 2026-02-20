classdef ProvisionedThroughput < aws.Object
    % PROVISIONEDTHROUGHPUT Builder for table/index throughput settings.
    %
    % Syntax
    %   pt = aws.dynamodb.model.ProvisionedThroughput( ...
    %       readCapacityUnits=int64(5), writeCapacityUnits=int64(5));
    %
    % Name-Value Arguments
    %   readCapacityUnits  - (int64, required) Provisioned read capacity units.
    %   writeCapacityUnits - (int64, required) Provisioned write capacity units.
    %
    % Example
    %   pt = aws.dynamodb.model.ProvisionedThroughput(readCapacityUnits=int64(10), writeCapacityUnits=int64(5));

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = ProvisionedThroughput(options)
            % Constructor for ProvisionedThroughput
            %
            % Usage:
            %   throughput = ProvisionedThroughput(readCapacityUnits=5,writeCapacity=5);
            arguments
                options.readCapacityUnits int64
                options.writeCapacityUnits  int64
            end

            builderClass = software.amazon.awssdk.services.dynamodb.model.ProvisionedThroughput.builder();
            obj.Handle = aws.internal.builder.build(builderClass,options);
        end
    end
end
