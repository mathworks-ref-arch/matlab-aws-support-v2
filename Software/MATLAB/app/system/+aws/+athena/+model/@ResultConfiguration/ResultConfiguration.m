classdef ResultConfiguration < aws.Object
    %RESULTCONFIGURATION MATLAB representation of Athena ResultConfiguration.
    %
    % Syntax
    %   rc = aws.athena.model.ResultConfiguration(outputLocation="s3://bucket/path/");
    %   rc = aws.athena.model.ResultConfiguration( ...
    %           outputLocation="s3://bucket/path/", ...
    %           encryptionConfiguration=encCfg);
    %   rc = aws.athena.model.ResultConfiguration(javaResultConfiguration=javaObj);
    %
    % Name-Value Arguments
    %   outputLocation         - (string) S3 URI for query results.
    %   encryptionConfiguration - (aws.athena.model.EncryptionConfiguration |
    %                              software.amazon.awssdk.services.athena.model.EncryptionConfiguration)
    %                             Encryption settings for the result files.
    %   javaResultConfiguration - (software.amazon.awssdk.services.athena.model.ResultConfiguration)
    %                              Use an existing Java object instead of constructing a new one.
    %
    % Example
    %   rc = aws.athena.model.ResultConfiguration( ...
    %            outputLocation="s3://bucket/results/", ...
    %            encryptionConfiguration=myEncCfg);
    
    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = ResultConfiguration(options)
            % Constructor for ResultConfiguration
            %
            % Usage:
            %   rc = ResultConfiguration(outputLocation="s3://bucket/", encryptionConfiguration=encCfg);
            arguments
                options.outputLocation (1,1) string
                options.encryptionConfiguration
                options.javaResultConfiguration
            end

            if isfield(options, "javaResultConfiguration") && ...
                    isa(options.javaResultConfiguration, "software.amazon.awssdk.services.athena.model.ResultConfiguration")
                obj.Handle = options.javaResultConfiguration;
            else
                builder = software.amazon.awssdk.services.athena.model.ResultConfiguration.builder();

                % Convert MATLAB strings to Java Strings
                builderOpts = struct();
                if isfield(options, "outputLocation") && ~isempty(options.outputLocation)
                    builderOpts.outputLocation = java.lang.String(options.outputLocation);
                end

                if isfield(options, "encryptionConfiguration") && ~isempty(options.encryptionConfiguration)
                    % Accept either a MATLAB wrapper or a Java EncryptionConfiguration
                    if isa(options.encryptionConfiguration, "aws.athena.model.EncryptionConfiguration")
                        builderOpts.encryptionConfiguration = options.encryptionConfiguration.Handle;
                    elseif isa(options.encryptionConfiguration, "software.amazon.awssdk.services.athena.model.EncryptionConfiguration")
                        builderOpts.encryptionConfiguration = options.encryptionConfiguration;
                    else
                        error("Invalid encryptionConfiguration type.");
                    end
                end

                obj.Handle = aws.internal.builder.build(builder, builderOpts);
            end
        end
    end
end
