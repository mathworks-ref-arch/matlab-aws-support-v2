classdef TestRedshiftDataClient < matlab.unittest.TestCase
    % TESTCLIENT Unit Test for the Amazon Redshift Data API Client
    % The test suite exercises the basic operations on the Amazon Redshift Data API Client.

    % Copyright 2025 The MathWorks, Inc.

    properties
        logObj
        redshiftdata
        isOnGitlab
    end
    methods(TestClassSetup)
        % Shared setup for the entire test class
        function testSetup(testCase)
            testCase.logObj = Logger.getLogger();
            testCase.logObj.DisplayLogLevel = 'verbose';

        end
        function checkGitlab(testCase)
            host=getenv('CI_RUNNER_DESCRIPTION');
            testCase.isOnGitlab = ~isempty(host);
        end

        function initializeredshiftdataClient(testCase)
            %overriding the region
            region = 'us-east-1';
            if testCase.isOnGitlab
                credentials = loadConfigurationSettings('credentials.json');
                credentialProvider = aws.auth.CredentialProvider.getSessionCredentialProvider( ...
                    credentials.aws_access_key_id, credentials.aws_secret_access_key, ...
                    credentials.aws_session_token);
                testCase.redshiftdata = aws.redshiftdata.Client( ...
                    'credentialsprovider', credentialProvider, 'region', region);

            else
                testCase.redshiftdata = aws.redshiftdata.Client('region', region);
            end

        end
    end

    methods(Test, TestTags = {'Unit'})

        function testConstructor(testCase)
            write(testCase.logObj,'debug','Testing testConstructor');
            testCase.verifyClass(testCase.redshiftdata,'aws.redshiftdata.Client');
        end
    end
    methods(Test, TestTags = {'RedshiftUnitTest'})

        function testExecuteStatementPositive(testCase)
            % Test a successful execution of an SQL statement
            clusterId = 'redshift-cluster-1';

            response = testCase.redshiftdata.executeStatement(sql='SELECT * FROM employees', ...
                clusterIdentifier=clusterId, database='dev');

            % Verify the response is as expected
            testCase.verifyNotEmpty(response);
            testCase.verifyEqual(char(response.Handle.clusterIdentifier), clusterId);
            testCase.verifyInstanceOf(response, 'aws.redshiftdata.model.ExecuteStatementResponse');
        end

        function testExecuteStatementWithParameters(testCase)
            % Test execution with parameters
            sql = ['SELECT * FROM employees WHERE first_name = :param1' ...
                ' AND last_name = :param2'];
            clusterId = 'redshift-cluster-1';

            parameters = dictionary({'param1', 'param2'}, {'Jane', 'Smith'});

            response = testCase.redshiftdata.executeStatement(sql = sql, ...
                clusterIdentifier=clusterId, database='dev', ...
                parameters = parameters);

            % Verify the response
            testCase.verifyNotEmpty(response);
            testCase.verifyEqual(char(response.Handle.clusterIdentifier), clusterId);
            testCase.verifyInstanceOf(response, 'aws.redshiftdata.model.ExecuteStatementResponse');
        end

        function testExecuteStatementNegative(testCase)
            % Test with missing required fields

            testCase.verifyError(@() testCase.redshiftdata.executeStatement(sql='SELECT * FROM myTable'), ...
                'Amazon:RedshiftData');
        end

        function testGetStatementResultNegative(testCase)
            % Test with missing required fields
            options = struct('nextToken', 'example-next-token');
            testCase.verifyError(@() testCase.redshiftdata.getStatementResult(options), ...
                'MATLAB:TooManyInputs');
        end
        %
        % function testGetStatementResultPositive(testCase)
        %
        %     clusterId = 'redshift-cluster-1';
        %
        %     exResponse = testCase.redshiftdata.executeStatement( ...
        %         sql='SELECT * FROM employees', ...
        %         clusterIdentifier=clusterId, database='dev');
        %
        %     testCase.verifyNotEmpty(exResponse.Handle.id);
        %     % Pause to ensure that the executeStatement is finished
        %     % executing
        %     pause(5);
        %
        %     % Test a successful retrieval of statement result
        %     response = testCase.redshiftdata.getStatementResult(id=exResponse.Handle.id);
        %
        %     % Verify the response is as expected
        %     testCase.verifyNotEmpty(response.getResultSet());
        %     testCase.verifyInstanceOf(response, 'aws.redshiftdata.model.GetStatementResultResponse');
        % end


    end
end

