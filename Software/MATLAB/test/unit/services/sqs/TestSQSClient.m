classdef TestSQSClient < matlab.unittest.TestCase
    % TESTSQSCLIENT Unit Test for the Amazon SQS Client
    %
    % The assertions that you can use in test cases:
    %
    %    verifyClass
    %    verifyNotEmpty
    %    verifyEqual
    %
    % The test suite exercises the basic operations on the SQS Client.

    % Copyright 2025 The MathWorks, Inc.

    properties
        logObj
        sqs
        isOnGitlab
        queueUrl
    end

    methods(TestClassSetup)
        % Shared setup for the entire test class
        function testSetup(testCase)
            testCase.logObj = Logger.getLogger();
            testCase.logObj.DisplayLogLevel = 'verbose';
        end

        function checkGitlab(testCase)
            host = getenv('CI_RUNNER_DESCRIPTION');
            testCase.isOnGitlab = ~isempty(host);
        end

        function initializeSQSClient(testCase)
            region = 'us-east-1';
            if testCase.isOnGitlab
                credentials = loadConfigurationSettings('credentials.json');
                credentialProvider = aws.auth.CredentialProvider.getSessionCredentialProvider(...
                    credentials.aws_access_key_id, credentials.aws_secret_access_key, ...
                    credentials.aws_session_token);
                testCase.sqs = aws.sqs.Client('credentialsprovider', credentialProvider, ...
                    'region', region);

            else
                testCase.sqs = aws.sqs.Client('region', region);
            end
        end
                function createQueue(testCase)

            % Create a test queue and store its URL
            queueName = strcat('matlab-sqstest-queue-', ...
                string(datetime('now', 'Format', 'yyyyMMddHHmmssSSS')), matlabRelease.Release);
            attr = dictionary(["MaximumMessageSize", "DelaySeconds"], ["262144", "5"]);
            createQueueResponse = testCase.sqs.createQueue(queueName = queueName, ...
                attributesWithStrings = attr);
            testCase.verifyNotEmpty(createQueueResponse.queueUrl);
            testCase.queueUrl = createQueueResponse.queueUrl;
        end
    end

    methods(TestClassTeardown)
        function deleteTestQueue(testCase)
            % Delete the test queue after tests
            deleteQueueResponse = testCase.sqs.deleteQueue('queueUrl', testCase.queueUrl);
            testCase.verifyClass(deleteQueueResponse, 'aws.sqs.model.DeleteQueueResponse');
        end
    end

    methods(Test, TestTags = {'Unit'})

        function testSendMessageSuccess(testCase)

            % Test sending a valid message
            messageBody = strcat('Test Message from MATLAB Interface for Amazon SQS : ', string(datetime));

            % Call the sendMessage function
            sendMessageResponse = testCase.sqs.sendMessage(queueUrl = testCase.queueUrl, ...
                messageBody = messageBody, delaySeconds = 5);
            % Verify that the response contains a message ID
            sentMessageId = sendMessageResponse.messageId;
            testCase.verifyNotEmpty(sentMessageId, 'Message ID should not be empty for a successful send.');

            % Receive the Message after sending
            receivedMessageResponse = testCase.sqs.receiveMessage(queueUrl = testCase.queueUrl, ...
                maxNumberOfMessages = 10, waitTimeSeconds = 10, visibilityTimeout = 10);
            testCase.verifyNotEmpty(receivedMessageResponse.messages{1}.messageId, 'Message not received. Message ID empty');

            % Delete the Message after test
            deleteMessageResponse = testCase.sqs.deleteMessage(queueUrl = testCase.queueUrl, ...
                receiptHandle = receivedMessageResponse.messages{1}.receiptHandle);
            testCase.verifyClass(deleteMessageResponse, 'aws.sqs.model.DeleteMessageResponse');

        end

        function testSendMessageExceedsSize(testCase)
            % Test sending a message that exceeds the size limit
            largeMessageBody = repmat('a', 262145, 1); % 262145 bytes

            % Verify that an error is thrown
            testCase.verifyError(@() testCase.sqs.sendMessage(queueUrl='dummy_queue_url', ...
                messageBody = largeMessageBody), 'MATLAB:validation:IncompatibleSize');
        end

        function testListQueuesNoArgs(testCase)

            response = testCase.sqs.listQueues();
            testCase.verifyNotEmpty(response.queueUrls);
            testCase.verifyClass(response, 'aws.sqs.model.ListQueuesResponse');

        end

        function testListQueuesWithInvalidPrefix(testCase)
            % Test listQueues with an invalid queue name prefix
            prefix = 'invalidPrefix';
            response = testCase.sqs.listQueues(queueNamePrefix = prefix);
            testCase.verifyEmpty(response.queueUrls);
        end


        function testListQueues(testCase)
            write(testCase.logObj, 'debug', 'Testing testCreateQueue');

            prefix = "matlab-sqs";

            response = testCase.sqs.listQueues(queueNamePrefix = prefix);
            testCase.verifyNotEmpty(response.queueUrls);
            testCase.verifyClass(response, 'aws.sqs.model.ListQueuesResponse');

        end

        function testGetQueueAttributes(testCase)
            write(testCase.logObj, 'debug', 'Testing testGetQueueAttributes');

            % Define attributes to retrieve
            attributeNames = "All";

            % Retrieve queue attributes
            getQueueAttributesResponse = testCase.sqs.getQueueAttributes(queueUrl = testCase.queueUrl, ...
                attributeNamesWithStrings = attributeNames);

            % Verify the response is not empty and contains expected attributes
            testCase.verifyNotEmpty(getQueueAttributesResponse.attributes);

        end

        function testSetQueueAttributes(testCase)
            write(testCase.logObj, 'debug', 'Testing testSetQueueAttributes');

            % Define new attributes to set
            newAttributes = dictionary('VisibilityTimeout', '45');

            % Set queue attributes
            setQueueAttributesResponse = testCase.sqs.setQueueAttributes(queueUrl = testCase.queueUrl, ...
                attributesWithStrings = newAttributes);

            % Verify the response class
            testCase.verifyClass(setQueueAttributesResponse, 'aws.sqs.model.SetQueueAttributesResponse');

            % Retrieve and verify the updated attributes
            getQueueAttributesResponse = testCase.sqs.getQueueAttributes(queueUrl = testCase.queueUrl, ...
                attributeNamesWithStrings ="VisibilityTimeout");
            testCase.verifyEqual(getQueueAttributesResponse.attributes("VisibilityTimeout"), "45");

        end

    end

    methods (Test, TestTags = {'Unit'})

        function testChangeMessageVisibilitySuccess(testCase)
            % Arrange: send one message
            messageBody = "Visibility change test " + string(datetime);
            sendResp = testCase.sqs.sendMessage( ...
                queueUrl = testCase.queueUrl, messageBody = messageBody);
            testCase.verifyNotEmpty(sendResp.messageId);

            % Receive once to obtain receipt handle (short initial visibility)
            recv1 = testCase.sqs.receiveMessage( ...
                queueUrl = testCase.queueUrl, ...
                maxNumberOfMessages = 1, waitTimeSeconds = 2, visibilityTimeout = 1);
            testCase.verifyNotEmpty(recv1.messages, 'Expected to receive the message');
            rh = recv1.messages{1}.receiptHandle;            

            % Act: extend visibility to 4 seconds
            cmv = testCase.sqs.changeMessageVisibility( ...
                queueUrl = testCase.queueUrl, ...
                receiptHandle = rh, ...
                visibilityTimeout = 1);

            % Assert: response wrapper class + HTTP 200
            testCase.verifyClass(cmv, 'aws.sqs.model.ChangeMessageVisibilityResponse');
            testCase.verifyEqual(double(cmv.statusCode), 200);
        end

        function testChangeMessageVisibilityBatchPartialFailure(testCase)
            % Arrange: one valid + one invalid receipt handle
            s = testCase.sqs.sendMessage(queueUrl = testCase.queueUrl, ...
                messageBody = "Batch partial failure " + string(datetime));
            testCase.verifyNotEmpty(s.messageId);

            recv = testCase.sqs.receiveMessage( ...
                queueUrl = testCase.queueUrl, ...
                maxNumberOfMessages = 1, waitTimeSeconds = 10, visibilityTimeout = 30);
            testCase.verifyNotEmpty(recv.messages);
            validRH = recv.messages{1}.receiptHandle;

            % Build entry objects (second one has bogus handle)
            eOK  = aws.sqs.model.ChangeMessageVisibilityBatchRequestEntry( ...
                id = "ok",  receiptHandle = string(validRH),               visibilityTimeout = int32(10));
            eBad = aws.sqs.model.ChangeMessageVisibilityBatchRequestEntry( ...
                id = "bad", receiptHandle = "bogus-receipt-handle",        visibilityTimeout = int32(10));
            entries = [eOK, eBad];

            % Act
            resp = testCase.sqs.changeMessageVisibilityBatch( ...
                queueUrl = testCase.queueUrl, ...
                entries = entries);

            % Assert: one success, one failure
            testCase.verifyClass(resp, 'aws.sqs.model.ChangeMessageVisibilityBatchResponse');
            testCase.verifyEqual(numel(resp.successful), 1, ...
                'Expected exactly one successful entry');
            testCase.verifyEqual(numel(resp.failed), 1, ...
                'Expected exactly one failed entry (invalid receipt handle)');

        end

    end

end