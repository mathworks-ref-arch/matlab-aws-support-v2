function plan = buildfile
    %% Configuration
    mainFunction = "AWSLambdaWrapper.m";
    dockerImageName = "matlab-awslambda-functionurl-example";
    %% Create the build plans
    % Start a new plan
    plan = buildplan;
    % Add a clean task
    plan("clean") = matlab.buildtool.tasks.CleanTask();
    % Add a compile task for compiling the standalone application
    plan("compile") = aws.lambda.task.CompileTask( ...
        AppFile=mainFunction);
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