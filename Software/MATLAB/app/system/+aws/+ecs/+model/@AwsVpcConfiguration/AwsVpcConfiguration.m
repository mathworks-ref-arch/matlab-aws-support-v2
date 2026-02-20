classdef AwsVpcConfiguration < aws.Object
    % AWSVPCCONFIGURATION Helper to configure awsvpc networking for ECS services.
    %
    % Syntax
    %   cfg = aws.ecs.model.AwsVpcConfiguration(struct("subnets",["subnet-1"]));
    %   cfg = aws.ecs.model.AwsVpcConfiguration("sdkLoadBalancer", sdkObj); % wrap existing SDK handle
    %
    % Name-Value/Struct Fields
    %   subnets        - string array of subnet IDs for task ENIs.
    %   securityGroups - string array of security group IDs.
    %   assignPublicIp - string flag ("ENABLED" or "DISABLED").
    %
    % Example
    %   opts = struct("subnets", ["subnet-1","subnet-2"], ...
    %                 "securityGroups", ["sg-123"], ...
    %                 "assignPublicIp", "ENABLED");
    %   cfg = aws.ecs.model.AwsVpcConfiguration(opts);

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = AwsVpcConfiguration(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ecs.model.AwsVpcConfiguration')
                obj.Handle = varargin{1};

            elseif nargin == 1 && isstruct(varargin{1})

                awsVpcConfigBuilder = software.amazon.awssdk.services.ecs.model.AwsVpcConfiguration.builder();
                obj.Handle = aws.internal.builder.build(awsVpcConfigBuilder, varargin{1});

            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end
    end
end

