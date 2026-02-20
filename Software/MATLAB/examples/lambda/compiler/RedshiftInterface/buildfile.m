function plan = buildfile
    %% Configuration
    mainFunction = "AWSLambdaWrapper.m";
    dockerImageName = "matlab-awslambda-redshift-example";
    %% Create the build plans
    % Start a new plan
    plan = buildplan;
    % Add a clean task
    plan("clean") = matlab.buildtool.tasks.CleanTask();
    % Add a compile task for compiling the standalone application. Since
    % the actual MATLAB functions get called through "feval", they are not
    % visible in the code and need to be added explicitly as
    % AdditionalFiles
    plan("compile") = aws.lambda.task.CompileTask( ...
        AppFile=mainFunction, ...
        AdditionalFiles=["maddsub.m","mmod.m","mmultiple2.m"]);
    % Add a docker task which packages the standalone application into a
    % Docker container. Pass the OutputDir of the CompileTask as input.
    plan("docker") = aws.lambda.task.DockerTask( ...
        CompileOutputDir=plan("compile").OutputDir,...
        ImageName=dockerImageName);    
    % Add a test task which tests the resulting Docker image locally
    plan("test") = matlab.buildtool.tasks.TestTask( ...
        "Test", ...
        TestResults="results.xml", ...
        Dependencies="docker");
end