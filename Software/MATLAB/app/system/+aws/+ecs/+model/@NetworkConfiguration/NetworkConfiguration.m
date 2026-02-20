classdef NetworkConfiguration < aws.Object
    % NETWORKCONFIGURATION Wrapper for ECS network configuration objects.
    %
    % Syntax
    %   cfg = aws.ecs.model.NetworkConfiguration(struct("awsvpcConfiguration", cfgStruct));
    %   cfg = aws.ecs.model.NetworkConfiguration("sdkNetworkConfiguration", sdkObj); % wrap existing handle

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = NetworkConfiguration(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ecs.model.NetworkConfiguration')
                obj.Handle = varargin{1};

            elseif nargin == 1 && isstruct(varargin{1})

                networkConfigBuilder = software.amazon.awssdk.services.ecs.model.NetworkConfiguration.builder();
                obj.Handle = aws.internal.builder.build(networkConfigBuilder, varargin{1});

            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end
    end
end

