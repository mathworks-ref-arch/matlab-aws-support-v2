classdef DockerTask < matlab.buildtool.Task
    % DOCKERTASK Package compiled artifacts into an AWS Lambda-ready image.
    %
    % Syntax
    %   task = aws.lambda.task.DockerTask( ...
    %       CompileOutputDir=matlab.buildtool.io.File("StandaloneApplication"), ...
    %       ImageName="lambda-image");
    %
    % Name-Value Arguments
    %   CompileOutputDir - (matlab.buildtool.io.File) OutputDir from `CompileTask` (required).
    %   ImageName        - (string) Docker image/tag name (default `"awslambda"`).
    %   PatchLibiomp5    - (logical) Apply libiomp5 patch in the runtime (default true).
    %   Libiomp5Location - (matlab.buildtool.io.File) Path to patched library.
    %   IncludeEmulator  - (logical) Bundle the Runtime Interface Emulator (default true).
    %   DockerContext    - (matlab.buildtool.io.File) Folder for generated Docker artifacts.
    %   Description      - (string) Task description for build plans.
    %   Dependencies     - (string array) Build tasks that must complete first.
    %
    % Example
    %   dockerTask = aws.lambda.task.DockerTask( ...
    %       CompileOutputDir=matlab.buildtool.io.File("StandaloneApplication"), ...
    %       ImageName="lambda-runtime");
    %   dockerTask.dockerBuild();
    %
    % See Also aws.lambda.task.CompileTask, compiler.package.docker

    % Copyright 2025 The MathWorks, Inc

    properties (TaskInput)
        ImageName string
        CompileOutputDir matlab.buildtool.io.File
        PatchLibiomp5 logical
        Libiomp5Location matlab.buildtool.io.File
        IncludeEmulator logical
    end
    properties (TaskOutput)
        DockerContext matlab.buildtool.io.File
    end
    methods
        function task = DockerTask(options)
            % DOCKERTASK constructor
            %
            % Can be called with Name-Value pairs as input where Name can
            % match any class property name which will be then set this
            % property to the specified Value.
            arguments
                options.ImageName string = "awslambda"
                options.Description string = "Build AWS Lambda Compatible Docker Image"
                options.CompileOutputDir matlab.buildtool.io.File
                options.PatchLibiomp5 logical = true
                options.Libiomp5Location matlab.buildtool.io.File = fullfile(fileparts(fileparts(mfilename("fullpath"))),"patch","libiomp5.so")
                options.DockerContext matlab.buildtool.io.File = fullfile(pwd,"AWSLambdaDocker")
                options.Dependencies = string.empty(1,0)
                options.IncludeEmulator logical = true
            end
            for prop = string(fieldnames(options))'
                task.(prop) = options.(prop);
            end
        end
    end

    methods (TaskAction, Sealed, Hidden)
        function dockerBuild(task,~)
            %DOCKERBUILD builds the Docker container around the standalone
            %application

            if task.PatchLibiomp5 && ~isfile(task.Libiomp5Location.Path)
                error('matlab:aws:lambda:missinglibiomp5','Patched libiomp5.so cannot be found. Please ensure you have placed a compatible libiomp5.so in the patch directory.');
            end

            % Load the build results from the compile step
            r = load(fullfile(task.CompileOutputDir.Path,"build.mat"));

            % Start configuring the build
            opts = compiler.package.DockerOptions(...
                ImageName=task.ImageName, ...
                DockerContext=task.DockerContext.Path);
            % Start the list of files by taking the build result files
            files = r.buildResult.Files;

            if task.IncludeEmulator
                % Generate the entrypoint script which can run the
                % emulator/simulator or the actual application, use a temporary
                % location for this. First generate a random name inside TEMP
                t = tempname;
                % Create this directory
                mkdir(t)
                % Inside this directory create entrypoint.sh
                ep = fullfile(t,'entrypoint.sh');
                f = fopen(ep,"w");
                % Generare the wrapper. This is inspired by the entrypoint provided
                % here: https://github.com/aws/aws-lambda-runtime-interface-emulator/tree/develop?tab=readme-ov-file#build-rie-into-your-base-image
                %
                % Essentially this script says: if environment variable
                % AWS_LAMBDA_RUNTIME_API is not set (which is typically the case
                % when you run the image locally), then run the emulator (and tell
                % the emulator where to find the real application it should be
                % working with in turn). If the environment variable is set (which
                % is the case when the image is really launched by AWS Lambda on
                % AWS Lambda), simply run the real application.
                fprintf(f,'#!/bin/sh\n');
                fprintf(f,'if [ -z "${AWS_LAMBDA_RUNTIME_API}" ]; then\n');
                fprintf(f,'  /opt/aws-lambda-rie-x86_64 /usr/bin/mlrtapp/%s\n',r.buildResult.Options.ExecutableName);
                fprintf(f,'else\n');
                fprintf(f,'  /usr/bin/mlrtapp/%s\n',r.buildResult.Options.ExecutableName);
                fprintf(f,'fi\n');
                fclose(f);
                % Ensure the entrypoint is executable
                system(sprintf('chmod +x %s',ep));
                % Delete the generated entrypoint after function completes
                ept = onCleanup(@()rmdir(t,'s'));

                % Include wget whih is used to install the emulator
                opts.AdditionalPackages = "wget";
                % Add the additional instruction which installs the
                % emulator
                opts.AdditionalInstructions{end+1} = 'RUN wget https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/download/v1.20/aws-lambda-rie-x86_64 -O /opt/aws-lambda-rie-x86_64 && chmod +x /opt/aws-lambda-rie-x86_64';
                % Set the entrypoint to the generated script
                opts.EntryPoint="entrypoint.sh";
                % Add the entrypoint to the files to be added to the image
                files{end+1} = ep;
            end

            if task.PatchLibiomp5
                % Add the patched libiomp5
                files{end+1} = char(task.Libiomp5Location.Path);
                % Add the instruction which replaces the broken libiomp5
                opts.AdditionalInstructions{end+1} = sprintf('RUN mv /usr/bin/mlrtapp/libiomp5.so /opt/matlabruntime/R%s/sys/os/glnxa64',version('-release'));
            end

            % Build the Docker image
            compiler.package.docker(...
                ... Include list of files
                files, ...
                ... Provide the required products file
                fullfile(r.buildResult.Options.OutputDir,'requiredMCRProducts.txt'), ...
                ... Pass along the configuration options
                Options=opts ...
                );

        end
    end

end
