classdef LogConfiguration < aws.Object
    % LOGCONFIGURATION Define how ECS collects container logs.
    %
    % Syntax
    %   logCfg = aws.ecs.model.LogConfiguration(logDriver="awslogs", ...
    %       options=dictionary("awslogs-group","/ecs/demo"));
    %
    % Name-Value Arguments
    %   logDriver - (string, required) One of "awslogs","fluentd","json-file",
    %               "syslog","journald","splunk","gelf","none".
    %   options   - (dictionary) Driver-specific options (converted to the SDK map).

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = LogConfiguration(options)
            arguments
                options.logDriver (1,1) string {mustBeMember(options.logDriver, ...
                    ["awslogs", "fluentd", "json-file", "syslog", "journald", "splunk", "gelf", "none"])}
                options.options dictionary = dictionary()
            end

            initializeLogger(obj, 'Amazon:ECS:LogConfiguration');

            % Build the log configuration using AWS SDK
            import software.amazon.awssdk.services.ecs.model.*;
            logConfigBuilder = LogConfiguration.builder();
            if numEntries(options.options) > 0
                options.options = dictionary(string(strrep(options.options.keys, '_', '-')), ...
                    string(options.options.values));
            end
            obj.Handle = aws.internal.builder.build(logConfigBuilder, options);
        end
    end
end
