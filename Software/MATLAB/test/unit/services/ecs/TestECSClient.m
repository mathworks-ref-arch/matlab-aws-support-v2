classdef TestECSClient < matlab.unittest.TestCase
    % TESTECSCLIENT Unit Test for the Amazon ECS Client

    % Copyright 2025 The MathWorks, Inc.

    properties
        logObj
        ecs
        sts
        isOnGitlab
        region = 'us-east-1'
        clusterArn % Store the cluster ARN for teardown
        taskDefnArn
    end

    methods(TestClassSetup)
        function testSetup(testCase)
            testCase.logObj = Logger.getLogger();
            testCase.logObj.DisplayLogLevel = 'verbose';
        end

        function checkGitlab(testCase)
            host = getenv('CI_RUNNER_DESCRIPTION');
            testCase.isOnGitlab = ~isempty(host);
        end

        function initializeECSClient(testCase)
            if testCase.isOnGitlab
                credentials = loadConfigurationSettings('credentials.json');
                credentialProvider = aws.auth.CredentialProvider.getSessionCredentialProvider( ...
                    credentials.aws_access_key_id, credentials.aws_secret_access_key, ...
                    credentials.aws_session_token);
                testCase.ecs = aws.ecs.Client('credentialsprovider', credentialProvider, ...
                    'region', testCase.region);
                testCase.sts = aws.sts.Client('credentialsprovider', credentialProvider, ...
                    'region', testCase.region);
            else
                testCase.ecs = aws.ecs.Client('region', testCase.region);
                testCase.sts = aws.sts.Client('region', testCase.region);
            end
        end

        function setupCluster(testCase)

            clusterName = strcat('matlab-ecs-ci-cluster', matlabRelease.Release);
            clusterResponse = testCase.ecs.createCluster(clusterName=clusterName, ...
                executeCommandLogging="DEFAULT");
            testCase.clusterArn = clusterResponse.clusterArn;
            testCase.verifyNotEmpty(clusterResponse.clusterArn);

            testCase.taskDefnArn = registerTaskDefinition(testCase);

        end
    end

    methods(TestClassTeardown)
        function teardownCluster(testCase)
            if ~isempty(testCase.clusterArn)
                deletedCluster = testCase.ecs.deleteCluster(cluster=testCase.clusterArn);
                testCase.verifyNotEmpty(deletedCluster.clusterArn);
            end
            if ~isempty(testCase.taskDefnArn)
                delTaskDefnArn = deleteTaskDefinition(testCase, testCase.taskDefnArn);
                testCase.verifyNotEmpty(delTaskDefnArn);
            end
        end
    end

    methods(Test, TestTags = {'Unit'})
        function testConstructor(testCase)
            write(testCase.logObj, 'debug', 'Testing testConstructor');
            testCase.verifyClass(testCase.ecs, 'aws.ecs.Client');
        end

        function testTaskDefinitionRegistration(testCase)

            try
                % Attempt to load configuration settings
                taskDefinition = loadConfigurationSettings('taskDefinitionConfig.json');
            catch ME
                % Handle errors and use default settings as a fallback
                testCase.logObj = Logger.getLogger();
                disp('Using default settings due to error in loading configuration.');
                taskDefinition = testCase.createDefaultTaskDefinition();
            end

            containerDef = taskDefinition.containerDefinitions(1); % Assuming a single container
            if ~isempty(containerDef.image)
                imageUri = containerDef.image;
            else

                accountId = testCase.sts.getCallerIdentity().accountId;
                if isempty(accountId)
                    error('Failed to retrieve AWS account ID. Please ensure AWS STS is configured correctly.');
                end
                defRegion = testCase.region;
                repositoryName = 'ecs-matlab-app-default';
                imageTag = 'latest';

                imageUri = sprintf('%s.dkr.ecr.%s.amazonaws.com/%s:%s', accountId, defRegion, repositoryName, imageTag);
            end

            % Create container definition object
            container = aws.ecs.model.ContainerDefinition(name= containerDef.name, ...
                image= imageUri, ...
                memory= containerDef.memory, ...
                cpu= containerDef.cpu, ...
                essential= containerDef.essential);

            taskDefinitionResponse = testCase.ecs.registerTaskDefinition(...
                family= taskDefinition.family, ...
                taskRoleArn= taskDefinition.taskRoleArn, ...
                executionRoleArn= taskDefinition.executionRoleArn, ...
                networkMode= taskDefinition.networkMode, ...
                containerDefinitions= {container}, ...
                requiresCompatibilities= [string(taskDefinition.requiresCompatibilities{1})], ...
                cpu= taskDefinition.cpu, ...
                memory= taskDefinition.memory);

            testCase.verifyNotEmpty(taskDefinitionResponse.taskDefinitionArn);

            deregisteredtaskDefinition = testCase.ecs.deregisterTaskDefinition( ...
                taskDefinition=taskDefinitionResponse.taskDefinitionArn);
            testCase.verifyNotEmpty(deregisteredtaskDefinition.taskDefinitionArn);

            deletedtaskDefinition = testCase.ecs.deleteTaskDefinitions( ...
                taskDefinitions=taskDefinitionResponse.taskDefinitionArn);
            testCase.verifyNotEmpty(deletedtaskDefinition.taskDefinitionArn);

        end
    end

    methods(Test, TestTags = {'Unit', 'ClusterRequired'})

        function testECSServiceCRUD(testCase)
            write(testCase.logObj, 'debug', 'Testing CreateService with predefined configuration objects');

            serviceName = strcat('matlab-ecs-ci-service', matlabRelease.Release);

            createServiceResponse = testCase.ecs.createService(cluster= testCase.clusterArn, ...
                serviceName= serviceName, ...
                taskDefinition= testCase.taskDefnArn, ...
                launchType= "FARGATE", ...
                desiredCount= 2, ...
                subnets= {'subnet-0173de1b569028b6e'}, ...
                securityGroups= {'sg-0d2e96bbaf7f9d7cb'});

            testCase.verifyNotEmpty(createServiceResponse.serviceArn);

            updateServiceResponse = testCase.ecs.updateService(cluster= testCase.clusterArn, ...
                service= serviceName, taskDefinition= testCase.taskDefnArn, desiredCount= 0);

            testCase.verifyNotEmpty(updateServiceResponse.serviceArn);

            deletedService = testCase.ecs.deleteService(service= createServiceResponse.serviceArn, ...
                cluster= testCase.clusterArn, force= true);
            testCase.verifyNotEmpty(deletedService.serviceArn);

        end

        function testCreateClusterWithCapacityProviders(testCase)
            clusterName = "matlab-ecs-capacity-" + matlabRelease.Release;
            resp = testCase.ecs.createCluster( ...
                clusterName=clusterName, ...
                capacityProviders=["FARGATE"]);
            testCase.verifyNotEmpty(resp.clusterArn);
            deletedCluster = testCase.ecs.deleteCluster(cluster=resp.clusterArn);
            testCase.verifyNotEmpty(deletedCluster.clusterArn);
        end

        function testCreateClusterWithTags(testCase)
            clusterName = "matlab-ecs-tags-" + matlabRelease.Release;
            tags = dictionary("env", "test", "owner", "qa");
            resp = testCase.ecs.createCluster( ...
                clusterName=clusterName, ...
                tags=tags);
            testCase.verifyNotEmpty(resp.clusterArn);
            deletedCluster = testCase.ecs.deleteCluster(cluster=resp.clusterArn);
            testCase.verifyNotEmpty(deletedCluster.clusterArn);
        end

        function testCreateClusterWithSettings(testCase)
            clusterName = "matlab-ecs-settings-" + matlabRelease.Release;
            settings = dictionary("containerInsights", "enabled");
            resp = testCase.ecs.createCluster( ...
                clusterName=clusterName, ...
                settings=settings);
            testCase.verifyNotEmpty(resp.clusterArn);
            deletedCluster = testCase.ecs.deleteCluster(cluster=resp.clusterArn);
            testCase.verifyNotEmpty(deletedCluster.clusterArn);
        end

        function testCreateService_WithLoadBalancers_BranchCoverage(testCase)
            % Cover the branch in createService that converts/load Balancers
            % into a java array and attaches NetworkConfiguration.
            % We expect the AWS call to fail due to an invalid target group ARN,
            % but the path up to the service call is executed and covered.

            import software.amazon.awssdk.services.ecs.model.*

            serviceName = "matlab-ecs-svc-lb-" + matlabRelease.Release;

            % Build a LoadBalancer SDK object (wrapped) with a dummy target group.
            % This is sufficient to exercise the MATLAB -> Java list conversion,
            % regardless of AWS-side validation.
            fakeTgArn = "arn:aws:elasticloadbalancing:" + testCase.region + ...
                ":000000000000:targetgroup/fake-tg/";

            % Create the SDK LoadBalancer and wrap it in your matlab class
            lb = aws.ecs.model.LoadBalancers(...
                containerName="matlab-ecs-app-container", containerPort=9910, targetGroupArn=fakeTgArn);

            % Also create a vector with two entries to cover the vector path.
            lb2 = aws.ecs.model.LoadBalancers( ...
                containerName="matlab-ecs-app-container", containerPort=9090, targetGroupArn=fakeTgArn);

            % Use your existing networking IDs (adjust if your CI env differs)
            subnets        = {'subnet-0173de1b569028b6e'};
            securityGroups = {'sg-0d2e96bbaf7f9d7cb'};

            testCase.verifyError(@() testCase.ecs.createService( ...
                cluster        = testCase.clusterArn, ...
                serviceName    = serviceName + "-vector", ...
                taskDefinition = testCase.taskDefnArn, ...
                launchType     = "FARGATE", ...
                desiredCount   = 0, ...
                subnets        = subnets, ...
                securityGroups = securityGroups, ...
                loadBalancers  = [lb lb2], ...     % vector of objects
                assignPublicIp = "DISABLED"), ...
                'MATLAB:Java:GenericException');

        end


    end

    methods

        function settings = createDefaultTaskDefinition(testCase)

            defRegion = testCase.region;
            repositoryName = 'ecs-matlab-app-default';
            imageTag = 'latest';
            roleName = 'ecsTaskExecutionRole';

            % Logic to obtain AWS account ID
            accountId = testCase.sts.getCallerIdentity().accountId;
            if isempty(accountId)
                error('Failed to retrieve AWS account ID. Please ensure AWS STS is configured correctly.');
            end

            % Construct the image URI
            imageUri = sprintf('%s.dkr.ecr.%s.amazonaws.com/%s:%s', accountId, defRegion, repositoryName, imageTag);

            % Construct the task role ARN
            taskRoleArn = sprintf('arn:aws:iam::%s:role/%s', accountId, roleName);

            % Construct the execution role ARN (assuming it's the same as task role ARN)
            executionRoleArn = taskRoleArn;

            % Create a default settings structure
            settings = struct(...
                'containerDefinitions', struct(...
                'name', repositoryName, ...
                'image', imageUri, ...
                'cpu', 256, ...
                'memory', 512, ...
                'essential', true ...
                ), ...
                'family', repositoryName, ...
                'taskRoleArn', taskRoleArn, ...
                'executionRoleArn', executionRoleArn, ...
                'networkMode', 'awsvpc', ...
                'requiresCompatibilities', "FARGATE", ...
                'cpu', '256', ...
                'memory', '512' ...
                );
        end


        function taskDefinitionArn = registerTaskDefinition(testCase)

            try
                % Attempt to load configuration settings
                taskDefinition = loadConfigurationSettings('taskDefinitionConfig.json');
            catch ME
                % Handle errors and use default settings as a fallback
                testCase.logObj = Logger.getLogger();
                disp('Using default settings due to error in loading configuration.');
                taskDefinition = testCase.createDefaultTaskDefinition();
            end

            containerDef = taskDefinition.containerDefinitions(1); % Assuming a single container

            if ~isempty(containerDef.image)
                imageUri = containerDef.image;
            else

                accountId = testCase.sts.getCallerIdentity().accountId;
                if isempty(accountId)
                    error('Failed to retrieve AWS account ID. Please ensure AWS STS is configured correctly.');
                end
                defRegion = testCase.region;
                repositoryName = 'ecs-matlab-app-default';
                imageTag = 'latest';

                imageUri = sprintf('%s.dkr.ecr.%s.amazonaws.com/%s:%s', accountId, defRegion, repositoryName, imageTag);
            end

            % Create container definition object
            container = aws.ecs.model.ContainerDefinition(name=containerDef.name, ...
                image=imageUri, memory=containerDef.memory,cpu=containerDef.cpu, ...
                essential=containerDef.essential);

            taskDefinitionResponse = testCase.ecs.registerTaskDefinition(...
                family= taskDefinition.family, ...
                taskRoleArn= taskDefinition.taskRoleArn, ...
                executionRoleArn= taskDefinition.executionRoleArn, ...
                networkMode= taskDefinition.networkMode, ...
                containerDefinitions= {container}, ...
                requiresCompatibilities= [string(taskDefinition.requiresCompatibilities{1})], ...
                cpu= taskDefinition.cpu, ...
                memory= taskDefinition.memory);

            taskDefinitionArn = taskDefinitionResponse.taskDefinitionArn;

        end


        function taskDefinitionArn = deleteTaskDefinition(testCase, taskDefinitionArn)

            deregisteredtaskDefinition = testCase.ecs.deregisterTaskDefinition(taskDefinition = taskDefinitionArn);
            testCase.verifyNotEmpty(deregisteredtaskDefinition.taskDefinitionArn);

            deletedtaskDefinition = testCase.ecs.deleteTaskDefinitions(taskDefinitions = taskDefinitionArn);
            taskDefinitionArn = deletedtaskDefinition.taskDefinitionArn;

        end
    end

end