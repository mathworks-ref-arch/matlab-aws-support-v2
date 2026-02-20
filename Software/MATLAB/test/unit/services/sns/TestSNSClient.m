classdef TestSNSClient < matlab.unittest.TestCase
    % TESTSNSCLIENT Unit Test for the Amazon SNS Client
    %
    % The assertions that you can use in test cases:
    %
    %    verifyClass
    %    verifyNotEmpty
    %    verifyEqual
    %
    % The test suite exercises the basic operations on the SNS Client.

    % Copyright 2025 The MathWorks, Inc.

    properties
        logObj
        sns
        sqs
        isOnGitlab
        topicArn
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

        function initializeSNSClient(testCase)
            region = 'us-east-1';
            if testCase.isOnGitlab
                credentials = loadConfigurationSettings('credentials.json');
                credentialProvider = aws.auth.CredentialProvider.getSessionCredentialProvider(...
                    credentials.aws_access_key_id, credentials.aws_secret_access_key, ...
                    credentials.aws_session_token);
                testCase.sns = aws.sns.Client('credentialsprovider', credentialProvider, ...
                    'region', region);
                testCase.sqs = aws.sqs.Client('credentialsprovider', credentialProvider, ...
                    'region', region);
            else
                testCase.sns = aws.sns.Client('region', region);
                testCase.sqs = aws.sqs.Client('region', region);
            end
        end
        function createSNSTopic(testCase)
            % Create a test topic and store its ARN
            topicName = strcat('matlab-snstest-topic-', ...
                string(datetime('now', 'Format', 'yyyyMMddHHmmssSSS')));
            createTopicResponse= testCase.sns.createTopic(name=topicName);
            testCase.topicArn = createTopicResponse.topicArn;
            testCase.verifyNotEmpty(testCase.topicArn, 'Topic ARN should not be empty after creation.');
        end

        function createSQSQueue(testCase)

            % Create a test queue and store its URL
            queueName = strcat('matlab-snstest-subscriber-queue-', ...
                string(datetime('now', 'Format', 'yyyyMMddHHmmssSSS')), matlabRelease.Release);
            attr = dictionary(["MaximumMessageSize", "DelaySeconds"], ["262144", "5"]);
            createQueueResponse = testCase.sqs.createQueue(queueName = queueName, ...
                attributesWithStrings = attr);
            testCase.verifyNotEmpty(createQueueResponse.queueUrl);
            testCase.queueUrl = createQueueResponse.queueUrl;
        end
    end

    methods(TestClassTeardown)
        function deleteTestTopic(testCase)
            % Delete the test topic after tests
            deleteTopicResponse = testCase.sns.deleteTopic(topicArn=testCase.topicArn);
            testCase.verifyEqual(deleteTopicResponse.statusCode,200,"data type");

        end

        function deleteTestQueue(testCase)
            % Delete the test queue after tests
            deleteQueueResponse = testCase.sqs.deleteQueue('queueUrl', testCase.queueUrl);
            testCase.verifyClass(deleteQueueResponse, 'aws.sqs.model.DeleteQueueResponse');
        end
    end

    methods(Test, TestTags = {'Unit'})

        function testPublishMessageSuccess(testCase)
            % Test publishing a valid message
            message = strcat('Test Message from MATLAB Interface for Amazon SNS : ', string(datetime));

            % Example combining string and binary attributes
            strAttr = aws.sns.model.MessageAttributeValue( ...
                dataType = "String", stringValue = "matlab-service");

            bytes = uint8([1 2 3]);  % or any binary vector
            sdkBytes = aws.core.model.SdkBytes(bytes);
            binAttr = aws.sns.model.MessageAttributeValue( ...
                dataType = "Binary", binaryValue = sdkBytes);

            messageAttributes = dictionary( ...
                ["source","binaryFlag"], [strAttr,     binAttr] );

            % Call the publishMessage function
            write(testCase.logObj, 'verbose', testCase.topicArn);
            testCase.sns.publish(topicArn=testCase.topicArn, message=message, messageAttributes=messageAttributes);

            % Since SNS does not provide a direct way to verify message delivery,
            % we assume no exception means success.
            % Additional checks can be implemented if subscription to the topic is set up.
            testCase.verifyTrue(true, 'Message published successfully.');
        end


        function testListTopics(testCase)
            % Test listing SNS topics
            listTopicsResponse = testCase.sns.listTopics();
            topics=listTopicsResponse.topics;
            testCase.verifyNotEmpty(topics, 'Topic list should not be empty.');
            % Show the listof Arn of topics
            % write(testCase.logObj,'verbose',topics);
            testCase.verifyGreaterThan(size(topics), 0);
        end

        % Test the topic attributes
        function testGetTopicAttributes(testCase)
            disp(testCase.topicArn);
            topicAttributesResonse = testCase.sns.getTopicAttributes(topicArn=testCase.topicArn);
            % disp(topicAttributesResponse.attributes);
            testCase.verifyNotEmpty(topicAttributesResonse.attributes);

        end


        function testSubscriptionCycle(testCase)
            protocol = "sqs";
            % Get QueueArn from SQS
            attrResp = testCase.sqs.getQueueAttributes(queueUrl=testCase.queueUrl, ...
                attributeNamesWithStrings="QueueArn");
            endpoint = attrResp.attributes("QueueArn");

            write(testCase.logObj,"verbose", "Subscription Testing");
            subscribeResponse = testCase.sns.subscribe(topicArn=testCase.topicArn,protocol=protocol,endpoint=endpoint);
            %Verify the subscriptionArn is not empty to pass
            testCase.verifyNotEmpty(subscribeResponse.subscriptionArn);
            subscriptionArn = subscribeResponse.subscriptionArn;

            %Test subscription attributes
            getSubscriptionAttributesResponse = testCase.sns.getSubscriptionAttributes(subscriptionArn = subscriptionArn);
            subscriptionAttributes = getSubscriptionAttributesResponse.attributes;
            testCase.verifyNotEmpty(subscriptionAttributes);
            % Test list of subscriptions
            %%
            listSubscriptionResponse = testCase.sns.listSubscriptions();
            testCase.verifyGreaterThan(listSubscriptionResponse.numOfSubscriptions, 0);
            if ~isempty(subscriptionArn)
                unsubscribeResponse = testCase.sns.unsubscribe(subscriptionArn=subscriptionArn);
                testCase.verifyEqual(unsubscribeResponse.statusCode, 200, "Unsubscribe Failed");
            end

        end

        function testConfirmSubscription_InvalidToken_FastFail(testCase)
            % Covers confirmSubscription() without requiring interactive input.
            % We call with a bogus token and assert the Java exception.
            bogusToken = "this-is-not-a-real-token";
            testCase.verifyError(@() testCase.sns.confirmSubscription( ...
                topicArn = testCase.topicArn, token = bogusToken), ...
                'MATLAB:Java:GenericException');
        end

    end
end