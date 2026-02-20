classdef TestAthenaClient < matlab.unittest.TestCase
    % TESTATHENACLIENT Unit Test for the Amazon Athena Client
    %
    % The assertions that you can use in test cases:
    %
    %    verifyClass
    %    verifyNotEmpty
    %    verifyEqual
    %
    % The test suite exercises the basic operations on the Athena Client.

    % Copyright 2025 The MathWorks, Inc.

    properties
        logObj
        athena
        isOnGitlab
        databaseName
        outputLocation
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

        function initializeAthenaClient(testCase)
            region = 'us-east-1';
            if testCase.isOnGitlab
                credentials = loadConfigurationSettings('credentials.json');
                credentialProvider = aws.auth.CredentialProvider.getSessionCredentialProvider(...
                    credentials.aws_access_key_id, credentials.aws_secret_access_key, ...
                    credentials.aws_session_token);
                testCase.athena = aws.athena.Client('credentialsprovider', credentialProvider, ...
                    'region', region);
            else
                testCase.athena = aws.athena.Client('region', region);
            end
            testCase.outputLocation = "s3://app-dept-pft-cicd";
            write(testCase.logObj, 'verbose', ["Output Location: "  testCase.outputLocation]);
        end
    end

    methods(TestMethodSetup)
        function selectDatabase(testCase)
            % Get the first available database for testing
            % dbs = testCase.athena.listDatabases("AwsDataCatalog");
            % testCase.verifyNotEmpty(dbs, 'No Athena databases found.');
            testCase.databaseName = "app-dept-pft-cicd-gluedb";
            % write(testCase.logObj, 'verbose', ['Using Athena database: ' testCase.databaseName]);
            write(testCase.logObj, 'verbose', testCase.databaseName);
            write(testCase.logObj, 'verbose', ["Output Location: "  testCase.outputLocation]);
        end
    end

    methods(Test, TestTags = {'Unit'})

        function testSimpleQuery(testCase)
            % Run a simple query and check results
            queryString = sprintf('SELECT 1 AS test_col');
            rc = aws.athena.model.ResultConfiguration(outputLocation=testCase.outputLocation);
            qc = aws.athena.model.QueryExecutionContext(database=testCase.databaseName);
            queryExecResp = testCase.athena.startQueryExecution( ...
                queryString=queryString, ...
                queryExecutionContext=qc, ...
                resultConfiguration=rc);

            testCase.verifyNotEmpty(queryExecResp.queryExecutionId, 'QueryExecutionId should not be empty.');

            % Wait for query to succeed
            maxWait = 60; % seconds
            tStart = tic;
            while true
                statusResp = testCase.athena.getQueryExecution(queryExecutionId=queryExecResp.queryExecutionId);
                status = string(statusResp.status.state);
                if status == "SUCCEEDED"
                    break;
                elseif status == "FAILED" || status == "CANCELLED"
                    error("Athena query failed or was cancelled: %s", status);
                elseif toc(tStart) > maxWait
                    error("Athena query timed out after %d seconds", maxWait);
                end
                pause(2);
            end

            % Fetch results
            resultResp = testCase.athena.getQueryResults(queryExecutionId=queryExecResp.queryExecutionId);
            testCase.verifyNotEmpty(resultResp.resultSet, 'Query result set should not be empty.');
            write(testCase.logObj, 'verbose', evalc('disp(resultResp.resultSet)'));

            % Stop Execution
            stopResp = testCase.athena.stopQueryExecution(queryExecutionId=queryExecResp.queryExecutionId);
            testCase.verifyNotEmpty(stopResp.statusCode);
            write(testCase.logObj, 'verbose', "Query stopped");
        end

        function testStartQueryExecutionMinimal(testCase)
            queryString = "SELECT 2 AS test_col";
            rc = aws.athena.model.ResultConfiguration(outputLocation=testCase.outputLocation);

            resp = testCase.athena.startQueryExecution( ...
                queryString=queryString, ...
                resultConfiguration=rc);

            testCase.verifyNotEmpty(resp.queryExecutionId);
        end

        function testGetQueryResultsWithPagination(testCase)
            queryString = "SELECT 3 AS test_col";
            rc = aws.athena.model.ResultConfiguration(outputLocation=testCase.outputLocation);
            qc = aws.athena.model.QueryExecutionContext(database=testCase.databaseName);

            % Start query execution
            resp = testCase.athena.startQueryExecution(queryString=queryString, ...
                queryExecutionContext=qc, resultConfiguration=rc);

            testCase.verifyNotEmpty(resp.queryExecutionId);

            % Wait for query to complete
            maxWait = 60;
            tStart = tic;
            status = "";
            while true
                statusResp = testCase.athena.getQueryExecution(queryExecutionId=resp.queryExecutionId);
                status = string(statusResp.status.state);
                testCase.verifyNotEmpty(status, "Query status should not be empty");

                if status == "SUCCEEDED"
                    break;
                elseif status == "FAILED" || status == "CANCELLED"
                    testCase.verifyFail("Query failed or was cancelled: " + status);
                elseif toc(tStart) > maxWait
                    testCase.verifyFail("Query timed out after " + maxWait + " seconds");
                end
                pause(2);
            end

            % Only proceed if status is SUCCEEDED
            resultResp = testCase.athena.getQueryResults(queryExecutionId=resp.queryExecutionId, maxResults=5);
            testCase.verifyNotEmpty(resultResp);
            testCase.verifyNotEmpty(resultResp.resultSet, "ResultSet should not be empty");
        end

    end
end