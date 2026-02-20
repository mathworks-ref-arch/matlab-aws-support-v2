classdef CompileTask < matlab.buildtool.Task
    % COMPILETASK Build task that compiles a standalone MATLAB application.
    %
    % Syntax
    %   task = aws.lambda.task.CompileTask(AppFile=matlab.buildtool.io.File("app.m"));
    %
    % Name-Value Arguments
    %   AppFile         - (matlab.buildtool.io.File) Main entry point (required).
    %   AdditionalFiles - (matlab.buildtool.io.FileCollection) Extra resources packaged with the app.
    %   OutputDir       - (matlab.buildtool.io.File) Destination for compiler outputs (default `pwd/StandaloneApplication`).
    %   Description     - (string) Task description shown in build plans.
    %   Dependencies    - (string array) Other build tasks that must run first.
    %
    % Example
    %   compileTask = aws.lambda.task.CompileTask( ...
    %       AppFile=matlab.buildtool.io.File("app.m"), ...
    %       OutputDir=matlab.buildtool.io.File("build/Standalone"));
    %   compileTask.compileStandalone();
    %
    % See Also aws.lambda.task.DockerTask, compiler.build.standaloneApplication

    % Copyright 2025 The MathWorks, Inc

    properties(TaskInput)
        AppFile matlab.buildtool.io.File
        AdditionalFiles matlab.buildtool.io.FileCollection
    end
    properties(TaskOutput)
        OutputDir matlab.buildtool.io.File
    end
    methods
        function task = CompileTask(options)
            % COMPILETASK constructor
            %
            % Can be called with Name-Value pairs as input where Name can
            % match any class property name which will be then set this
            % property to the specified Value.
            arguments
                options.Dependencies = string.empty(1,0)
                options.Description string = "Build standalone application"
                options.AppFile matlab.buildtool.io.File
                options.AdditionalFiles matlab.buildtool.io.FileCollection
                options.OutputDir matlab.buildtool.io.File = fullfile(pwd,"StandaloneApplication")
            end
            for prop = string(fieldnames(options))'
                task.(prop) = options.(prop);
            end
        end
    end

    methods (TaskAction, Sealed, Hidden)
        function compileStandalone(task,~)
            %COMPILESTANDALONE builds the standalone application

            % Simply use compiler.build.standaloneApplication to build the
            % standalone
            buildResult = compiler.build.standaloneApplication( ...
                task.AppFile.Path, ...
                AdditionalFiles=task.AdditionalFiles.paths,...
                OutputDir=task.OutputDir.Path);
            % Save the build results in a MAT-file such that it can later be
            % reloaded in other tasks
            save(fullfile(task.OutputDir.Path,"build.mat"),"buildResult");
        end
    end

end
