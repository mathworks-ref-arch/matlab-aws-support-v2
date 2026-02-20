## 📚 9. MATLAB AWS - API Reference

Classes, methods and functions that include the terms `private` or `internal` in their namespace should not be used directly.
They are subject to change or removal without notice.
The subpackages in the `Modules` directory contain their own `Documentation` directories including API references.

###  🗂️ 9.1 Index

* MATLAB Interface *for AWS*
  * [aws](#aws)
    * [aws.athena](#aws-athena)
      * [aws.athena.model](#aws-athena-model)
        * [aws.athena.model.GetQueryExecutionResponse](#aws-athena-model-getqueryexecutionresponse)

        * [aws.athena.model.GetQueryResultsResponse](#aws-athena-model-getqueryresultsresponse)

        * [aws.athena.model.QueryExecutionContext](#aws-athena-model-queryexecutioncontext)

        * [aws.athena.model.ResultConfiguration](#aws-athena-model-resultconfiguration)

        * [aws.athena.model.StartQueryExecutionResponse](#aws-athena-model-startqueryexecutionresponse)

        * [aws.athena.model.StopQueryExecutionResponse](#aws-athena-model-stopqueryexecutionresponse)

      * [aws.athena.Client](#aws-athena-client)

        * [aws.athena.Client.getQueryExecution](#aws-athena-client-getqueryexecution)
        * [aws.athena.Client.getQueryResults](#aws-athena-client-getqueryresults)
        * [aws.athena.Client.initialize](#aws-athena-client-initialize)
        * [aws.athena.Client.startQueryExecution](#aws-athena-client-startqueryexecution)
        * [aws.athena.Client.stopQueryExecution](#aws-athena-client-stopqueryexecution)
    * [aws.auth](#aws-auth)
      * [aws.auth.CredentialProvider](#aws-auth-credentialprovider)

        * [aws.auth.CredentialProvider.getBasicCredentialProvider](#aws-auth-credentialprovider-getbasiccredentialprovider)
        * [aws.auth.CredentialProvider.getDefaultCredentialProvider](#aws-auth-credentialprovider-getdefaultcredentialprovider)
        * [aws.auth.CredentialProvider.getInstanceProfileCredentialProvider](#aws-auth-credentialprovider-getinstanceprofilecredentialprovider)
        * [aws.auth.CredentialProvider.getJsonFileCredentialProvider](#aws-auth-credentialprovider-getjsonfilecredentialprovider)
        * [aws.auth.CredentialProvider.getProfileCredentialProvider](#aws-auth-credentialprovider-getprofilecredentialprovider)
        * [aws.auth.CredentialProvider.getSessionCredentialProvider](#aws-auth-credentialprovider-getsessioncredentialprovider)
        * [aws.auth.CredentialProvider.getWebIdentityCredentialProvider](#aws-auth-credentialprovider-getwebidentitycredentialprovider)
    * [aws.bedrock](#aws-bedrock)
      * [aws.bedrock.runtime](#aws-bedrock-runtime)
        * [aws.bedrock.runtime.model](#aws-bedrock-runtime-model)
          * [aws.bedrock.runtime.model.ConverseResponse](#aws-bedrock-runtime-model-converseresponse)

          * [aws.bedrock.runtime.model.InvokeModelResponse](#aws-bedrock-runtime-model-invokemodelresponse)

          * [aws.bedrock.runtime.model.Message](#aws-bedrock-runtime-model-message)

        * [aws.bedrock.runtime.utils](#aws-bedrock-runtime-utils)
          * [aws.bedrock.runtime.utils.buildModelPayload](#aws-bedrock-runtime-utils-buildmodelpayload)
          * [aws.bedrock.runtime.utils.parseModelResponse](#aws-bedrock-runtime-utils-parsemodelresponse)
        * [aws.bedrock.runtime.Client](#aws-bedrock-runtime-client)

          * [aws.bedrock.runtime.Client.converse](#aws-bedrock-runtime-client-converse)
          * [aws.bedrock.runtime.Client.initialize](#aws-bedrock-runtime-client-initialize)
          * [aws.bedrock.runtime.Client.invokeModel](#aws-bedrock-runtime-client-invokemodel)
    * [aws.core](#aws-core)
      * [aws.core.model](#aws-core-model)
        * [aws.core.model.RequestBody](#aws-core-model-requestbody)

          * [aws.core.model.RequestBody.isValidFile](#aws-core-model-requestbody-isvalidfile)
        * [aws.core.model.SdkBytes](#aws-core-model-sdkbytes)

          * [aws.core.model.SdkBytes.isValidZipFile](#aws-core-model-sdkbytes-isvalidzipfile)
      * [aws.core.BaseClient](#aws-core-baseclient)

        * [aws.core.BaseClient.applyHttpClientBuilder](#aws-core-baseclient-applyhttpclientbuilder)
        * [aws.core.BaseClient.delete](#aws-core-baseclient-delete)
        * [aws.core.BaseClient.initialize](#aws-core-baseclient-initialize)
        * [aws.core.BaseClient.validateRegion](#aws-core-baseclient-validateregion)
    * [aws.dynamodb](#aws-dynamodb)
      * [aws.dynamodb.model](#aws-dynamodb-model)
        * [aws.dynamodb.model.AttributeDefinition](#aws-dynamodb-model-attributedefinition)
        * [aws.dynamodb.model.AttributeValue](#aws-dynamodb-model-attributevalue)
        * [aws.dynamodb.model.BatchWriteItemResponse](#aws-dynamodb-model-batchwriteitemresponse)
        * [aws.dynamodb.model.ConsumedCapacity](#aws-dynamodb-model-consumedcapacity)
        * [aws.dynamodb.model.CreateTableResponse](#aws-dynamodb-model-createtableresponse)
        * [aws.dynamodb.model.DeleteItemResponse](#aws-dynamodb-model-deleteitemresponse)
        * [aws.dynamodb.model.DeleteRequest](#aws-dynamodb-model-deleterequest)
        * [aws.dynamodb.model.DeleteTableResponse](#aws-dynamodb-model-deletetableresponse)
        * [aws.dynamodb.model.DescribeTableResponse](#aws-dynamodb-model-describetableresponse)
        * [aws.dynamodb.model.GetItemResponse](#aws-dynamodb-model-getitemresponse)
        * [aws.dynamodb.model.ItemCollectionMetrics](#aws-dynamodb-model-itemcollectionmetrics)
        * [aws.dynamodb.model.KeySchemaElement](#aws-dynamodb-model-keyschemaelement)
        * [aws.dynamodb.model.ListTablesResponse](#aws-dynamodb-model-listtablesresponse)
        * [aws.dynamodb.model.ProvisionedThroughput](#aws-dynamodb-model-provisionedthroughput)
        * [aws.dynamodb.model.PutItemResponse](#aws-dynamodb-model-putitemresponse)
        * [aws.dynamodb.model.PutRequest](#aws-dynamodb-model-putrequest)
        * [aws.dynamodb.model.QueryResponse](#aws-dynamodb-model-queryresponse)
        * [aws.dynamodb.model.ScanResponse](#aws-dynamodb-model-scanresponse)
        * [aws.dynamodb.model.TableDescription](#aws-dynamodb-model-tabledescription)
        * [aws.dynamodb.model.UpdateItemResponse](#aws-dynamodb-model-updateitemresponse)
        * [aws.dynamodb.model.UpdateTableResponse](#aws-dynamodb-model-updatetableresponse)
        * [aws.dynamodb.model.WriteRequest](#aws-dynamodb-model-writerequest)
      * [aws.dynamodb.Client](#aws-dynamodb-client)

        * [aws.dynamodb.Client.batchWriteItem](#aws-dynamodb-client-batchwriteitem)
        * [aws.dynamodb.Client.createTable](#aws-dynamodb-client-createtable)
        * [aws.dynamodb.Client.deleteItem](#aws-dynamodb-client-deleteitem)
        * [aws.dynamodb.Client.deleteTable](#aws-dynamodb-client-deletetable)
        * [aws.dynamodb.Client.describeTable](#aws-dynamodb-client-describetable)
        * [aws.dynamodb.Client.getItem](#aws-dynamodb-client-getitem)
        * [aws.dynamodb.Client.initialize](#aws-dynamodb-client-initialize)
        * [aws.dynamodb.Client.listTables](#aws-dynamodb-client-listtables)
        * [aws.dynamodb.Client.putItem](#aws-dynamodb-client-putitem)
        * [aws.dynamodb.Client.query](#aws-dynamodb-client-query)
        * [aws.dynamodb.Client.scan](#aws-dynamodb-client-scan)
        * [aws.dynamodb.Client.updateItem](#aws-dynamodb-client-updateitem)
        * [aws.dynamodb.Client.updateTable](#aws-dynamodb-client-updatetable)
    * [aws.ec2](#aws-ec2)
      * [aws.ec2.model](#aws-ec2-model)
      * [aws.ec2.Client](#aws-ec2-client)

        * [aws.ec2.Client.initialize](#aws-ec2-client-initialize)
        * [aws.ec2.Client.startInstance](#aws-ec2-client-startinstance)
        * [aws.ec2.Client.stopInstance](#aws-ec2-client-stopinstance)
    * [aws.ecs](#aws-ecs)
      * [aws.ecs.model](#aws-ecs-model)
        * [aws.ecs.model.AwsVpcConfiguration](#aws-ecs-model-awsvpcconfiguration)

        * [aws.ecs.model.ClusterResponse](#aws-ecs-model-clusterresponse)

        * [aws.ecs.model.ContainerDefinition](#aws-ecs-model-containerdefinition)

        * [aws.ecs.model.LoadBalancers](#aws-ecs-model-loadbalancers)

        * [aws.ecs.model.LogConfiguration](#aws-ecs-model-logconfiguration)

        * [aws.ecs.model.NetworkConfiguration](#aws-ecs-model-networkconfiguration)

        * [aws.ecs.model.PortMapping](#aws-ecs-model-portmapping)

        * [aws.ecs.model.RegisterTaskDefinitionRequest](#aws-ecs-model-registertaskdefinitionrequest)

        * [aws.ecs.model.ServiceResponse](#aws-ecs-model-serviceresponse)

        * [aws.ecs.model.TaskDefinitionResponse](#aws-ecs-model-taskdefinitionresponse)

      * [aws.ecs.Client](#aws-ecs-client)

        * [aws.ecs.Client.createCluster](#aws-ecs-client-createcluster)
        * [aws.ecs.Client.createService](#aws-ecs-client-createservice)
        * [aws.ecs.Client.deleteCluster](#aws-ecs-client-deletecluster)
        * [aws.ecs.Client.deleteService](#aws-ecs-client-deleteservice)
        * [aws.ecs.Client.deleteTaskDefinitions](#aws-ecs-client-deletetaskdefinitions)
        * [aws.ecs.Client.deregisterTaskDefinition](#aws-ecs-client-deregistertaskdefinition)
        * [aws.ecs.Client.initialize](#aws-ecs-client-initialize)
        * [aws.ecs.Client.registerTaskDefinition](#aws-ecs-client-registertaskdefinition)
        * [aws.ecs.Client.updateService](#aws-ecs-client-updateservice)
    * [aws.internal](#aws-internal)
      * [aws.internal.builder](#aws-internal-builder)
        * [aws.internal.builder.build](#aws-internal-builder-build)
        * [aws.internal.builder.buildSdkObjectsFromDictionary](#aws-internal-builder-buildsdkobjectsfromdictionary)
      * [aws.internal.util](#aws-internal-util)
        * [aws.internal.util.javaMapToDictionary](#aws-internal-util-javamaptodictionary)
    * [aws.lambda](#aws-lambda)
      * [aws.lambda.model](#aws-lambda-model)
        * [aws.lambda.model.CreateFunctionResponse](#aws-lambda-model-createfunctionresponse)

        * [aws.lambda.model.DeleteFunctionResponse](#aws-lambda-model-deletefunctionresponse)

        * [aws.lambda.model.FunctionCode](#aws-lambda-model-functioncode)

        * [aws.lambda.model.InvokeFunctionResponse](#aws-lambda-model-invokefunctionresponse)

          * [aws.lambda.model.InvokeFunctionResponse.getPayload](#aws-lambda-model-invokefunctionresponse-getpayload)
      * [aws.lambda.task](#aws-lambda-task)
        * [aws.lambda.task.CompileTask](#aws-lambda-task-compiletask)

          * [aws.lambda.task.CompileTask.compileStandalone](#aws-lambda-task-compiletask-compilestandalone)
        * [aws.lambda.task.DockerTask](#aws-lambda-task-dockertask)

          * [aws.lambda.task.DockerTask.dockerBuild](#aws-lambda-task-dockertask-dockerbuild)
      * [aws.lambda.testutil](#aws-lambda-testutil)
        * [aws.lambda.testutil.DockerBase](#aws-lambda-testutil-dockerbase)

          * [aws.lambda.testutil.DockerBase.forInteractiveUse](#aws-lambda-testutil-dockerbase-forinteractiveuse)
          * [aws.lambda.testutil.DockerBase.startContainer](#aws-lambda-testutil-dockerbase-startcontainer)
          * [aws.lambda.testutil.DockerBase.stopContainer](#aws-lambda-testutil-dockerbase-stopcontainer)
      * [aws.lambda.Client](#aws-lambda-client)

        * [aws.lambda.Client.createFunction](#aws-lambda-client-createfunction)
        * [aws.lambda.Client.deleteFunction](#aws-lambda-client-deletefunction)
        * [aws.lambda.Client.initialize](#aws-lambda-client-initialize)
        * [aws.lambda.Client.invokeFunction](#aws-lambda-client-invokefunction)
    * [aws.polly](#aws-polly)
      * [aws.polly.model](#aws-polly-model)
        * [aws.polly.model.DeleteLexiconResponse](#aws-polly-model-deletelexiconresponse)
        * [aws.polly.model.DescribeVoicesResponse](#aws-polly-model-describevoicesresponse)
        * [aws.polly.model.GetLexiconResponse](#aws-polly-model-getlexiconresponse)
        * [aws.polly.model.PutLexiconResponse](#aws-polly-model-putlexiconresponse)
        * [aws.polly.model.SynthesizeSpeechResponse](#aws-polly-model-synthesizespeechresponse)
        * [aws.polly.model.Voice](#aws-polly-model-voice)
      * [aws.polly.Client](#aws-polly-client)

        * [aws.polly.Client.deleteLexicon](#aws-polly-client-deletelexicon)
        * [aws.polly.Client.describeVoices](#aws-polly-client-describevoices)
        * [aws.polly.Client.getLexicon](#aws-polly-client-getlexicon)
        * [aws.polly.Client.initialize](#aws-polly-client-initialize)
        * [aws.polly.Client.putLexicon](#aws-polly-client-putlexicon)
        * [aws.polly.Client.synthesizeSpeech](#aws-polly-client-synthesizespeech)
    * [aws.redshift](#aws-redshift)
      * [aws.redshift.Client](#aws-redshift-client)

        * [aws.redshift.Client.initialize](#aws-redshift-client-initialize)
    * [aws.redshiftdata](#aws-redshiftdata)
      * [aws.redshiftdata.model](#aws-redshiftdata-model)
        * [aws.redshiftdata.model.ExecuteStatementResponse](#aws-redshiftdata-model-executestatementresponse)

        * [aws.redshiftdata.model.Field](#aws-redshiftdata-model-field)

        * [aws.redshiftdata.model.GetStatementResultResponse](#aws-redshiftdata-model-getstatementresultresponse)

          * [aws.redshiftdata.model.GetStatementResultResponse.getResultSet](#aws-redshiftdata-model-getstatementresultresponse-getresultset)
          * [aws.redshiftdata.model.GetStatementResultResponse.records](#aws-redshiftdata-model-getstatementresultresponse-records)
      * [aws.redshiftdata.Client](#aws-redshiftdata-client)

        * [aws.redshiftdata.Client.executeStatement](#aws-redshiftdata-client-executestatement)
        * [aws.redshiftdata.Client.getStatementResult](#aws-redshiftdata-client-getstatementresult)
        * [aws.redshiftdata.Client.initialize](#aws-redshiftdata-client-initialize)
    * [aws.s3](#aws-s3)
      * [aws.s3.model](#aws-s3-model)
        * [aws.s3.model.AccessControlPolicy](#aws-s3-model-accesscontrolpolicy)

        * [aws.s3.model.CopyObjectResponse](#aws-s3-model-copyobjectresponse)

        * [aws.s3.model.CreateBucketResponse](#aws-s3-model-createbucketresponse)

        * [aws.s3.model.DeleteBucketResponse](#aws-s3-model-deletebucketresponse)

        * [aws.s3.model.DeleteObjectResponse](#aws-s3-model-deleteobjectresponse)

        * [aws.s3.model.FileDownload](#aws-s3-model-filedownload)

        * [aws.s3.model.FileUpload](#aws-s3-model-fileupload)

        * [aws.s3.model.GetBucketAclResponse](#aws-s3-model-getbucketaclresponse)

        * [aws.s3.model.GetObjectAclResponse](#aws-s3-model-getobjectaclresponse)

        * [aws.s3.model.GetObjectResponse](#aws-s3-model-getobjectresponse)

        * [aws.s3.model.Grant](#aws-s3-model-grant)

        * [aws.s3.model.Grantee](#aws-s3-model-grantee)

        * [aws.s3.model.HeadObjectResponse](#aws-s3-model-headobjectresponse)

        * [aws.s3.model.ListBucketsResponse](#aws-s3-model-listbucketsresponse)

        * [aws.s3.model.ListObjectsResponse](#aws-s3-model-listobjectsresponse)

        * [aws.s3.model.Owner](#aws-s3-model-owner)

        * [aws.s3.model.PutBucketAclResponse](#aws-s3-model-putbucketaclresponse)

        * [aws.s3.model.PutBucketPolicyResponse](#aws-s3-model-putbucketpolicyresponse)

        * [aws.s3.model.PutObjectAclResponse](#aws-s3-model-putobjectaclresponse)

        * [aws.s3.model.PutObjectResponse](#aws-s3-model-putobjectresponse)

        * [aws.s3.model.Transfer](#aws-s3-model-transfer)

      * [aws.s3.transfer](#aws-s3-transfer)
        * [aws.s3.transfer.model](#aws-s3-transfer-model)
        * [aws.s3.transfer.TransferManager](#aws-s3-transfer-transfermanager)

          * [aws.s3.transfer.TransferManager.copy](#aws-s3-transfer-transfermanager-copy)
          * [aws.s3.transfer.TransferManager.delete](#aws-s3-transfer-transfermanager-delete)
          * [aws.s3.transfer.TransferManager.downloadDirectory](#aws-s3-transfer-transfermanager-downloaddirectory)
          * [aws.s3.transfer.TransferManager.downloadFile](#aws-s3-transfer-transfermanager-downloadfile)
          * [aws.s3.transfer.TransferManager.initialize](#aws-s3-transfer-transfermanager-initialize)
          * [aws.s3.transfer.TransferManager.uploadDirectory](#aws-s3-transfer-transfermanager-uploaddirectory)
        * [aws.s3.transfer.TransferManager.uploadFile](#aws-s3-transfer-transfermanager-uploadfile)
      * [aws.s3.Client](#aws-s3-client)

        * [aws.s3.Client.copyObject](#aws-s3-client-copyobject)
        * [aws.s3.Client.createBucket](#aws-s3-client-createbucket)
        * [aws.s3.Client.deleteBucket](#aws-s3-client-deletebucket)
        * [aws.s3.Client.deleteBucketPolicy](#aws-s3-client-deletebucketpolicy)
        * [aws.s3.Client.putBucketOwnershipControls](#aws-s3-client-putbucketownershipcontrols)
        * [aws.s3.Client.deleteObject](#aws-s3-client-deleteobject)
        * [aws.s3.Client.getBucketAcl](#aws-s3-client-getbucketacl)
        * [aws.s3.Client.getBucketLocation](#aws-s3-client-getbucketlocation)
        * [aws.s3.Client.getObject](#aws-s3-client-getobject)
        * [aws.s3.Client.getObjectAcl](#aws-s3-client-getobjectacl)
        * [aws.s3.Client.headObject](#aws-s3-client-headobject)
        * [aws.s3.Client.initialize](#aws-s3-client-initialize)
        * [aws.s3.Client.listBuckets](#aws-s3-client-listbuckets)
        * [aws.s3.Client.listObjects](#aws-s3-client-listobjects)
        * [aws.s3.Client.putBucketAcl](#aws-s3-client-putbucketacl)
        * [aws.s3.Client.putBucketPolicy](#aws-s3-client-putbucketpolicy)
        * [aws.s3.Client.putObject](#aws-s3-client-putobject)
        * [aws.s3.Client.putObjectAcl](#aws-s3-client-putobjectacl)
        * [aws.s3.Client.saveS3ResponseInputStreamToFile](#aws-s3-client-saves3responseinputstreamtofile)
    * [aws.secretsmanager](#aws-secretsmanager)
      * [aws.secretsmanager.model](#aws-secretsmanager-model)
        * [aws.secretsmanager.model.CreateSecretResponse](#aws-secretsmanager-model-createsecretresponse)

        * [aws.secretsmanager.model.DeleteSecretResponse](#aws-secretsmanager-model-deletesecretresponse)

        * [aws.secretsmanager.model.GetSecretValueResponse](#aws-secretsmanager-model-getsecretvalueresponse)

        * [aws.secretsmanager.model.ListSecretsResponse](#aws-secretsmanager-model-listsecretsresponse)

        * [aws.secretsmanager.model.RestoreSecretResponse](#aws-secretsmanager-model-restoresecretresponse)

        * [aws.secretsmanager.model.SecretListEntry](#aws-secretsmanager-model-secretlistentry)

        * [aws.secretsmanager.model.UpdateSecretResponse](#aws-secretsmanager-model-updatesecretresponse)

      * [aws.secretsmanager.Client](#aws-secretsmanager-client)

        * [aws.secretsmanager.Client.createSecret](#aws-secretsmanager-client-createsecret)
        * [aws.secretsmanager.Client.deleteSecret](#aws-secretsmanager-client-deletesecret)
        * [aws.secretsmanager.Client.getSecretValue](#aws-secretsmanager-client-getsecretvalue)
        * [aws.secretsmanager.Client.initialize](#aws-secretsmanager-client-initialize)
        * [aws.secretsmanager.Client.listSecrets](#aws-secretsmanager-client-listsecrets)
        * [aws.secretsmanager.Client.restoreSecret](#aws-secretsmanager-client-restoresecret)
        * [aws.secretsmanager.Client.updateSecret](#aws-secretsmanager-client-updatesecret)
    * [aws.sns](#aws-sns)
      * [aws.sns.model](#aws-sns-model)
        * [aws.sns.model.ConfirmSubscriptionResponse](#aws-sns-model-confirmsubscriptionresponse)

        * [aws.sns.model.CreateTopicResponse](#aws-sns-model-createtopicresponse)

        * [aws.sns.model.DeleteTopicResponse](#aws-sns-model-deletetopicresponse)

        * [aws.sns.model.GetSubscriptionAttributesResponse](#aws-sns-model-getsubscriptionattributesresponse)

          * [aws.sns.model.GetSubscriptionAttributesResponse.convertJavaMapToStruct](#aws-sns-model-getsubscriptionattributesresponse-convertjavamaptostruct)
          * [aws.sns.model.GetSubscriptionAttributesResponse.getAttributes](#aws-sns-model-getsubscriptionattributesresponse-getattributes)
        * [aws.sns.model.GetTopicAttributesResponse](#aws-sns-model-gettopicattributesresponse)

        * [aws.sns.model.ListSubscriptionsResponse](#aws-sns-model-listsubscriptionsresponse)

        * [aws.sns.model.ListTopicsResponse](#aws-sns-model-listtopicsresponse)

        * [aws.sns.model.MessageAttributeValue](#aws-sns-model-messageattributevalue)

        * [aws.sns.model.PublishResponse](#aws-sns-model-publishresponse)

        * [aws.sns.model.SubscribeResponse](#aws-sns-model-subscriberesponse)

        * [aws.sns.model.UnsubscribeResponse](#aws-sns-model-unsubscriberesponse)

      * [aws.sns.Client](#aws-sns-client)

        * [aws.sns.Client.confirmSubscription](#aws-sns-client-confirmsubscription)
        * [aws.sns.Client.createTopic](#aws-sns-client-createtopic)
        * [aws.sns.Client.deleteTopic](#aws-sns-client-deletetopic)
        * [aws.sns.Client.getSubscriptionAttributes](#aws-sns-client-getsubscriptionattributes)
        * [aws.sns.Client.getTopicAttributes](#aws-sns-client-gettopicattributes)
        * [aws.sns.Client.initialize](#aws-sns-client-initialize)
        * [aws.sns.Client.listSubscriptions](#aws-sns-client-listsubscriptions)
        * [aws.sns.Client.listTopics](#aws-sns-client-listtopics)
        * [aws.sns.Client.publish](#aws-sns-client-publish)
        * [aws.sns.Client.subscribe](#aws-sns-client-subscribe)
        * [aws.sns.Client.unsubscribe](#aws-sns-client-unsubscribe)
    * [aws.sqs](#aws-sqs)
      * [aws.sqs.model](#aws-sqs-model)
        * [aws.sqs.model.CreateQueueResponse](#aws-sqs-model-createqueueresponse)

        * [aws.sqs.model.DeleteMessageResponse](#aws-sqs-model-deletemessageresponse)

        * [aws.sqs.model.DeleteQueueResponse](#aws-sqs-model-deletequeueresponse)

        * [aws.sqs.model.GetQueueAttributesResponse](#aws-sqs-model-getqueueattributesresponse)

        * [aws.sqs.model.ListQueuesResponse](#aws-sqs-model-listqueuesresponse)

      * [aws.sqs.model.Message](#aws-sqs-model-message)

      * [aws.sqs.model.ReceiveMessageResponse](#aws-sqs-model-receivemessageresponse)

      * [aws.sqs.model.SendMessageResponse](#aws-sqs-model-sendmessageresponse)

      * [aws.sqs.model.SetQueueAttributesResponse](#aws-sqs-model-setqueueattributesresponse)

      * [aws.sqs.model.ChangeMessageVisibilityResponse](#aws-sqs-model-changemessagevisibilityresponse)

      * [aws.sqs.model.ChangeMessageVisibilityBatchResponse](#aws-sqs-model-changemessagevisibilitybatchresponse)

      * [aws.sqs.model.ChangeMessageVisibilityBatchResultEntry](#aws-sqs-model-changemessagevisibilitybatchresultentry)

      * [aws.sqs.model.BatchResultErrorEntry](#aws-sqs-model-batchresulterrorentry)

      * [aws.sqs.Client](#aws-sqs-client)

        * [aws.sqs.Client.createQueue](#aws-sqs-client-createqueue)
        * [aws.sqs.Client.deleteMessage](#aws-sqs-client-deletemessage)
        * [aws.sqs.Client.deleteQueue](#aws-sqs-client-deletequeue)
        * [aws.sqs.Client.getQueueAttributes](#aws-sqs-client-getqueueattributes)
        * [aws.sqs.Client.initialize](#aws-sqs-client-initialize)
        * [aws.sqs.Client.listQueues](#aws-sqs-client-listqueues)
        * [aws.sqs.Client.receiveMessage](#aws-sqs-client-receivemessage)
        * [aws.sqs.Client.sendMessage](#aws-sqs-client-sendmessage)
        * [aws.sqs.Client.setQueueAttributes](#aws-sqs-client-setqueueattributes)
        * [aws.sqs.Client.changeMessageVisibility](#aws-sqs-client-changemessagevisibility)
        * [aws.sqs.Client.changeMessageVisibilityBatch](#aws-sqs-client-changemessagevisibilitybatch)
    * [aws.ssm](#aws-ssm)
      * [aws.ssm.model](#aws-ssm-model)
        * [aws.ssm.model.CreateDocumentResponse](#aws-ssm-model-createdocumentresponse)

        * [aws.ssm.model.DeleteDocumentResponse](#aws-ssm-model-deletedocumentresponse)

        * [aws.ssm.model.DeleteParameterResponse](#aws-ssm-model-deleteparameterresponse)

        * [aws.ssm.model.DocumentDescription](#aws-ssm-model-documentdescription)

        * [aws.ssm.model.GetParameterResponse](#aws-ssm-model-getparameterresponse)

        * [aws.ssm.model.PutParameterResponse](#aws-ssm-model-putparameterresponse)

      * [aws.ssm.Client](#aws-ssm-client)

        * [aws.ssm.Client.createDocument](#aws-ssm-client-createdocument)
        * [aws.ssm.Client.deleteDocument](#aws-ssm-client-deletedocument)
        * [aws.ssm.Client.deleteParameter](#aws-ssm-client-deleteparameter)
        * [aws.ssm.Client.getParameter](#aws-ssm-client-getparameter)
        * [aws.ssm.Client.initialize](#aws-ssm-client-initialize)
        * [aws.ssm.Client.putParameter](#aws-ssm-client-putparameter)
    * [aws.sts](#aws-sts)
      * [aws.sts.model](#aws-sts-model)
        * [aws.sts.model.GetCallerIdentityResponse](#aws-sts-model-getcalleridentityresponse)

      * [aws.sts.Client](#aws-sts-client)

        * [aws.sts.Client.getCallerIdentity](#aws-sts-client-getcalleridentity)
        * [aws.sts.Client.initialize](#aws-sts-client-initialize)
    * [aws.Object](#aws-object)

      * [aws.Object.configProxyHttpClient](#aws-object-configproxyhttpclient)
      * [aws.Object.initializeLogger](#aws-object-initializelogger)
      * [aws.Object.useMATLABProxyPrefs](#aws-object-usematlabproxyprefs)
  * [Logger](#logger)
  * [aws](#aws)
  * [awsCommonRoot](#awscommonroot)
  * [awsRoot](#awsroot)
  * [homedir](#homedir)
  * [isEC2](#isec2)
  * [loadConfigurationSettings](#loadconfigurationsettings)
  * [loadKeyPair](#loadkeypair)
  * [saveKeyPair](#savekeypair)
  * [unlimitedCryptography](#unlimitedcryptography)
  * [writeSTSCredentialsFile](#writestscredentialsfile)

### ❓ 9.2 Help

#### aws

#### aws.athena

#### aws.athena.model

##### aws.athena.model.GetQueryExecutionResponse

Metadata returned by `athena.getQueryExecution`.

| Property | Type | Description |
| --- | --- | --- |
| `queryExecutionId` | string | Unique identifier assigned to the query. |
| `status` | Java object | Raw Athena status object; inspect for advanced troubleshooting. |
| `state` | string | Query execution state such as `SUCCEEDED`, `FAILED`, or `CANCELLED`. |
| `stateChangeReason` | string | Failure text reported by Athena when available. |
| `submissionDateTime` | datetime | UTC timestamp when the query was submitted. |
| `completionDateTime` | datetime | UTC timestamp when the query finished. |

```matlab
resp = athena.getQueryExecution(queryExecutionId="1234-abcd");
fprintf("State: %s (id %s)\n", resp.state, resp.queryExecutionId);
```

##### aws.athena.model.GetQueryResultsResponse

Wrapper for `athena.getQueryResults`.

| Property | Type | Description |
| --- | --- | --- |
| `resultSet` | `software.amazon.awssdk.services.athena.model.ResultSet` | Raw Athena result payload. |
| `nextToken` | string | Pagination token used to fetch the next page. |
| `updateCount` | double | Number of rows updated (DDL/CTAS responses only). |

```matlab
resp = athena.getQueryResults(queryExecutionId="1234-abcd", maxResults=int32(1000));
rows = resp.resultSet.rows();
```

##### aws.athena.model.QueryExecutionContext

Define the database and catalog for a query.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `database` | string | Optional. Database to run the query against. |
| `catalog` | string | Optional. Catalog such as `AwsDataCatalog`. |
| `javaQueryExecutionContext` | Java object | Optional. Provide an existing SDK object instead of building one. |

```matlab
ctx = aws.athena.model.QueryExecutionContext(database="sampledb", catalog="AwsDataCatalog");
```

##### aws.athena.model.ResultConfiguration

Configure the S3 destination and encryption for query results.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `outputLocation` | string | Required. `s3://` URI where Athena writes output. |
| `encryptionConfiguration` | `aws.athena.model.EncryptionConfiguration` \| Java object | Optional. SSE-S3 or SSE-KMS settings. |
| `javaResultConfiguration` | Java object | Optional. Use an existing SDK configuration. |

```matlab
rc = aws.athena.model.ResultConfiguration(outputLocation="s3://bucket/results/");
```

##### aws.athena.model.StartQueryExecutionResponse

Return type for `athena.startQueryExecution`.

| Property | Type | Description |
| --- | --- | --- |
| `queryExecutionId` | string | Identifier assigned to the submitted query. |

##### aws.athena.model.StopQueryExecutionResponse

Response metadata for `athena.stopQueryExecution`.

| Property | Type | Description |
| --- | --- | --- |
| `statusCode` | double | HTTP status code reported by the SDK. |
| `requestId` | string | AWS request identifier for support cases. |
#### aws.athena.Client

Superclass: aws.core.BaseClient

MATLAB client wrapper for the Amazon Athena service. Use this class to
submit SQL statements, poll execution status, and download results.

##### aws.athena.Client.Client

Creates an Amazon Athena client instance.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `region` | string \\| software.amazon.awssdk.regions.Region | Optional. Target AWS Region. |
| `credentialsprovider` | aws.auth.CredentialProvider | Optional. Credential provider returned by `aws.auth.CredentialProvider`. |
| `isCrt` | logical | Optional. Enable the AWS Common Runtime HTTP client when true. |

| Returns | Type | Description |
| --- | --- | --- |
| `athena` | `aws.athena.Client` | Configured MATLAB Athena client. |

```matlab
cred = aws.auth.CredentialProvider.getDefaultCredentialProvider();
athena = aws.athena.Client('region',"us-east-1", 'credentialsprovider', cred);
```

##### aws.athena.Client.getQueryExecution

Retrieve metadata and status for an existing Athena query execution.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `queryExecutionId` | string | Required. Athena query execution identifier. |

| Returns | Type | Description |
| --- | --- | --- |
| `getQueryExecutionResponse` | `aws.athena.model.GetQueryExecutionResponse` | Contains state, timestamps, and status detail. |

```matlab
athena = aws.athena.Client();
resp = athena.getQueryExecution(queryExecutionId="1234abcd-5678-efgh");
disp(resp.state)
```

##### aws.athena.Client.getQueryResults

Fetch result rows for a query execution, with optional pagination controls.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `queryExecutionId` | string | Required. Athena query execution identifier. |
| `maxResults` | int32 | Optional. Maximum number of rows per page. |
| `nextToken` | string | Optional. Pagination token from a prior call. |

| Returns | Type | Description |
| --- | --- | --- |
| `getQueryResultsResponse` | `aws.athena.model.GetQueryResultsResponse` | Contains the result set and pagination metadata. |

```matlab
resp = athena.getQueryResults(queryExecutionId="1234-abcd", maxResults=int32(1000));
rows = resp.resultSet.rows();
```

##### aws.athena.Client.initialize

```text
aws.athena.Client/initialize is a function.
    initStat = initialize(obj, regionObj, credentialsProvider)
```

##### aws.athena.Client.startQueryExecution

Submit a SQL statement for execution in Amazon Athena.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `queryString` | string | Required. SQL statement to execute. |
| `resultConfiguration` | `aws.athena.model.ResultConfiguration` | Required. Output location and encryption settings. |
| `queryExecutionContext` | `aws.athena.model.QueryExecutionContext` | Optional. Database/catalog selection. |
| `clientRequestToken` | string | Optional. Idempotency token. |
| `workGroup` | string | Optional. Workgroup name. |

| Returns | Type | Description |
| --- | --- | --- |
| `startQueryExecutionResponse` | `aws.athena.model.StartQueryExecutionResponse` | Contains the new `queryExecutionId`. |

```matlab
rc = aws.athena.model.ResultConfiguration(outputLocation="s3://bucket/results/");
resp = athena.startQueryExecution(queryString="SELECT 1", resultConfiguration=rc);
disp(resp.queryExecutionId)
```

##### aws.athena.Client.stopQueryExecution

Stop a running query execution in Amazon Athena.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `queryExecutionId` | string | Required. Identifier of the query to cancel. |

| Returns | Type | Description |
| --- | --- | --- |
| `stopQueryExecutionResponse` | `aws.athena.model.StopQueryExecutionResponse` | HTTP metadata confirming the stop request. |

```matlab
resp = athena.stopQueryExecution(queryExecutionId="your-query-id");
disp(resp.statusCode);
```

#### aws.auth

#### aws.auth.CredentialProvider

Superclass: handle

Factory methods for constructing AWS SDK for Java v2 credential providers
that can be passed to MATLAB AWS clients via the `credentialsprovider`
Name-Value argument.

##### aws.auth.CredentialProvider.CredentialProvider

`aws.auth.CredentialProvider` exposes static helper methods; there is no
need to instantiate this class directly.

##### aws.auth.CredentialProvider.getDefaultCredentialProvider

Discover credentials and region using the AWS SDK default chain.

| Returns | Type | Description |
| --- | --- | --- |
| `credProv` | `software.amazon.awssdk.auth.credentials.DefaultCredentialsProvider` | Provider that searches env vars, shared config, process credentials, and metadata services. |
| `awsRegion` | string | Region resolved by `DefaultAwsRegionProviderChain`. |

```matlab
[cp, region] = aws.auth.CredentialProvider.getDefaultCredentialProvider();
s3 = aws.s3.Client('region', region, 'credentialsprovider', cp);
```

##### aws.auth.CredentialProvider.getProfileCredentialProvider

Load credentials from a named profile in `~/.aws/credentials` or
`~/.aws/config`. Supports IAM Identity Center (SSO) profiles after you run
`aws sso login`.

| Positional Argument | Type | Description |
| --- | --- | --- |
| `profile` | string | Optional. Profile name. Defaults to `"default"`. |

| Returns | Type | Description |
| --- | --- | --- |
| `credProv` | `software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider` | Provider backed by the requested shared-config profile. |

```matlab
cp = aws.auth.CredentialProvider.getProfileCredentialProvider("analytics");
sqs = aws.sqs.Client('credentialsprovider', cp);
```

##### aws.auth.CredentialProvider.getInstanceProfileCredentialProvider

Use credentials supplied by the EC2 instance profile or ECS task role.

| Returns | Type | Description |
| --- | --- | --- |
| `credProv` | `software.amazon.awssdk.auth.credentials.InstanceProfileCredentialsProvider` | Retrieves temporary credentials from IMDS/ECS metadata. |

##### aws.auth.CredentialProvider.getBasicCredentialProvider

Wrap a long-lived Access Key ID and Secret Access Key.

| Positional Argument | Type | Description |
| --- | --- | --- |
| `awsID` | string | Required. IAM Access Key ID. |
| `awsKey` | string | Required. IAM Secret Access Key. |

| Returns | Type | Description |
| --- | --- | --- |
| `credProv` | `software.amazon.awssdk.auth.credentials.StaticCredentialsProvider` | Static credentials; avoid for production workloads when roles are available. |

```matlab
cp = aws.auth.CredentialProvider.getBasicCredentialProvider("AKIA...", "SECRET...");
```

##### aws.auth.CredentialProvider.getSessionCredentialProvider

Package temporary credentials (STS, federation, or custom SSO) into a
StaticCredentialsProvider.

| Positional Argument | Type | Description |
| --- | --- | --- |
| `awsID` | string | Required. Access Key ID. |
| `awsKey` | string | Required. Secret Access Key. |
| `awsSessionToken` | string | Required. Session token. |

| Returns | Type | Description |
| --- | --- | --- |
| `credProv` | `software.amazon.awssdk.auth.credentials.StaticCredentialsProvider` | Provider containing the supplied session credentials. |

##### aws.auth.CredentialProvider.getWebIdentityCredentialProvider

Assume a role using `AWS_ROLE_ARN`, `AWS_WEB_IDENTITY_TOKEN_FILE`, and
optional `AWS_ROLE_SESSION_NAME`.

| Returns | Type | Description |
| --- | --- | --- |
| `credProv` | `software.amazon.awssdk.auth.credentials.WebIdentityTokenFileCredentialsProvider` | Exchanges a web identity token (e.g., EKS IRSA) for temporary credentials. |

##### aws.auth.CredentialProvider.getJsonFileCredentialProvider

Read credentials (and optional region) from a simple JSON file.

| Positional Argument | Type | Description |
| --- | --- | --- |
| `jsonFile` | string | Required. Path to a JSON file containing the credential fields. |

| Returns | Type | Description |
| --- | --- | --- |
| `credProv` | `software.amazon.awssdk.auth.credentials.StaticCredentialsProvider` | Static or session provider depending on whether `aws_session_token` is present. |
| `awsRegion` | string | Region from the JSON if provided; otherwise empty string. |

Example JSON:

```json
{
  "aws_access_key_id": "AKIA...",
  "aws_secret_access_key": "SECRET...",
  "aws_session_token": "TOKEN...",
  "region": "us-west-2"
}
```

```matlab
[cp, region] = aws.auth.CredentialProvider.getJsonFileCredentialProvider("creds.json");
polly = aws.polly.Client('region', region, 'credentialsprovider', cp);
```

#### aws.bedrock

#### aws.bedrock.runtime

#### aws.bedrock.runtime.model

#### aws.bedrock.runtime.model.ConverseResponse

Superclass: aws.Object

```text
CONVERSERESPONSE is the response sent from Bedrock Converse
  Service.
```

##### aws.bedrock.runtime.model.ConverseResponse.ConverseResponse

```text
CONVERSERESPONSE is the response sent from Bedrock Converse
  Service.
```

#### aws.bedrock.runtime.model.InvokeModelResponse

Superclass: aws.Object

```text
INVOKEMODELREQUEST is the request class to invoke a bedrock runtime
 model.
```

##### aws.bedrock.runtime.model.InvokeModelResponse.InvokeModelResponse

```text
INVOKEMODELREQUEST is the request class to invoke a bedrock runtime
 model.
```

#### aws.bedrock.runtime.model.Message

Superclass: aws.Object

```text
CONVERSEMESSAGE Represents the Message sent in Bedrock Converse
  Service. The Conversation history (state) of the message should be
  maintained at the client side.
 
  This is applicable only for Bedrock Runtime converse API
```

##### aws.bedrock.runtime.model.Message.Message

```text
CONVERSEMESSAGE Represents the Message sent in Bedrock Converse
  Service. The Conversation history (state) of the message should be
  maintained at the client side.
 
  This is applicable only for Bedrock Runtime converse API
```

#### aws.bedrock.runtime.utils

#### aws.bedrock.runtime.utils.buildModelPayload

Construct a JSON payload for `invokeModel`.

| Input | Type | Description |
| --- | --- | --- |
| `modelId` | string | Required. Bedrock model identifier. |
| `payloadSpec` | string \\| struct \\| dictionary | Required. Prompt text, raw JSON, or structured payload. |

| Returns | Type | Description |
| --- | --- | --- |
| `jsonString` | char | JSON payload suitable for `invokeModel`. |

```matlab
json = aws.bedrock.runtime.utils.buildModelPayload("amazon.titan-text-lite-v1", "Hello?");
spec = struct(text="Describe a sunset", seed=42, style="photorealistic");
jsonImg = aws.bedrock.runtime.utils.buildModelPayload("amazon.titan-image-generator-v1", spec);
```

#### aws.bedrock.runtime.utils.parseModelResponse

```text
PARSEMODELRESPONSE Parses the model-specific response into a standard format.
    modelId: Identifier for the model.
    responseBody: The raw response body from the model.
```

#### aws.bedrock.runtime.Client

Superclass: aws.core.BaseClient

MATLAB client for the Amazon Bedrock Runtime service.

##### aws.bedrock.runtime.Client.Client

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `region` | string \\| software.amazon.awssdk.regions.Region | Optional. Target Region (defaults to shared config). |
| `credentialsprovider` | aws.auth.CredentialProvider | Optional. Custom credential source. |
| `isCrt` | logical | Optional. Use the AWS Common Runtime HTTP client when true. |

```matlab
bedrock = aws.bedrock.runtime.Client('region',"us-east-1");
```

##### aws.bedrock.runtime.Client.converse

Send a sequence of messages to a chat-capable foundation model.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `modelId` | string | Required. Model identifier. |
| `messages` | aws.bedrock.runtime.model.Message vector | Required. Conversation turns (user/assistant). |
| `maxTokens` | int32 | Optional. Max tokens in the response (default 512). |
| `temperature` | single | Optional. Sampling temperature in [0,1]. |
| `topP` | single | Optional. Nucleus sampling parameter in [0,1]. |

| Returns | Type | Description |
| --- | --- | --- |
| `response` | `aws.bedrock.runtime.model.ConverseResponse` | Assistant message, stop reason, and usage info. |

```matlab
msgs = aws.bedrock.runtime.model.Message.empty;
msgs(end+1) = aws.bedrock.runtime.model.Message(text="Hello?", role="user");
resp = bedrock.converse(modelId="amazon.titan-text-lite-v1", messages=msgs);
```

##### aws.bedrock.runtime.Client.initialize

```text
aws.bedrock.runtime.Client/initialize is a function.
    initStat = initialize(obj, regionObj, credentialsProvider)
```

##### aws.bedrock.runtime.Client.invokeModel

Invoke a Bedrock model with either a text prompt or structured payload.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `modelId` | string | Required. Model identifier. |
| `body` | string \\| struct \\| dictionary | Required. Text prompt, raw JSON, or payload fields. |
| `accept` | string | Optional. Desired response MIME type (default `application/json`). |
| `contentType` | string | Optional. Request content type (default `application/json`). |
| `guardrailIdentifier` | string | Optional. Guardrail ID. |
| `guardrailVersion` | string | Optional. Guardrail version. |
| `trace` | string | Optional. Trace configuration. |

| Returns | Type | Description |
| --- | --- | --- |
| `response` | `aws.bedrock.runtime.model.InvokeModelResponse` | Model output along with token usage. |

```matlab
resp = bedrock.invokeModel(modelId="amazon.titan-text-express-v1", body="Summarize this paragraph.");
```

#### aws.core

#### aws.core.model

#### aws.core.model.RequestBody

##### aws.core.model.RequestBody.RequestBody

Wrap strings, file paths, byte arrays, or existing SDK objects into an AWS `RequestBody`.

| Positional Argument | Type | Description |
| --- | --- | --- |
| `payload` | string | Provide literal text to send. If the string resolves to a file path the file contents are streamed. |
| `payload` | `uint8` \| `int8` array | Send binary data directly. |
| `payload` | `software.amazon.awssdk.core.sync.RequestBody` | Wrap an existing Java RequestBody instance. |

```matlab
body = aws.core.model.RequestBody("Hello from MATLAB");
fileBody = aws.core.model.RequestBody("/tmp/data.bin");
```

##### aws.core.model.RequestBody.isValidFile

Determine whether a string input refers to a readable file on disk.

| Positional Argument | Type | Description |
| --- | --- | --- |
| `filePath` | string | Path to test. |

| Returns | Type | Description |
| --- | --- | --- |
| `tf` | logical | `true` when the file exists. |
#### aws.core.model.SdkBytes

Superclass: aws.Object

```text
SDKBYTES model class of AWS SDKBytes class
```

##### aws.core.model.SdkBytes.SdkBytes

```text
SDKBYTES model class of AWS SDKBytes class
```

##### aws.core.model.SdkBytes.isValidZipFile

```text
ISVALIDZIPFILE Checks if the given input is a valid path to a ZIP file.
```

#### aws.core.BaseClient

Superclass: aws.Object

```text
BASECLIENT Abstract base class for AWS service clients.
  Provides shared functionality for initializing AWS clients.
```

##### aws.core.BaseClient.BaseClient

```text
Initialize logger
```

##### aws.core.BaseClient.applyHttpClientBuilder

```text
aws.core.BaseClient/applyHttpClientBuilder is a function.
    builder = applyHttpClientBuilder(obj, builder, options)
```

##### aws.core.BaseClient.delete

```text
DELETE   Delete a handle object.
    DELETE(H) deletes all handle objects in array H. After the delete 
    function call, H is an array of invalid objects.
 
    See also AWS.CORE.BASECLIENT, AWS.CORE.BASECLIENT/ISVALID, CLEAR

Help for aws.core.BaseClient/delete is inherited from superclass handle
```

##### aws.core.BaseClient.initialize

```text
aws.core.BaseClient/initialize is a function.
    obj = aws.core.BaseClient
```

##### aws.core.BaseClient.validateRegion

```text
aws.core.BaseClient/validateRegion is a function.
    regionObj = validateRegion(~, region, serviceId)
```

#### aws.dynamodb

#### aws.dynamodb.model

##### aws.dynamodb.model.AttributeDefinition

Define an attribute that participates in a table or index schema.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `attributeName` | string | Required. Attribute name. |
| `attributeType` | string | Required. One of `"S"`, `"N"`, or `"B"`. |

```matlab
attrDef = aws.dynamodb.model.AttributeDefinition(attributeName="pk", attributeType="S");
```

##### aws.dynamodb.model.AttributeValue

Represents a DynamoDB attribute payload in any of the supported shapes.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `s` | string | String value. |
| `n` | string | Numeric value expressed as text. |
| `b` | uint8 vector \\| aws.core.model.SdkBytes | Binary value. |
| `ss` | string array | String set. |
| `ns` | string array | Number set (stored as strings). |
| `bs` | cell | Binary set. |
| `m` | dictionary | Map of `string -> AttributeValue`. |
| `bool` | logical | Boolean value. |
| `nul` | logical | Set `true` to represent NULL. |
| `attributeValue` | Java object | Wrap an existing SDK AttributeValue handle. |

Exactly one of the shape arguments must be supplied (unless `attributeValue` is provided).

```matlab
val = aws.dynamodb.model.AttributeValue(s="user#123");
```

**Method** `AttributeValue.getValue` — returns the MATLAB representation based on the stored shape.

##### aws.dynamodb.model.BatchWriteItemResponse

Response wrapper returned by `batchWriteItem`.

| Property | Type | Description |
| --- | --- | --- |
| `unprocessedItems` | dictionary | Map of table name -> cell array of `aws.dynamodb.model.WriteRequest` objects that must be retried. |
| `consumedCapacity` | cell | Cell array of `aws.dynamodb.model.ConsumedCapacity` entries (one per table/index). |

```matlab
resp = ddb.batchWriteItem(requestItems=reqs);
cellfun(@numel, values(resp.unprocessedItems));
```

##### aws.dynamodb.model.ConsumedCapacity

Describes capacity units consumed by an operation (when `returnConsumedCapacity` is requested).

| Property | Type | Description |
| --- | --- | --- |
| `capacityUnits` | double | Total units consumed. |
| `readCapacityUnits` | double | Read units consumed. |
| `writeCapacityUnits` | double | Write units consumed. |
| `tableName` | string | Table name associated with the measurement. |
| `tableCapacityUnits` | double | Capacity attributable to the table (excludes indexes). |
| `tableReadCapacityUnits` | double | Read units consumed by the table. |
| `tableWriteCapacityUnits` | double | Write units consumed by the table. |

##### aws.dynamodb.model.CreateTableResponse

| Property | Type | Description |
| --- | --- | --- |
| `tableDescription` | `aws.dynamodb.model.TableDescription` | Description of the newly created table. |

##### aws.dynamodb.model.DeleteItemResponse

| Property | Type | Description |
| --- | --- | --- |
| `attributes` | dictionary | Attribute map returned when `ReturnValues` is specified. |
| `consumedCapacity` | `aws.dynamodb.model.ConsumedCapacity` | Capacity metrics (when requested). |

##### aws.dynamodb.model.DeleteRequest

Constructs a delete request payload for `batchWriteItem`.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `key` | dictionary | Required. Primary key map of `aws.dynamodb.model.AttributeValue` objects. |

##### aws.dynamodb.model.DeleteTableResponse

| Property | Type | Description |
| --- | --- | --- |
| `tableDescription` | `aws.dynamodb.model.TableDescription` | Metadata for the deleted table. |

##### aws.dynamodb.model.DescribeTableResponse

| Property | Type | Description |
| --- | --- | --- |
| `table` | `aws.dynamodb.model.TableDescription` | Full table description. |

##### aws.dynamodb.model.GetItemResponse

| Property | Type | Description |
| --- | --- | --- |
| `item` | dictionary | Retrieved item attributes (string -> AttributeValue). |
| `consumedCapacity` | `aws.dynamodb.model.ConsumedCapacity` | Capacity metrics when requested. |

##### aws.dynamodb.model.ItemCollectionMetrics

| Property | Type | Description |
| --- | --- | --- |
| `itemCollectionKey` | dictionary | Partition key of the affected item collection. |
| `sizeEstimateRangeGB` | double array | Lower/upper estimate of collection size (GB). |

##### aws.dynamodb.model.KeySchemaElement

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `attributeName` | string | Required. Attribute participating in the key. |
| `keyType` | string | Key role (`"HASH"` or `"RANGE"`). |

##### aws.dynamodb.model.ListTablesResponse

| Property | Type | Description |
| --- | --- | --- |
| `tableNames` | string array | Table names returned in the page. |
| `lastEvaluatedTableName` | string | Continuation token (empty when finished). |

##### aws.dynamodb.model.ProvisionedThroughput

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `readCapacityUnits` | int64 | Required. Provisioned read capacity. |
| `writeCapacityUnits` | int64 | Required. Provisioned write capacity. |

##### aws.dynamodb.model.PutItemResponse

| Property | Type | Description |
| --- | --- | --- |
| `attributes` | dictionary | Attribute map returned when `ReturnValues` is set. |
| `consumedCapacity` | `aws.dynamodb.model.ConsumedCapacity` | Capacity metrics when requested. |

##### aws.dynamodb.model.PutRequest

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `item` | dictionary | Required. Attribute map used for batch puts. |

##### aws.dynamodb.model.QueryResponse

| Property | Type | Description |
| --- | --- | --- |
| `items` | cell | Each cell is a dictionary describing one result item. |
| `consumedCapacity` | `aws.dynamodb.model.ConsumedCapacity` | Capacity metrics when requested. |
| `count` | int32 | Number of matching items returned. |
| `scannedCount` | int32 | Number of items evaluated before filters. |

##### aws.dynamodb.model.ScanResponse

| Property | Type | Description |
| --- | --- | --- |
| `items` | cell | Dictionary-per-item describing the scan results. |
| `count` | int32 | Number of items returned after filters. |
| `scannedCount` | int32 | Total items evaluated. |
| `lastEvaluatedKey` | dictionary | Pagination token for continued scans. |
| `consumedCapacity` | `aws.dynamodb.model.ConsumedCapacity` | Capacity metrics when requested. |

##### aws.dynamodb.model.TableDescription

| Property | Type | Description |
| --- | --- | --- |
| `tableName` | string | Table name. |
| `tableId` | string | Unique identifier assigned by DynamoDB. |
| `tableArn` | string | Amazon Resource Name. |
| `itemCount` | int64 | Approximate item count. |
| `tableStatus` | string | `"CREATING"`, `"ACTIVE"`, etc. |
| `creationDateTime` | datetime | Table creation time. |
| `provisionedThroughput` | `aws.dynamodb.model.ProvisionedThroughput` | Current provisioned throughput snapshot. |

##### aws.dynamodb.model.UpdateItemResponse

| Property | Type | Description |
| --- | --- | --- |
| `attributes` | dictionary | Attribute map returned via `ReturnValues`. |
| `consumedCapacity` | `aws.dynamodb.model.ConsumedCapacity` | Capacity metrics when requested. |
| `itemCollectionMetrics` | `aws.dynamodb.model.ItemCollectionMetrics` | Size metrics for the affected collection. |

##### aws.dynamodb.model.UpdateTableResponse

| Property | Type | Description |
| --- | --- | --- |
| `tableDescription` | `aws.dynamodb.model.TableDescription` | Updated table metadata. |

##### aws.dynamodb.model.WriteRequest

Represents a single put or delete entry within `batchWriteItem`. Exactly one of `putRequest` or `deleteRequest` may be supplied.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `putRequest` | `aws.dynamodb.model.PutRequest` | Optional. Item to put. |
| `deleteRequest` | `aws.dynamodb.model.DeleteRequest` | Optional. Item to delete. |


#### aws.dynamodb.Client

Superclass: aws.core.BaseClient

Interact with Amazon DynamoDB tables using the MATLAB wrappers over the AWS SDK v2 client.

```matlab
ddb = aws.dynamodb.Client();
desc = ddb.describeTable(tableName="MyTable");
```

##### aws.dynamodb.Client.Client

Construct a DynamoDB client instance.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `'region'` | string | Optional region override (defaults to the shared credential provider region). |
| `'credentialsprovider'` | aws.auth.CredentialProvider | Optional credential source. |
| `'isCrt'` | logical | Optional. `true` uses the AWS Common Runtime HTTP client. |

| Returns | Type | Description |
| --- | --- | --- |
| `ddb` | `aws.dynamodb.Client` | Client configured for the specified region. |

```matlab
ddb = aws.dynamodb.Client('region',"us-east-1");
```

##### aws.dynamodb.Client.batchWriteItem

Write multiple items across one or more tables.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `requestItems` | dictionary | Required. Map of table name (string) to a vector/cell array of `aws.dynamodb.model.WriteRequest` objects (max 25 combined per call). |

| Returns | Type | Description |
| --- | --- | --- |
| `batchWriteItemResponse` | `aws.dynamodb.model.BatchWriteItemResponse` | Provides the per-table `unprocessedItems` map plus optional consumed capacity metrics. |

```matlab
ddb = aws.dynamodb.Client();
body = dictionary("pk", aws.dynamodb.model.AttributeValue(s="order#1"));
putReq = aws.dynamodb.model.PutRequest(item=body);
writeReq = aws.dynamodb.model.WriteRequest(putRequest=putReq);
reqs = dictionary("Orders", [writeReq]);
resp = ddb.batchWriteItem(requestItems=reqs);
```

##### aws.dynamodb.Client.createTable

Create a DynamoDB table.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `tableName` | string | Required. Table name. |
| `keySchema` | array | Required. Array of `aws.dynamodb.model.KeySchemaElement`. |
| `attributeDefinitions` | array | Required. Array of `aws.dynamodb.model.AttributeDefinition`. |
| `provisionedThroughput` | `aws.dynamodb.model.ProvisionedThroughput` | Required. Read/write capacity settings. |

| Returns | Type | Description |
| --- | --- | --- |
| `createTableResponse` | `aws.dynamodb.model.CreateTableResponse` | Table description and status. |

```matlab
ddb = aws.dynamodb.Client();
ks  = aws.dynamodb.model.KeySchemaElement(attributeName="pk", keyType="HASH");
ad  = aws.dynamodb.model.AttributeDefinition(attributeName="pk", attributeType="S");
pt  = aws.dynamodb.model.ProvisionedThroughput(readCapacityUnits=int64(5), writeCapacityUnits=int64(5));
resp = ddb.createTable(tableName="MyTable", keySchema=ks, attributeDefinitions=ad, provisionedThroughput=pt);
```

##### aws.dynamodb.Client.deleteItem

Delete an item from a DynamoDB table.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `tableName` | string | Required. DynamoDB table name. |
| `key` | dictionary \\| struct | Required. Primary key map of `aws.dynamodb.model.AttributeValue` objects. |

| Returns | Type | Description |
| --- | --- | --- |
| `deleteItemResponse` | `aws.dynamodb.model.DeleteItemResponse` | Contains consumed capacity and optional return values. |

```matlab
ddb = aws.dynamodb.Client();
key = dictionary("pk", aws.dynamodb.model.AttributeValue(s="user#123"));
resp = ddb.deleteItem(tableName="users", key=key);
```

##### aws.dynamodb.Client.deleteTable

Delete a DynamoDB table.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `tableName` | string | Required. Table to delete. |

| Returns | Type | Description |
| --- | --- | --- |
| `deleteTableResponse` | `aws.dynamodb.model.DeleteTableResponse` | Contains table status and metadata. |

```matlab
ddb = aws.dynamodb.Client();
resp = ddb.deleteTable(tableName="users");
```

##### aws.dynamodb.Client.describeTable

Retrieve metadata for a DynamoDB table.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `tableName` | string | Required. Table name to describe. |

| Returns | Type | Description |
| --- | --- | --- |
| `describeTableResponse` | `aws.dynamodb.model.DescribeTableResponse` | Contains status, key schema, throughput, etc. |

```matlab
ddb = aws.dynamodb.Client();
resp = ddb.describeTable(tableName="users");
disp(resp.table.tableStatus);
```

##### aws.dynamodb.Client.getItem

Retrieve a single item from a DynamoDB table.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `tableName` | string | Required. DynamoDB table name. |
| `key` | dictionary \\| struct | Required. Primary key map of `aws.dynamodb.model.AttributeValue` objects. |

| Returns | Type | Description |
| --- | --- | --- |
| `getItemResponse` | `aws.dynamodb.model.GetItemResponse` | Contains the item attributes plus consumed capacity metadata. |

```matlab
ddb = aws.dynamodb.Client();
key = dictionary("pk", aws.dynamodb.model.AttributeValue(s="user#123"));
resp = ddb.getItem(tableName="users", key=key);
```

##### aws.dynamodb.Client.initialize

```text
aws.dynamodb.Client/initialize is a function.
    initStat = initialize(obj, regionObj, credentialsProvider)
```

##### aws.dynamodb.Client.listTables

List table names in the current AWS account/Region.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `limit` | double | Optional. Maximum number of table names to return. |

| Returns | Type | Description |
| --- | --- | --- |
| `listTablesResponse` | `aws.dynamodb.model.ListTablesResponse` | Table names and continuation token. |

```matlab
ddb = aws.dynamodb.Client();
resp = ddb.listTables(limit=10);
disp(resp.tableNames);
```

##### aws.dynamodb.Client.putItem

Insert or replace an item in a DynamoDB table.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `tableName` | string | Required. DynamoDB table name. |
| `item` | dictionary \\| struct | Required. Attribute map built with `aws.dynamodb.model.AttributeValue`. |

| Returns | Type | Description |
| --- | --- | --- |
| `putItemResponse` | `aws.dynamodb.model.PutItemResponse` | Response metadata such as consumed capacity. |

```matlab
ddb = aws.dynamodb.Client();
item = dictionary( ...
    ["pk","sk","name"], ...
    [aws.dynamodb.model.AttributeValue(s="user#123"), ...
     aws.dynamodb.model.AttributeValue(s="profile"), ...
     aws.dynamodb.model.AttributeValue(s="Ada Lovelace")]);
resp = ddb.putItem(tableName="users", item=item);
```

##### aws.dynamodb.Client.query

Run a key-condition query against a DynamoDB table.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `tableName` | string | Required. DynamoDB table name. |
| `keyConditionExpression` | string | Required. Expression using the partition key (and optional sort key). |
| `expressionAttributeValues` | dictionary \\| struct | Optional. AttributeValue map referenced by the expression. |

| Returns | Type | Description |
| --- | --- | --- |
| `queryResponse` | `aws.dynamodb.model.QueryResponse` | Matching items, consumed capacity, and pagination tokens. |

```matlab
ddb = aws.dynamodb.Client();
vals = dictionary(":pk", aws.dynamodb.model.AttributeValue(s="user#123"));
resp = ddb.query(tableName="users", keyConditionExpression="pk = :pk", expressionAttributeValues=vals);
disp(resp.count);
```

##### aws.dynamodb.Client.scan

Scan a table with optional filter and projection expressions.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `tableName` | string | Required. Table to scan. |
| `filterExpression` | string | Optional. Filter applied after the scan. |
| `expressionAttributeValues` | dictionary | Optional. Map of tokens (e.g., `:prefix`) to `aws.dynamodb.model.AttributeValue`. |
| `expressionAttributeNames` | dictionary | Optional. Map of tokens (e.g., `#pk`) to attribute names referenced by the filter/projection. |
| `projectionExpression` | string | Optional. Expression that narrows the attributes returned. |
| `limit` | double | Optional. Positive integer cap on the number of items returned. |
| `consistentRead` | logical | Optional. true requests strongly consistent reads. |
| `exclusiveStartKey` | dictionary | Optional. Pagination token (`lastEvaluatedKey`) from a prior scan. |

| Returns | Type | Description |
| --- | --- | --- |
| `scanResponse` | `aws.dynamodb.model.ScanResponse` | Items returned, consumed capacity, and `lastEvaluatedKey` for pagination. |

```matlab
ddb = aws.dynamodb.Client();
vals = dictionary(":prefix", aws.dynamodb.model.AttributeValue(s="user#"));
resp = ddb.scan(tableName="users", filterExpression="begins_with(pk, :prefix)", ...
    expressionAttributeValues=vals, limit=25);
while ~isempty(resp.lastEvaluatedKey)
    resp = ddb.scan(tableName="users", exclusiveStartKey=resp.lastEvaluatedKey);
end
```

##### aws.dynamodb.Client.updateItem

Update attributes for an existing DynamoDB item.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `tableName` | string | Required. DynamoDB table name. |
| `key` | dictionary \\| struct | Required. Primary key map of AttributeValue objects. |
| `updateExpression` | string | Required. DynamoDB update expression. |
| `expressionAttributeValues` | dictionary | Optional. Values referenced in the update expression. |
| `returnValues` | string | Optional. Specify response content (e.g., `"ALL_NEW"`). |

| Returns | Type | Description |
| --- | --- | --- |
| `updateItemResponse` | `aws.dynamodb.model.UpdateItemResponse` | Contains updated attributes and consumed capacity info. |

```matlab
ddb = aws.dynamodb.Client();
key = dictionary("pk", aws.dynamodb.model.AttributeValue(s="user#123"));
exprVals = dictionary(":name", aws.dynamodb.model.AttributeValue(s="Ada"));
resp = ddb.updateItem( ...
    tableName="users", ...
    key=key, ...
    updateExpression="SET #n = :name", ...
    expressionAttributeValues=exprVals, ...
    returnValues="ALL_NEW");
```

##### aws.dynamodb.Client.updateTable

Update provisioned throughput for an existing table.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `tableName` | string | Required. Table to modify. |
| `provisionedThroughput` | `aws.dynamodb.model.ProvisionedThroughput` | Required. New read/write capacity settings. |

| Returns | Type | Description |
| --- | --- | --- |
| `updateTableResponse` | `aws.dynamodb.model.UpdateTableResponse` | Includes the latest table description and status. |

```matlab
ddb = aws.dynamodb.Client();
pt = aws.dynamodb.model.ProvisionedThroughput( ...
    readCapacityUnits=int64(10), writeCapacityUnits=int64(5));
resp = ddb.updateTable(tableName="Orders", provisionedThroughput=pt);
disp(resp.tableDescription.tableStatus);
```

#### aws.ec2

#### aws.ec2.model

#### aws.ec2.Client

Superclass: aws.core.BaseClient

```text
CLIENT Amazon Elastic Compute Cloud (EC2) Client
 
  This client is used to interact with the Amazon EC2 service, allowing
  you to manage instances, security groups, key pairs, and more.
 
  Example:
        ec2 = aws.ec2.Client();
        % Perform operations with EC2
 
  Authentication Credentials - Please see the authentication section
  of the documentation for more details.
```

##### aws.ec2.Client.Client

```text
CLIENT Amazon Elastic Compute Cloud (EC2) Client
 
  This client is used to interact with the Amazon EC2 service, allowing
  you to manage instances, security groups, key pairs, and more.
 
  Example:
        ec2 = aws.ec2.Client();
        % Perform operations with EC2
 
  Authentication Credentials - Please see the authentication section
  of the documentation for more details.
```

##### aws.ec2.Client.initialize

```text
aws.ec2.Client/initialize is a function.
    initStat = initialize(obj, regionObj, credentialsProvider)
```

##### aws.ec2.Client.startInstance

Start one or more EC2 instances.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `instanceIds` | string \\| string array | Required. IDs of the instances to start. |
| `additionalInfo` | string | Optional. Reserved field passed through to the API. |

| Returns | Type | Description |
| --- | --- | --- |
| `startInstancesResponse` | `software.amazon.awssdk.services.ec2.model.StartInstancesResponse` | List of instance state transitions. |

```matlab
resp = ec2.startInstance(instanceIds=["i-0123456789abcdef0","i-0fedcba9876543210"]);
disp(resp.startingInstances);
```

##### aws.ec2.Client.stopInstance

Stop one or more running EC2 instances.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `instanceIds` | string \\| string array | Required. IDs of the instances to stop. |
| `force` | logical | Optional. Set `true` to force stop (similar to power off). |

| Returns | Type | Description |
| --- | --- | --- |
| `stopInstancesResponse` | `software.amazon.awssdk.services.ec2.model.StopInstancesResponse` | Instance state transitions plus HTTP metadata. |

```matlab
resp = ec2.stopInstance(instanceIds="i-0123456789abcdef0", force=false);
disp(resp.stoppingInstances);
```

#### aws.ecs

#### aws.ecs.model

##### aws.ecs.model.AwsVpcConfiguration

| Field | Type | Description |
| --- | --- | --- |
| `subnets` | string array | Subnet IDs for awsvpc ENIs. |
| `securityGroups` | string array | Security group IDs attached to the ENIs. |
| `assignPublicIp` | string | `"ENABLED"` or `"DISABLED"` when using awsvpc networking. |

##### aws.ecs.model.ClusterResponse

| Property | Type | Description |
| --- | --- | --- |
| `clusterArn` | string | ARN of the created/deleted cluster. |

##### aws.ecs.model.ContainerDefinition

| Field | Type | Description |
| --- | --- | --- |
| `name` | string | Container name. |
| `image` | string | Container image reference. |
| `cpu` | int32 | CPU units reserved for the container. |
| `memory` | int32 | Memory (MiB) reserved for the container. |
| `essential` | logical | When true, task stops if this container exits. |
| `portMappings` | aws.ecs.model.PortMapping array | Exposed ports. |
| `logConfiguration` | aws.ecs.model.LogConfiguration | Log driver definition. |
| `environment` | dictionary | Environment variables. |

##### aws.ecs.model.LoadBalancers

| Field | Type | Description |
| --- | --- | --- |
| `loadBalancerName` | string | Classic/ALB name. |
| `targetGroupArn` | string | Target group ARN (ALB/NLB). |
| `containerName` | string | Container receiving traffic. |
| `containerPort` | double | Port exposed on the container. |

##### aws.ecs.model.LogConfiguration

| Field | Type | Description |
| --- | --- | --- |
| `logDriver` | string | Log driver (`"awslogs"`, `"fluentd"`, etc.). |
| `options` | dictionary | Driver-specific options (keys converted to dashed form). |

##### aws.ecs.model.NetworkConfiguration

| Field | Type | Description |
| --- | --- | --- |
| `awsvpcConfiguration` | aws.ecs.model.AwsVpcConfiguration | VPC networking details applied to the service/task. |

##### aws.ecs.model.PortMapping

| Field | Type | Description |
| --- | --- | --- |
| `containerPort` | double | Container port (1–65535). |
| `hostPort` | double | Host port (1–65535). |
| `protocol` | string | `"tcp"` (default) or `"udp"`. |

##### aws.ecs.model.RegisterTaskDefinitionRequest

| Usage | Type | Description |
| --- | --- | --- |
| `sdkRequest` | AWS SDK request object | Wrap an existing Java request. |
| `struct` | struct/dictionary | Build a new request via `aws.internal.builder`. |

##### aws.ecs.model.ServiceResponse

| Property | Type | Description |
| --- | --- | --- |
| `serviceArn` | string | ARN of the service affected by the API call. |

##### aws.ecs.model.TaskDefinitionResponse

| Property | Type | Description |
| --- | --- | --- |
| `taskDefinitionArn` | string or cell array | ARN(s) returned by register/deregister/delete operations. |

#### aws.ecs.Client

Interact with Amazon Elastic Container Service clusters, services, and task definitions.

##### aws.ecs.Client.Client

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `'region'` | string | Optional region override; defaults to the credential region. |
| `'credentialsprovider'` | aws.auth.CredentialProvider | Optional credential source to override defaults. |
| `'isCrt'` | logical | When true, use the AWS Common Runtime HTTP client. |

| Returns | Type | Description |
| --- | --- | --- |
| `ecs` | `aws.ecs.Client` | Configured ECS client instance. |

```matlab
ecs = aws.ecs.Client('region',"us-east-1");
```

##### aws.ecs.Client.createCluster

Create a new ECS cluster.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `clusterName` | string | Required. Friendly name for the cluster. |
| `capacityProviders` | string array | Optional. Capacity providers to associate with the cluster. |
| `executeCommandKmsKeyId` | string | Optional. KMS key ARN for ECS Exec encryption. |
| `executeCommandLogConfiguration` | struct | Optional. Struct passed directly to the AWS SDK log configuration builder. |
| `executeCommandLogging` | string | Optional. "NONE", "DEFAULT", or "OVERRIDE". |
| `managedStorageKmsKeyId` | string | Optional. KMS key ARN for managed storage. |
| `fargateEphemeralStorageKmsKeyId` | string | Optional. KMS key ARN for Fargate ephemeral storage. |
| `tags` | dictionary | Optional. Key/value tags applied to the cluster. |
| `settings` | dictionary | Optional. Cluster setting name/value pairs. |

| Returns | Type | Description |
| --- | --- | --- |
| `createClusterResponse` | `aws.ecs.model.ClusterResponse` | Metadata describing the created cluster. |

```matlab
ecs = aws.ecs.Client('region',"us-east-1");
resp = ecs.createCluster(clusterName="demoCluster", capacityProviders=["FARGATE"]);
```

##### aws.ecs.Client.createService

Create or scale an ECS service.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `cluster` | string | Required. Cluster name/ARN hosting the service. |
| `serviceName` | string | Required. Service name to create. |
| `taskDefinition` | string | Required. Task definition family:revision or ARN. |
| `launchType` | string | Optional. Launch type ("FARGATE", "EC2", "EXTERNAL"). |
| `desiredCount` | double | Optional. Desired number of running tasks. |
| `subnets` | string array | Optional. Subnet IDs for awsvpc networking. |
| `securityGroups` | string array | Optional. Security group IDs for awsvpc networking. |
| `assignPublicIp` | string | Optional. "ENABLED" or "DISABLED" for awsvpc tasks. |
| `loadBalancers` | aws.ecs.model.LoadBalancers array | Optional. Target load balancers for the service. |

| Returns | Type | Description |
| --- | --- | --- |
| `createServiceResponse` | `aws.ecs.model.ServiceResponse` | Created service metadata. |

```matlab
ecs = aws.ecs.Client();
resp = ecs.createService(cluster="default", serviceName="web", taskDefinition="myTaskDef", subnets=["subnet-1"], securityGroups=["sg-123"]);
```

##### aws.ecs.Client.deleteCluster

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `cluster` | string | Required. Cluster name or ARN to delete (must be inactive). |

| Returns | Type | Description |
| --- | --- | --- |
| `deleteClusterResponse` | `aws.ecs.model.ClusterResponse` | Metadata for the removed cluster. |

##### aws.ecs.Client.deleteService

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `cluster` | string | Required. Cluster hosting the service. |
| `service` | string | Required. Service name/ARN to delete. |
| `force` | logical | Optional. Force deletion even if tasks remain. |

| Returns | Type | Description |
| --- | --- | --- |
| `deleteServiceResponse` | `aws.ecs.model.ServiceResponse` | Deleted service metadata. |

##### aws.ecs.Client.deleteTaskDefinitions

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `taskDefinitions` | string array | Required. One or more task definition ARNs to delete. |

| Returns | Type | Description |
| --- | --- | --- |
| `response` | `aws.ecs.model.TaskDefinitionResponse` | Information about the deleted revisions. |

##### aws.ecs.Client.deregisterTaskDefinition

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `taskDefinition` | string | Required. Task definition ARN or family:revision to deregister. |

| Returns | Type | Description |
| --- | --- | --- |
| `response` | `aws.ecs.model.TaskDefinitionResponse` | Metadata for the inactive revision. |

##### aws.ecs.Client.initialize

```text
aws.ecs.Client/initialize is a function.
    initStat = initialize(obj, regionObj, credentialsProvider)
```

##### aws.ecs.Client.registerTaskDefinition

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `family` | string | Required. Task definition family name. |
| `taskRoleArn` | string | Required. IAM role assumed by the task. |
| `executionRoleArn` | string | Required. IAM role assumed by the ECS agent. |
| `networkMode` | string | Required. "AWSVPC", "BRIDGE", "HOST", or "NONE". |
| `containerDefinitions` | aws.ecs.model.ContainerDefinition array | Required. Container definition objects. |
| `requiresCompatibilities` | string array | Optional. Supported launch types ("FARGATE", "EC2", "EXTERNAL"). |
| `cpu` | string | Required. CPU units reserved for the task. |
| `memory` | string | Required. Memory (MiB) reserved for the task. |

| Returns | Type | Description |
| --- | --- | --- |
| `registerTaskDefinitionResponse` | `aws.ecs.model.TaskDefinitionResponse` | Metadata for the registered revision. |

```matlab
resp = ecs.registerTaskDefinition(family="web", taskRoleArn=taskRole, ...
    executionRoleArn=execRole, networkMode="AWSVPC", ...
    containerDefinitions=[containerDef], requiresCompatibilities="FARGATE", ...
    cpu="1024", memory="2048");
```

##### aws.ecs.Client.updateService

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `cluster` | string | Required. Cluster that hosts the service. |
| `serviceName` | string | Required. Service name/ARN to update. |
| `taskDefinition` | string | Optional. New task definition revision. |
| `desiredCount` | double | Optional. Desired number of tasks. |
| `loadBalancers` | aws.ecs.model.LoadBalancers array | Optional. Updated load balancer mappings. |

| Returns | Type | Description |
| --- | --- | --- |
| `updateServiceResponse` | `aws.ecs.model.ServiceResponse` | Updated service metadata. |

```matlab
resp = ecs.updateService(cluster="default", serviceName="web", desiredCount=3);
```


#### aws.internal

#### aws.internal.builder

Internal utilities that translate MATLAB arguments into AWS SDK builder
calls.

##### aws.internal.builder.build

Populate a Java builder using the fields of a MATLAB scalar struct (the
output of an arguments block).

| Input | Type | Description |
| --- | --- | --- |
| `builder` | Java builder | AWS SDK builder returned by a `.builder()` factory. |
| `options` | struct | Scalar struct whose field names map to builder setters. |

| Returns | Type | Description |
| --- | --- | --- |
| `handle` | java.lang.Object | Result of invoking `builder.build()`. |

```matlab
request = aws.internal.builder.build(builder, optionsStruct);
```

##### aws.internal.builder.buildSdkObjectsFromDictionary

Convert a MATLAB `dictionary` into an array of SDK model objects by
calling the target class' builder.

| Input | Type | Description |
| --- | --- | --- |
| `inputDictionary` | dictionary | Keys become `name`/`key` setters; values map to `value`. |
| `sdkClass` | string | Fully qualified Java class that exposes a `builder()` method. |

| Returns | Type | Description |
| --- | --- | --- |
| `objectArray` | java Array | Java array of the requested SDK objects. |

#### aws.internal.util

#### aws.internal.util.javaMapToDictionary

```text
javaMapToDictionary Converts a java.util.Map to a MATLAB dictionary
    dict = javaMapToDictionary(javaMap) returns a MATLAB dictionary
    with the same keys and values as the Java map.
 
    Example:
        jmap = java.util.HashMap();
        jmap.put('a', 1);
        jmap.put('b', 2);
        dict = javaMapToDictionary(jmap);
```

#### aws.lambda

#### aws.lambda.model

#### aws.lambda.model.CreateFunctionResponse

Superclass: aws.Object

```text
CREATEFUNCTIONRESPONSE Response object for creating an AWS Lambda function.
 
  This class constructs a response to create a new AWS Lambda function
  using the provided parameters.
```

##### aws.lambda.model.CreateFunctionResponse.CreateFunctionResponse

```text
CREATEFUNCTIONRESPONSE Construct an instance of this class
```

#### aws.lambda.model.DeleteFunctionResponse

Superclass: aws.Object

```text
DELETEFUNCTIONRESPONSE Response object for deleting an AWS Lambda function.
 
  This class constructs a response for deleting an AWS Lambda function.
```

##### aws.lambda.model.DeleteFunctionResponse.DeleteFunctionResponse

```text
DELETEFUNCTIONRESPONSE Construct an instance of this class
```

#### aws.lambda.model.FunctionCode

Superclass: aws.Object

```text
FUNCTIONCODE Summary of this class goes here
```

##### aws.lambda.model.FunctionCode.FunctionCode

```text
FUNCTIONCODE Summary of this class goes here
```

#### aws.lambda.model.InvokeFunctionResponse

Superclass: aws.Object

```text
INVOKEFUNCTIONRESPONSE Response object for invoking an AWS Lambda function.
 
  This class constructs a response to an AWS Lambda function invocation.
```

##### aws.lambda.model.InvokeFunctionResponse.InvokeFunctionResponse

```text
INVOKEFUNCTIONRESPONSE Construct an instance of this class
```

##### aws.lambda.model.InvokeFunctionResponse.getPayload

```text
GETPAYLOAD Get the payload from the response
```

#### aws.lambda.task

#### aws.lambda.task.CompileTask

Superclass: matlab.buildtool.Task

```text
COMPILETASK MATLAB Build Tool Task for compiling MATLAB Compiler
  Standalone Applications. Saves the build results as MAT-file in the
  output directory. This is specifically meant to be used in
  combination with aws.lambda.task.DockerTask which requires these
  build results as input.
 
  CompileTask Properties:
 
    AppFile - Main entry point for the standalone application. See also
        AppFile input to compiler.build.standaloneApplication.
    AdditionalFiles - Additional Files to include in the application.
        See also AdditionalFiles input to compiler.build.standaloneApplication.
    OutputDir - Path to folder where the build files are saved. See
        also OutputDir input to compiler.build.standaloneApplication.
    Description - Description of task.
    Dependencies - Names of tasks on which the task depends.
 
  CompileTask Methods:
 
    CompileTask - constructor.
 
  See Also DockerTask, matlab.buildtool.Task, compiler.build.standaloneApplication
```

##### aws.lambda.task.CompileTask.CompileTask

```text
COMPILETASK constructor
 
  Can be called with Name-Value pairs as input where Name can
  match any class property name which will be then set this
  property to the specified Value.
```

##### aws.lambda.task.CompileTask.compileStandalone

```text
COMPILESTANDALONE builds the standalone application
```

#### aws.lambda.task.DockerTask

Superclass: matlab.buildtool.Task

```text
DOCKERTASK MATLAB Build Tool Task for packaging MATLAB Compiler
  standalone applications into an AWS Lambda Compatible Docker image.
 
  The Docker packaging process differs from a standard Docker package
  process in the sense that this task can:
 
   - Patch libiomp5.so inside the image to work around an
     incompatibility with AWS Lambda runtime instances.
   - Include the AWS Lambda Runtime Interface Emulator in the image
     and generate an entrypoint to run this emulator for local testing.
 
  This Task is meant to be used in combination with
  aws.lambda.task.CompileTask which produces the build results which
  this Task needs as input.
 
  DockerTask Properties:
 
    CompileOutputDir - OutputDir of the CompileTask which was used to
        compile the standalone application.
    ImageName - Name of the Docker image. See also ImageName input to
        compiler.package.docker.
    PatchLibiomp5 - Whether or not to apply the libiomp5.so patch.
        Default: true.
    Libiomp5Location - Location of patched libiomp5.so.
    IncludeEmulator - Whether or not to include the AWS Lambda Runtime
        Interface Emulator in the image. Default: true.
    DockerContext - Path to folder where the build files are saved. See
        also DockerContext input to compiler.package.docker.
    Description - Description of task.
    Dependencies - Names of tasks on which the task depends.
 
  DockerTask Methods:
 
    DockerTask - constructor.
 
  See Also CompileTask, matlab.buildtool.Task, compiler.package.docker
```

##### aws.lambda.task.DockerTask.DockerTask

```text
DOCKERTASK constructor
 
  Can be called with Name-Value pairs as input where Name can
  match any class property name which will be then set this
  property to the specified Value.
```

##### aws.lambda.task.DockerTask.dockerBuild

```text
DOCKERBUILD builds the Docker container around the standalone
 application
```

#### aws.lambda.testutil

#### aws.lambda.testutil.DockerBase

Superclass: matlab.unittest.TestCase

```text
DOCKERBASE base class for Docker based tests.
 
    In TestClassSetup starts the Docker container specified by the
    imageName property. 
    
    The container is configured to publish port
    8080 to a random free port. The actual port is reported back in the
    port property. 
    
    Also sets the host property based on environment
    variable DOCKERHOST; if set host is set to its value, if unset host
    is set to "localhost".
 
    The container is stopped in TestClassTeardown.
```

##### aws.lambda.testutil.DockerBase.DockerBase

```text
DOCKERBASE base class for Docker based tests.
 
    In TestClassSetup starts the Docker container specified by the
    imageName property. 
    
    The container is configured to publish port
    8080 to a random free port. The actual port is reported back in the
    port property. 
    
    Also sets the host property based on environment
    variable DOCKERHOST; if set host is set to its value, if unset host
    is set to "localhost".
 
    The container is stopped in TestClassTeardown.
```

##### aws.lambda.testutil.DockerBase.forInteractiveUse

```text
forInteractiveUse - Default provided forInteractiveUse method
```

##### aws.lambda.testutil.DockerBase.startContainer

```text
Start the container
```

##### aws.lambda.testutil.DockerBase.stopContainer

```text
aws.lambda.testutil.DockerBase/stopContainer is a function.
    stopContainer(testCase)
```

#### aws.lambda.Client

Superclass: aws.core.BaseClient

##### aws.lambda.Client.Client

Construct an AWS Lambda service client.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `'region'` | string | Optional region override; defaults to the shared credential provider region. |
| `'credentialsprovider'` | aws.auth.CredentialProvider | Optional credentials source; defaults to `aws.auth.CredentialProvider.getDefaultCredentialProvider`. |
| `'isCrt'` | logical | When `true`, use the AWS Common Runtime HTTP client. |

| Returns | Type | Description |
| --- | --- | --- |
| `lambda` | `aws.lambda.Client` | Client configured for the requested region. |

```matlab
lambda = aws.lambda.Client('region',"us-east-1");
```

##### aws.lambda.Client.createFunction

Create a new AWS Lambda function.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `functionName` | string | Required. Logical name for the Lambda function. |
| `runtime` | string | Required. Runtime identifier such as `"nodejs20.x"` or `"python3.12"`. |
| `role` | string | Required. IAM role ARN used during execution. |
| `handler` | string | Required. Entry point in the package (`file.function`). |
| `code` | `aws.lambda.model.FunctionCode` | Required. Deployment package reference. |
| `description` | string | Optional. Free-form description. |
| `timeout` | int32 | Optional. Execution timeout (seconds, default 3). |
| `memorySize` | int32 | Optional. Memory allocation in MB (default 128). |
| `tags` | dictionary | Optional. Metadata applied to the function. |

| Returns | Type | Description |
| --- | --- | --- |
| `response` | `aws.lambda.model.CreateFunctionResponse` | Metadata describing the new function. |

```matlab
code = aws.lambda.model.FunctionCode(zipFile=aws.core.model.SdkBytes('function.zip'));
resp = lambda.createFunction(functionName="demoFunction", runtime="nodejs20.x", ...
    role=roleArn, handler="index.handler", code=code, description="Demo function");
```

##### aws.lambda.Client.deleteFunction

Delete a Lambda function, version, or alias.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `functionName` | string | Required. Name, ARN, version, or alias to delete. |

| Returns | Type | Description |
| --- | --- | --- |
| `response` | `aws.lambda.model.DeleteFunctionResponse` | Request metadata. |

```matlab
resp = lambda.deleteFunction(functionName="demoFunction:1");
```

##### aws.lambda.Client.initialize

```text
aws.lambda.Client/initialize is a function.
    initStat = initialize(obj, regionObj, credentialsProvider)
```

##### aws.lambda.Client.invokeFunction

Invoke a Lambda function.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `functionName` | string | Required. Name or ARN of the function, alias, or version. |
| `clientContext` | string | Optional. Base64 client context passed through to the handler. |
| `invocationType` | string | Optional. `"RequestResponse"` (default), `"Event"`, or `"DryRun"`. |
| `logType` | string | Optional. `"Tail"` to embed the last 4 KB of logs. |
| `payload` | `aws.core.model.SdkBytes` | Required. Payload provided to the function. |
| `qualifier` | string | Optional. Version number or alias. |

| Returns | Type | Description |
| --- | --- | --- |
| `response` | `aws.lambda.model.InvokeFunctionResponse` | Status code, logs, and payload returned by Lambda. |

```matlab
payload = aws.core.model.SdkBytes('{"message":"hello"}', 'utf-8');
resp = lambda.invokeFunction(functionName="demoFunction", payload=payload, logType="Tail");
disp(resp.statusCode);
```

#### aws.polly

Interfaces for Amazon Polly (voices, lexicons, and speech synthesis).

#### aws.polly.Client

Superclass: aws.core.BaseClient

MATLAB client for Amazon Polly.

##### aws.polly.Client.Client

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `region` | string \\| software.amazon.awssdk.regions.Region | Optional. Target region. |
| `credentialsprovider` | aws.auth.CredentialProvider | Optional. Credential chain override. |
| `isCrt` | logical | Optional. Use the AWS Common Runtime HTTP client when true. |

```matlab
polly = aws.polly.Client('region',"us-east-1");
```

##### aws.polly.Client.deleteLexicon

Remove a lexicon from Polly.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `name` | string | Required. Lexicon identifier. |

| Returns | Type | Description |
| --- | --- | --- |
| `response` | `aws.polly.model.DeleteLexiconResponse` | Request metadata. |

```matlab
resp = polly.deleteLexicon(name="medicalTerms");
```

##### aws.polly.Client.describeVoices

List available voices.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `languageCode` | string | Optional. Locale filter (e.g., `"en-US"`). |
| `engine` | string | Optional. `"standard"`, `"neural"`, `"long-form"`, `"generative"`. |
| `nextToken` | string | Optional. Pagination token. |
| `includeAdditionalLanguageCodes` | logical | Optional. Include voices supporting additional languages. |

| Returns | Type | Description |
| --- | --- | --- |
| `response` | `aws.polly.model.DescribeVoicesResponse` | Voice metadata plus pagination token. |

```matlab
resp = polly.describeVoices(languageCode="en-US", engine="neural");
```

##### aws.polly.Client.getLexicon

Retrieve a lexicon definition.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `name` | string | Required. Lexicon identifier. |

| Returns | Type | Description |
| --- | --- | --- |
| `response` | `aws.polly.model.GetLexiconResponse` | Lexicon name and XML content. |

```matlab
resp = polly.getLexicon(name="medicalTerms");
```

##### aws.polly.Client.initialize

```text
aws.polly.Client/initialize is a function.
    initStat = initialize(obj, regionObj, credentialsProvider)
```

##### aws.polly.Client.putLexicon

Upload or overwrite a lexicon.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `name` | string | Required. Lexicon identifier. |
| `content` | string | Required. Lexicon XML payload. |

| Returns | Type | Description |
| --- | --- | --- |
| `response` | `aws.polly.model.PutLexiconResponse` | Request metadata. |

```matlab
xml = fileread("medicalTerms.pls");
resp = polly.putLexicon(name="medicalTerms", content=xml);
```

##### aws.polly.Client.synthesizeSpeech

Convert text/SSML into audio or speech marks.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `text` | string | Required. Text/SSML payload. |
| `voiceId` | string | Required. Voice identifier (e.g., `"Joanna"`). |
| `outputFormat` | string | Optional. `"mp3"`, `"ogg_vorbis"`, `"pcm"`, `"json"`. |
| `engine` | string | Optional. `"standard"`, `"neural"`, `"long-form"`, `"generative"`. |
| `languageCode` | string | Optional. Override locale. |
| `sampleRate` | string | Optional. Sample rate for PCM/MP3 output. |
| `textType` | string | Optional. `"text"` or `"ssml"`. |
| `speechMarkTypesWithStrings` | string array | Optional. Speech mark types when `outputFormat="json"`. |
| `lexiconNames` | string array | Optional. Lexicons to apply. |

| Returns | Type | Description |
| --- | --- | --- |
| `response` | `aws.polly.model.SynthesizeSpeechResponse` | Audio bytes, content type, and character usage. |

```matlab
resp = polly.synthesizeSpeech(text="Hello from MATLAB", voiceId="Joanna");
fwrite(fopen("hello.mp3",'w'), resp.audioStream, 'uint8');
```

#### aws.polly.model

#### aws.polly.model.DeleteLexiconResponse

Superclass: aws.Object

| Property | Type | Description |
| --- | --- | --- |
| `status` | string | `"Success"` when the delete operation is acknowledged. |

#### aws.polly.model.DescribeVoicesResponse

Superclass: aws.Object

| Property | Type | Description |
| --- | --- | --- |
| `voices` | aws.polly.model.Voice array | Voice metadata returned by the API. |
| `nextToken` | string | Pagination token when more voices remain. |

#### aws.polly.model.GetLexiconResponse

Superclass: aws.Object

| Property | Type | Description |
| --- | --- | --- |
| `lexiconName` | string | Name of the lexicon. |
| `lexiconContent` | string | Lexicon XML payload. |

#### aws.polly.model.PutLexiconResponse

Superclass: aws.Object

| Property | Type | Description |
| --- | --- | --- |
| `status` | string | `"Success"` when the lexicon is stored. |

#### aws.polly.model.SynthesizeSpeechResponse

Superclass: aws.Object

| Property | Type | Description |
| --- | --- | --- |
| `audioStream` | uint8 vector | Raw audio bytes from the response. |
| `contentType` | string | MIME type (e.g., `"audio/mpeg"`). |
| `requestCharacters` | int32 | Number of billed characters. |

#### aws.polly.model.Voice

Superclass: aws.Object

| Property | Type | Description |
| --- | --- | --- |
| `id` | string | Voice identifier. |
| `name` | string | Human-readable name. |
| `languageCode` | string | Locale code (e.g., `"en-US"`). |
| `languageName` | string | Locale name. |
| `gender` | string | Reported gender. |
| `supportedEngines` | string array | Engines supported by this voice. |

#### aws.redshift

#### aws.redshift.Client

Superclass: aws.core.BaseClient

MATLAB client for Amazon Redshift.

##### aws.redshift.Client.Client

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `region` | string \\| software.amazon.awssdk.regions.Region | Optional. Target region. |
| `credentialsprovider` | aws.auth.CredentialProvider | Optional. Credential source. |
| `isCrt` | logical | Optional. Use the AWS Common Runtime HTTP client when true. |

```matlab
redshift = aws.redshift.Client('region',"us-east-1");
```

##### aws.redshift.Client.initialize

```text
aws.redshift.Client/initialize is a function.
    initStat = initialize(obj, regionObj, credentialsProvider)
```

#### aws.redshiftdata

Client and model wrappers for the Amazon Redshift Data API.

#### aws.redshiftdata.Client

Superclass: aws.core.BaseClient

MATLAB client for submitting SQL statements to Redshift provisioned clusters or serverless workgroups.

##### aws.redshiftdata.Client.Client

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `region` | string \\| software.amazon.awssdk.regions.Region | Optional. Target AWS Region. |
| `credentialsprovider` | aws.auth.CredentialProvider | Optional. Override the credential source. |
| `isCrt` | logical | Optional. Use the AWS Common Runtime HTTP client when true. |

```matlab
rs = aws.redshiftdata.Client('region',"us-east-1");
```

##### aws.redshiftdata.Client.executeStatement

Run a SQL statement against a provisioned cluster or serverless workgroup.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `sql` | string | Required. SQL statement text. |
| `database` | string | Required. Database to run the statement in. |
| `clusterIdentifier` | string | Required when targeting a provisioned cluster. Mutually exclusive with `workgroupName`. |
| `workgroupName` | string | Required when targeting a serverless workgroup. Mutually exclusive with `clusterIdentifier`. |
| `clientToken` | string | Optional. Idempotency token. |
| `dbUser` | string | Optional. Database user to impersonate. |
| `parameters` | dictionary | Optional. SQL parameters (name -> scalar value). |
| `resultFormat` | string | Optional. `"JSON"` or `"TEXT"` (default server behavior). |
| `secretArn` | string | Optional. Secrets Manager ARN for credentials. |
| `sessionId` | string | Optional. Existing session identifier. |
| `sessionKeepAliveSeconds` | double | Optional. Seconds to keep session alive (provisioned only). |
| `statementName` | string | Optional. Friendly name for the statement. |
| `withEvent` | logical | Optional. Publish statement status events to EventBridge. |

| Returns | Type | Description |
| --- | --- | --- |
| `response` | `aws.redshiftdata.model.ExecuteStatementResponse` | Statement identifier, row counts, timestamps. |

```matlab
resp = rs.executeStatement( ...
    sql="SELECT :x AS value", ...
    workgroupName="demo-serverless", ...
    database="dev", ...
    parameters=dictionary("x", 42));
```

##### aws.redshiftdata.Client.getStatementResult

Fetch rows for a previously executed statement.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `id` | string | Required. Identifier returned by `executeStatement`. |
| `nextToken` | string | Optional. Pagination token from a prior call. |

| Returns | Type | Description |
| --- | --- | --- |
| `response` | `aws.redshiftdata.model.GetStatementResultResponse` | Records, metadata, pagination token. |

```matlab
page1 = rs.getStatementResult(id=resp.id);
if page1.hasNextToken
    page2 = rs.getStatementResult(id=resp.id, nextToken=page1.nextToken);
end
```

##### aws.redshiftdata.Client.initialize

```text
aws.redshiftdata.Client/initialize is a function.
    initStat = initialize(obj, regionObj, credentialsProvider)
```

#### aws.redshiftdata.model.ExecuteStatementResponse

Superclass: aws.Object

| Property | Type | Description |
| --- | --- | --- |
| `id` | string | Statement identifier. |
| `clusterIdentifier` | string | Provisioned cluster targeted by the statement. |
| `workgroupName` | string | Serverless workgroup targeted by the statement. |
| `database` | string | Database name. |
| `hasResultSet` | logical | True when the statement produces rows. |
| `numberOfRecordsUpdated` | double | Row count for DML statements (if returned). |
| `createdAt` | datetime | Timestamp when the statement was created (UTC). |
| `updatedAt` | datetime | Timestamp when the statement was last updated (UTC). |

#### aws.redshiftdata.model.Field

Superclass: aws.Object

| Property | Type | Description |
| --- | --- | --- |
| `value` | any | Best-effort MATLAB value (string, double, int64, logical, uint8, or `[]`). |
| `stringValue` | string | Raw string representation, when available. |
| `longValue` | int64 | Integer representation, when available. |
| `doubleValue` | double | Floating-point representation, when available. |
| `booleanValue` | logical | Boolean representation, when available. |
| `blobValue` | uint8 vector | Binary payload for VARBYTE columns. |
| `isNull` | logical | True when the column is NULL. |

#### aws.redshiftdata.model.GetStatementResultResponse

Superclass: aws.Object

| Property | Type | Description |
| --- | --- | --- |
| `columnMetadata` | struct array | Column definitions (name, type, length, nullable). |
| `recordRows` | cell array | Rows of `aws.redshiftdata.model.Field` objects. |
| `nextToken` | string | Pagination token for fetching the next page. |
| `hasNextToken` | logical | True when `nextToken` is non-empty. |
| `totalNumRows` | double | Reported total row count (if returned by the service). |

##### aws.redshiftdata.model.GetStatementResultResponse.records

Return the result rows as `Field` objects.

| Returns | Type | Description |
| --- | --- | --- |
| `recordsArray` | cell array | Each cell represents a row; each row contains a cell array of `Field` objects. |

```matlab
rows = resp.records();
firstRowValues = cellfun(@(f) f.getValue(), rows{1});
```

##### aws.redshiftdata.model.GetStatementResultResponse.getResultSet

Convert the records into a MATLAB table.

| Returns | Type | Description |
| --- | --- | --- |
| `resultSetTable` | table | Table whose variables align with the column metadata. |

```matlab
tbl = resp.getResultSet();
disp(tbl(1:5,:));
```

#### aws.s3

#### aws.s3.model

##### aws.s3.model.AccessControlPolicy

Build a custom ACL for buckets or objects.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| owner | ws.s3.model.Owner | Required. Owner metadata. |
| grants | cell array | Optional. Each cell contains an ws.s3.model.Grant. |

`matlab
grant = aws.s3.model.Grant(struct(grantee=myGrantee, permission=\"FULL_CONTROL\"));
acp = aws.s3.model.AccessControlPolicy(owner=myOwner, grants={grant});
`

##### aws.s3.model.CopyObjectResponse

Metadata returned by s3.copyObject.

| Property | Type | Description |
| --- | --- | --- |
| eTag | string | Entity tag of the copied object. |
| lastModified | datetime | Timestamp when the copy finished. |
| 
ersionId | string | Version assigned to the new object (if enabled). |
| copySourceVersionId | string | Version ID of the source object that was copied. |
| 
equestCharged | string | Indicates requester-pays usage. |
| serverSideEncryption | string | SSE algorithm used on the destination object. |
| sseCustomerAlgorithm | string | SSE-C algorithm, when applicable. |
| sseCustomerKeyMD5 | string | MD5 checksum of the SSE-C key. |
| ssekmsKeyId | string | AWS KMS key ARN. |
| ssekmsEncryptionContext | string | Encryption context for SSE-KMS. |
| ucketKeyEnabled | logical | 	rue when S3 Bucket Keys were used. |

##### aws.s3.model.CreateBucketResponse

| Property | Type | Description |
| --- | --- | --- |
| location | string | Region/location constraint reported by S3. |

##### aws.s3.model.DeleteBucketResponse

| Property | Type | Description |
| --- | --- | --- |
| status | string | "Success" after the bucket is removed. |

##### aws.s3.model.DeleteObjectResponse

| Property | Type | Description |
| --- | --- | --- |
| deleteMarker | logical | 	rue when a delete marker was created. |
| 
ersionId | string | Version that was deleted. |
| 
equestCharged | string | Indicates requester-pays usage. |

##### aws.s3.model.GetBucketAclResponse

| Property | Type | Description |
| --- | --- | --- |
| owner | ws.s3.model.Owner | Bucket owner metadata. |
| grants | ws.s3.model.Grant array | ACL entries returned by the service. |

##### aws.s3.model.GetObjectAclResponse

| Property | Type | Description |
| --- | --- | --- |
| owner | ws.s3.model.Owner | Object owner metadata. |
| grants | ws.s3.model.Grant array | ACL entries describing permissions on the object. |

##### aws.s3.model.GetObjectResponse

| Property | Type | Description |
| --- | --- | --- |
| contentLength | int64 | Object size in bytes. |
| contentType | string | MIME type reported by S3. |
| eTag | string | Entity tag assigned by S3. |
| lastModified | Java Instant | Last-modified timestamp. |
| 
ersionId | string | Version identifier when versioning is enabled. |
| storageClass | string | Storage class enumeration (e.g., STANDARD). |

##### aws.s3.model.Grant

Construct an ACL grant entry.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| grantee | ws.s3.model.Grantee \| struct | Required. Target of the permission. |
| permission | string | Required. Permission string such as READ, WRITE, or FULL_CONTROL. |

##### aws.s3.model.Grantee

Represent the subject of an S3 grant.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| 	ype | string | Required when building from a struct. Use CanonicalUser, AmazonCustomerByEmail, or Group. |
| id | string | Optional. Canonical user ID. |
| displayName | string | Optional. Display name associated with the canonical user. |
| uri | string | Optional. Group URI (for group grants). |
| emailAddress | string | Optional. Email address when using the email grantee type. |

##### aws.s3.model.HeadObjectResponse

| Property | Type | Description |
| --- | --- | --- |
| contentLength | double | Object size in bytes. |
| contentType | string | MIME type reported by S3. |
| eTag | string | Entity tag assigned to the object. |
| lastModified | Java Instant | Timestamp returned by S3. |

##### aws.s3.model.ListBucketsResponse

| Property | Type | Description |
| --- | --- | --- |
| uckets | ws.s3.model.Bucket array | Metadata for each bucket in the account. |

##### aws.s3.model.ListObjectsResponse

| Property | Type | Description |
| --- | --- | --- |
| `s3Objects` | `aws.s3.model.S3Object` array | Objects returned by the listing. |
| `name` | string | Bucket name echoed by S3. |

##### aws.s3.model.S3Object

| Property | Type | Description |
| --- | --- | --- |
| `key` | string | Object key. |
| `size` | double | Object size in bytes. |
| `lastModified` | datetime | UTC timestamp for the object. |
| `eTag` | string | Entity tag reported by S3. |
| `checksumTypeAsString` | string | Checksum algorithm string. |
| `storageClassAsString` | string | Storage class such as `STANDARD`. |
| `owner` | `aws.s3.model.Owner` | Owner metadata (when requested). |

##### aws.s3.model.Owner

| Property | Type | Description |
| --- | --- | --- |
| `id` | string | Canonical user ID representing the owner. |

##### aws.s3.model.Bucket

| Property | Type | Description |
| --- | --- | --- |
| `name` | string | Bucket name. |
| `bucketArn` | string | ARN when returned by the API. |
| `bucketRegion` | string | Region hint reported by S3. |
| `creationDate` | datetime | Creation timestamp (UTC). |

##### aws.s3.model.GetBucketLocationResponse

| Property | Type | Description |
| --- | --- | --- |
| `locationConstraint` | string | Regional constraint such as `us-west-2`. |

##### aws.s3.model.PutBucketAclResponse

| Property | Type | Description |
| --- | --- | --- |
| statusCode | double | HTTP status returned by the SDK. |

##### aws.s3.model.PutBucketOwnershipControlsResponse

| Property | Type | Description |
| --- | --- | --- |
| `statusCode` | double | HTTP status code returned by S3. |
| `status` | string | "Success" when the request completed successfully. |

##### aws.s3.model.PutBucketPolicyResponse

| Property | Type | Description |
| --- | --- | --- |
| statusCode | double | HTTP status returned by the SDK. |

##### aws.s3.model.DeleteBucketPolicyResponse

| Property | Type | Description |
| --- | --- | --- |
| `statusCode` | double | HTTP status returned by the SDK. |
| `status` | string | "Success" when S3 confirms the delete. |

##### aws.s3.model.DeleteObjectsResponse

| Property | Type | Description |
| --- | --- | --- |
| `hasDeleted` | logical | Indicates whether the response contains deleted keys. |
| `hasErrors` | logical | `true` when any keys failed to delete. |

##### aws.s3.model.PutObjectAclResponse

| Property | Type | Description |
| --- | --- | --- |
| statusCode | double | HTTP status returned by the SDK. |

##### aws.s3.model.PutObjectResponse

Metadata returned by s3.putObject.

| Property | Type | Description |
| --- | --- | --- |
| eTag | string | Entity tag assigned to the object. |
| 
ersionId | string | Version identifier when versioning is enabled. |
| expiration | string | Expiration/retention metadata header. |
| serverSideEncryption | string | SSE algorithm (e.g., AES256, ws:kms). |
| sseCustomerAlgorithm | string | Algorithm when SSE-C is used. |
| sseCustomerKeyMD5 | string | MD5 hash of the SSE-C key. |
| ssekmsKeyId | string | AWS KMS key ARN. |
| ssekmsEncryptionContext | string | Optional KMS encryption context. |
| ucketKeyEnabled | logical | Indicates whether S3 Bucket Keys were used. |
| 
equestCharged | string | Requester-pays flag. |
| size | double | Size of the uploaded payload when provided by the SDK. |
##### aws.s3.model.FileDownload

| Property | Type | Description |
| --- | --- | --- |
| `status` | logical | `true` when the TransferManager download completed. |

##### aws.s3.model.FileUpload

| Property | Type | Description |
| --- | --- | --- |
| `status` | logical | `true` when the TransferManager upload completed. |

#### aws.s3.transfer

#### aws.s3.transfer.model

#### aws.s3.transfer.TransferManager

High-level Amazon S3 transfer client that wraps the AWS SDK v2 TransferManager.

##### aws.s3.transfer.TransferManager.TransferManager

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `'region'` | string \\| software.amazon.awssdk.regions.Region | Optional region override; defaults to the credential provider region. |
| `'credentialsprovider'` | aws.auth.CredentialProvider | Optional credential source used for the S3 async client. |
| `'proxy'` | struct | Optional proxy configuration consumed by `aws.Object.configProxyHttpClient`. |

| Returns | Type | Description |
| --- | --- | --- |
| `tm` | `aws.s3.transfer.TransferManager` | Configured transfer client for uploads/downloads. |

```matlab
tm = aws.s3.transfer.TransferManager('region',"us-east-1");
```

##### aws.s3.transfer.TransferManager.copy

Copy an object between S3 locations using the high-level TransferManager.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `sourceBucket` | string | Required. Bucket containing the source object. |
| `sourceKey` | string | Required. Key of the source object. |
| `destinationBucket` | string | Required. Target bucket for the copy. |
| `destinationKey` | string | Required. Target key for the new object. |
| `acl` | string | Optional. Canned ACL applied to the destination object. |
| `metadata` | dictionary | Optional. Metadata key/value pairs for the copied object. |

| Returns | Type | Description |
| --- | --- | --- |
| `transferResp` | `aws.s3.model.Transfer` | Completed copy job metadata and status. |

```matlab
tm = aws.s3.transfer.TransferManager();
resp = tm.copy(sourceBucket="src", sourceKey="file.txt", ...
    destinationBucket="dest", destinationKey="archive/file.txt");
```

##### aws.s3.transfer.TransferManager.delete

```text
DELETE   Delete a handle object.
    DELETE(H) deletes all handle objects in array H. After the delete 
    function call, H is an array of invalid objects.
 
    See also AWS.S3.TRANSFER.TRANSFERMANAGER, AWS.S3.TRANSFER.TRANSFERMANAGER/ISVALID, CLEAR

Help for aws.s3.transfer.TransferManager/delete is inherited from superclass handle
```

##### aws.s3.transfer.TransferManager.downloadDirectory

Download all objects in a bucket to a local folder.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Bucket to read from. |
| `targetDir` | string | Required. Destination directory on disk. |

| Returns | Type | Description |
| --- | --- | --- |
| `directoryResp` | `aws.s3.model.Transfer` | Completed directory-download job metadata. |

```matlab
tm = aws.s3.transfer.TransferManager();
resp = tm.downloadDirectory(bucket="datasets", targetDir="local-data");
```

##### aws.s3.transfer.TransferManager.downloadFile

Download a single object to the local file system.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Bucket that stores the object. |
| `key` | string | Required. Key (path) of the object to download. |
| `file` | string | Required. Destination file path. |

| Returns | Type | Description |
| --- | --- | --- |
| `downloadFileResp` | `aws.s3.model.FileDownload` | Transfer job metadata including completion status. |

```matlab
tm = aws.s3.transfer.TransferManager();
resp = tm.downloadFile(bucket="logs", key="2024.txt", file="local.txt");
```

##### aws.s3.transfer.TransferManager.initialize

```text
INITIALIZE Configure the MATLAB session to connect to S3 TransferManager
```

##### aws.s3.transfer.TransferManager.uploadDirectory

Upload every file within a local directory to Amazon S3.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Destination bucket. |
| `sourceDir` | string | Required. Directory to upload recursively. |
| `prefix` | string | Optional. Key prefix applied to uploaded files. |

| Returns | Type | Description |
| --- | --- | --- |
| `directoryResp` | `aws.s3.model.Transfer` | Directory-upload job metadata. |

```matlab
tm = aws.s3.transfer.TransferManager();
resp = tm.uploadDirectory(bucket="datasets", sourceDir="processed");
```

##### aws.s3.transfer.TransferManager.uploadFile

Upload a single file to Amazon S3.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Destination bucket. |
| `key` | string | Required. Destination object key. |
| `file` | string | Required. Source file path. |
| `acl` | string | Optional. Canned ACL applied to the upload. |
| `metadata` | dictionary | Optional. Metadata key/value pairs. |
| `contentType` | string | Optional. MIME type string (e.g., `"text/csv"`). |

| Returns | Type | Description |
| --- | --- | --- |
| `uploadFileResp` | `aws.s3.model.FileUpload` | Upload job metadata including completion status. |

```matlab
tm = aws.s3.transfer.TransferManager();
resp = tm.uploadFile(bucket="logs", key="2024.txt", file="local.txt");
```

#### aws.s3.Client

Superclass: aws.core.BaseClient

MATLAB client wrapper for Amazon Simple Storage Service (S3). Use this class to
create and manage buckets, upload/download objects, and configure ACL or policy settings.

##### aws.s3.Client.Client

Creates an Amazon S3 client instance.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `region` | string \\| software.amazon.awssdk.regions.Region | Optional. Target AWS Region. |
| `credentialsprovider` | aws.auth.CredentialProvider | Optional. Credential provider returned by `aws.auth.CredentialProvider`. |
| `isCrt` | logical | Optional. Enable the AWS Common Runtime HTTP client when true. |

| Returns | Type | Description |
| --- | --- | --- |
| `s3` | `aws.s3.Client` | Configured MATLAB S3 client. |

```matlab
cred = aws.auth.CredentialProvider.getDefaultCredentialProvider();
s3 = aws.s3.Client('region',"us-east-1", 'credentialsprovider', cred);
```

##### aws.s3.Client.copyObject

Copy an object between S3 locations.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `sourceBucket` | string | Required. Bucket that owns the source object. |
| `sourceKey` | string | Required. Key of the source object. |
| `destinationBucket` | string | Required. Bucket that will contain the copy. |
| `destinationKey` | string | Required. Key for the new object. |
| `acl` | string | Optional. Canned ACL applied to the destination object. |

| Returns | Type | Description |
| --- | --- | --- |
| `copyObjectResponse` | `aws.s3.model.CopyObjectResponse` | Contains ETag, version info, and encryption metadata. |

```matlab
s3 = aws.s3.Client();
resp = s3.copyObject( ...
    sourceBucket="my-source-bucket", sourceKey="src.txt", ...
    destinationBucket="my-dest-bucket", destinationKey="dst.txt");
```

##### aws.s3.Client.createBucket

Create a new Amazon S3 bucket.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Bucket name. |
| `acl` | string | Optional. Canned ACL such as `public-read`. |
| `createBucketConfiguration` | aws.s3.model.CreateBucketConfiguration \\| struct \\| dictionary | Optional. Region configuration passed to the AWS SDK builder. |

| Returns | Type | Description |
| --- | --- | --- |
| `createBucketResponse` | `aws.s3.model.CreateBucketResponse` | Metadata about the create operation. |

```matlab
s3 = aws.s3.Client();
resp = s3.createBucket(bucket="matlab-demo-bucket");
cfg = aws.s3.model.CreateBucketConfiguration(locationConstraint="us-west-2");
resp = s3.createBucket(bucket="matlab-demo-west", createBucketConfiguration=cfg);
```

##### aws.s3.Client.deleteBucket

Delete an empty Amazon S3 bucket.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Bucket name to delete. |

| Returns | Type | Description |
| --- | --- | --- |
| `deleteBucketResponse` | `aws.s3.model.DeleteBucketResponse` | Request metadata returned by S3. |

```matlab
s3 = aws.s3.Client();
resp = s3.deleteBucket(bucket="matlab-demo-bucket");
```

##### aws.s3.Client.deleteObject

Remove an object (or version) from Amazon S3.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Bucket containing the object. |
| `key` | string | Required. Object key to delete. |
| `versionId` | string | Optional. Version identifier to delete. |
| `mfa` | string | Optional. MFA token for protected deletes. |
| `bypassGovernanceRetention` | logical | Optional. Bypass governance retention when true. |
| `requestPayer` | string | Optional. Specify `"requester"` for requester-pays buckets. |
| `expectedBucketOwner` | string | Optional. AWS Account ID expected to own the bucket. |

| Returns | Type | Description |
| --- | --- | --- |
| `deleteObjectResponse` | `aws.s3.model.DeleteObjectResponse` | Indicates delete-marker state, version ID, and request charges. |

```matlab
s3 = aws.s3.Client();
resp = s3.deleteObject(bucket="matlab-demo-bucket", key="logs/output.json");
```

##### aws.s3.Client.getBucketAcl

Retrieve the ACL for an S3 bucket.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Target bucket. |
| `expectedBucketOwner` | string | Optional. AWS account ID expected to own the bucket. |

| Returns | Type | Description |
| --- | --- | --- |
| `getBucketAclResponse` | `aws.s3.model.GetBucketAclResponse` | Owner metadata plus grant list. |

```matlab
s3 = aws.s3.Client();
resp = s3.getBucketAcl(bucket="my-bucket");
disp(resp.owner.displayName);
```

##### aws.s3.Client.getBucketLocation

Get the Regional constraint for an S3 bucket.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Bucket whose Region should be returned. |
| `expectedBucketOwner` | string | Optional. AWS account ID expected to own the bucket. |

| Returns | Type | Description |
| --- | --- | --- |
| `getBucketLocationResponse` | `aws.s3.model.GetBucketLocationResponse` | Regional constraint (for example, `us-west-2`). |

```matlab
s3 = aws.s3.Client();
resp = s3.getBucketLocation(bucket="my-bucket");
disp(resp.locationConstraint);
```

##### aws.s3.Client.getObject

Download an object from Amazon S3 and obtain a streaming handle.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Bucket name. |
| `key` | string | Required. Object key inside the bucket. |

| Returns | Type | Description |
| --- | --- | --- |
| `getObjectResponse` | `aws.s3.model.GetObjectResponse` | Object metadata (ETag, timestamps, etc.). |
| `inputStream` | `software.amazon.awssdk.core.ResponseInputStream` | Stream representing the object payload. |

```matlab
s3 = aws.s3.Client();
[resp, stream] = s3.getObject(bucket="matlab-demo-bucket", key="docs/readme.txt");
copier = com.mathworks.mlwidgets.io.InterruptibleStreamCopier.getInterruptibleStreamCopier();
bao = java.io.ByteArrayOutputStream();
copier.copyStream(stream, bao);
disp(char(bao.toByteArray()));
```

##### aws.s3.Client.getObjectAcl

Retrieve the ACL applied to a stored object.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Bucket containing the object. |
| `key` | string | Required. Object key. |
| `versionId` | string | Optional. Specific version to inspect. |
| `requestPayer` | string | Optional. Specify `"requester"` for requester-pays buckets. |
| `expectedBucketOwner` | string | Optional. AWS account ID expected to own the bucket. |

| Returns | Type | Description |
| --- | --- | --- |
| `getObjectAclResponse` | `aws.s3.model.GetObjectAclResponse` | Owner metadata and grant entries. |

```matlab
s3 = aws.s3.Client();
resp = s3.getObjectAcl(bucket="my-bucket", key="my-object.txt");
disp(resp.owner.displayName);
```

##### aws.s3.Client.headObject

Retrieve metadata for an object without downloading it.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Bucket name. |
| `key` | string | Required. Object key. |
| `ifMatch` | string | Optional. Return metadata only if the ETag matches. |
| `ifModifiedSince` | datetime \\| java.time.Instant | Optional. Conditional header. |
| `ifNoneMatch` | string | Optional. Return metadata only if the ETag differs. |
| `ifUnmodifiedSince` | datetime \\| java.time.Instant | Optional. Conditional header. |
| `partNumber` | double | Optional. Head a particular part of a multipart object. |
| `range` | string | Optional. Byte range to probe. |
| `requestPayer` | string | Optional. Specify `"requester"` when requester pays. |
| `sseCustomerAlgorithm` | string | Optional. SSE-C algorithm used to encrypt the object. |
| `sseCustomerKey` | string | Optional. Base64-encoded SSE-C key. |
| `sseCustomerKeyMD5` | string | Optional. Base64 MD5 of the SSE-C key. |
| `versionId` | string | Optional. Specific version to inspect. |
| `expectedBucketOwner` | string | Optional. AWS account ID expected to own the bucket. |
| `checksumMode` | string | Optional. Enable extended checksum validation when supported. |

| Returns | Type | Description |
| --- | --- | --- |
| `headObjectResponse` | `aws.s3.model.HeadObjectResponse` | Object metadata (content type, length, ETag, etc.). |
| `doesExist` | logical | Indicates whether the object exists (true when the call succeeds). |

```matlab
s3 = aws.s3.Client();
[resp, exists] = s3.headObject(bucket="matlab-demo-bucket", key="logs/output.json");
assert(exists, "Object missing");
disp(resp.contentType);
```

##### aws.s3.Client.initialize

```text
aws.s3.Client/initialize is a function.
    initStat = initialize(obj, regionObj, credentialsProvider)
```

##### aws.s3.Client.listBuckets

List every S3 bucket available to the current account.

| Returns | Type | Description |
| --- | --- | --- |
| `listBucketsResponse` | `aws.s3.model.ListBucketsResponse` | Bucket collection plus owner metadata. |

```matlab
s3 = aws.s3.Client();
resp = s3.listBuckets();
disp(resp.buckets);
```

##### aws.s3.Client.listObjects

List keys within an S3 bucket.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Bucket to enumerate. |
| `prefix` | string | Optional. Restrict results to keys with this prefix. |
| `delimiter` | string | Optional. Character that groups keys hierarchically. |
| `maxKeys` | double | Optional. Maximum number of keys to return (≤ 1000). |
| `continuationToken` | string | Optional. Pagination token from a previous response. |

| Returns | Type | Description |
| --- | --- | --- |
| `listObjectsResponse` | `aws.s3.model.ListObjectsResponse` | Contains object metadata list and pagination hints. |

```matlab
s3 = aws.s3.Client();
resp = s3.listObjects(bucket="my-bucket", prefix="photos/");
keys = arrayfun(@(obj) obj.key, resp.s3Objects);
```

##### aws.s3.Client.deleteBucketPolicy

Remove the bucket policy attached to an S3 bucket.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Bucket name. |
| `expectedBucketOwner` | string | Optional. AWS account ID expected to own the bucket. |

| Returns | Type | Description |
| --- | --- | --- |
| `deleteBucketPolicyResponse` | `aws.s3.model.DeleteBucketPolicyResponse` | HTTP status information from S3. |

```matlab
s3 = aws.s3.Client();
resp = s3.deleteBucketPolicy(bucket="my-bucket");
assert(resp.statusCode == 204);
```

##### aws.s3.Client.putBucketOwnershipControls

Configure Object Ownership settings for a bucket.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Bucket name. |
| `objectOwnership` | string | Required. `"BucketOwnerPreferred"`, `"ObjectWriter"`, or `"BucketOwnerEnforced"`. |
| `expectedBucketOwner` | string | Optional. AWS account ID expected to own the bucket. |

| Returns | Type | Description |
| --- | --- | --- |
| `putBucketOwnershipControlsResponse` | `aws.s3.model.PutBucketOwnershipControlsResponse` | HTTP status information from S3. |

```matlab
s3 = aws.s3.Client();
resp = s3.putBucketOwnershipControls( ...
    bucket="my-bucket", objectOwnership="BucketOwnerPreferred");
```

##### aws.s3.Client.putBucketAcl

Set the ACL for an S3 bucket using canned ACLs or explicit grants.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Bucket name. |
| `acl` | string | Optional. Canned ACL such as `public-read`. |
| `accessControlPolicy` | aws.s3.model.AccessControlPolicy | Optional. Explicit owner + grants. |
| `grantFullControl` | string | Optional. Header-form grant string. |
| `grantRead` | string | Optional. Header-form grant string. |
| `grantReadACP` | string | Optional. Header-form grant string. |
| `grantWrite` | string | Optional. Header-form grant string. |
| `grantWriteACP` | string | Optional. Header-form grant string. |
| `contentMD5` | string | Optional. Base64-encoded MD5 of the ACL payload. |
| `expectedBucketOwner` | string | Optional. AWS account ID expected to own the bucket. |

| Returns | Type | Description |
| --- | --- | --- |
| `putBucketAclResponse` | `aws.s3.model.PutBucketAclResponse` | HTTP status information from S3. |

```matlab
s3 = aws.s3.Client();
resp = s3.putBucketAcl(bucket="my-bucket", acl="public-read");
```

##### aws.s3.Client.putBucketPolicy

Set or replace the bucket policy for an S3 bucket.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Bucket name. |
| `policy` | string | Required. Policy JSON text. |
| `confirmRemoveSelfBucketAccess` | logical | Optional. Confirm removal of the caller's access. |
| `expectedBucketOwner` | string | Optional. AWS account ID expected to own the bucket. |
| `contentMD5` | string | Optional. Base64-encoded MD5 checksum of the policy. |

| Returns | Type | Description |
| --- | --- | --- |
| `putBucketPolicyResponse` | `aws.s3.model.PutBucketPolicyResponse` | HTTP status information from S3. |

```matlab
s3 = aws.s3.Client();
policyStruct = struct(\"Version\",\"2012-10-17\",\"Statement\", struct( ...
    \"Effect\",\"Allow\",\"Principal\",\"*\",\"Action\",\"s3:GetObject\", ...
    \"Resource\",\"arn:aws:s3:::my-bucket/*\"));
resp = s3.putBucketPolicy(bucket=\"my-bucket\", policy=jsonencode(policyStruct));
```

##### aws.s3.Client.putObject

Upload an object to Amazon S3.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Bucket name. |
| `key` | string | Required. Destination object key. |
| `body` | aws.core.model.RequestBody | Required. Payload created via `aws.core.model.RequestBody`. |
| `acl` | string | Optional. Canned ACL such as `public-read`. |
| `contentType` | string | Optional. MIME type stored with the object. |

| Returns | Type | Description |
| --- | --- | --- |
| `putObjectResponse` | `aws.s3.model.PutObjectResponse` | Upload metadata (ETag, version ID, etc.). |

```matlab
s3 = aws.s3.Client();
payload = aws.core.model.RequestBody("hello from MATLAB");
resp = s3.putObject(bucket="matlab-demo-bucket", key="greetings.txt", body=payload);
resp = s3.putObject(bucket="matlab-demo-bucket", key="public.txt", body=payload, acl="public-read");
```

##### aws.s3.Client.putObjectAcl

Set the ACL for a specific object.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `bucket` | string | Required. Bucket containing the object. |
| `key` | string | Required. Object key. |
| `acl` | string | Optional. Canned ACL such as `public-read`. |
| `accessControlPolicy` | aws.s3.model.AccessControlPolicy \\| Java object | Optional. Custom ACL definition. |
| `grantFullControl` | string | Optional. Header-form grant string. |
| `grantRead` | string | Optional. Header-form grant string. |
| `grantReadACP` | string | Optional. Header-form grant string. |
| `grantWrite` | string | Optional. Header-form grant string. |
| `grantWriteACP` | string | Optional. Header-form grant string. |
| `requestPayer` | string | Optional. Set to `"requester"` for requester-pays buckets. |
| `versionId` | string | Optional. Target a specific object version. |
| `expectedBucketOwner` | string | Optional. AWS account ID expected to own the bucket. |

| Returns | Type | Description |
| --- | --- | --- |
| `putObjectAclResponse` | `aws.s3.model.PutObjectAclResponse` | HTTP status information from S3. |

```matlab
s3 = aws.s3.Client();
resp = s3.putObjectAcl(bucket="my-bucket", key="docs/report.pdf", acl="public-read");
```

##### aws.s3.Client.saveS3ResponseInputStreamToFile

Persist the ResponseInputStream from `getObject` to a local file.

| Input | Type | Description |
| --- | --- | --- |
| `responseInputStream` | software.amazon.awssdk.core.ResponseInputStream | Stream returned from `getObject`. |
| `localFilePath` | string | Destination path for the downloaded bytes. |

```matlab
[resp, inStream] = s3.getObject(bucket="my-bucket", key="logs/output.gz");
s3.saveS3ResponseInputStreamToFile(inStream, "output.gz");
```

#### aws.secretsmanager

#### aws.secretsmanager.model

##### aws.secretsmanager.model.CreateSecretResponse

| Property | Type | Description |
| --- | --- | --- |
| `arn` | string | ARN of the secret that was created. |

##### aws.secretsmanager.model.DeleteSecretResponse

| Property | Type | Description |
| --- | --- | --- |
| `arn` | string | ARN of the secret that was scheduled for deletion. |

##### aws.secretsmanager.model.GetSecretValueResponse

| Property | Type | Description |
| --- | --- | --- |
| `arn` | string | ARN of the secret whose value was fetched. |
| `secretString` | string | UTF-8 payload returned by AWS Secrets Manager. |
| `secretBinary` | uint8 array | Binary payload converted from the SDK `SdkBytes` response. |

##### aws.secretsmanager.model.ListSecretsResponse

| Property | Type | Description |
| --- | --- | --- |
| `secrets` | aws.secretsmanager.model.SecretListEntry array | Metadata for each secret returned in the page. |
| `nextToken` | string | Pagination token for additional results (empty when finished). |

##### aws.secretsmanager.model.RestoreSecretResponse

| Property | Type | Description |
| --- | --- | --- |
| `arn` | string | ARN of the restored secret. |
| `name` | string | Friendly name of the restored secret. |

##### aws.secretsmanager.model.SecretListEntry

| Property | Type | Description |
| --- | --- | --- |
| `arn` | string | ARN that uniquely identifies the secret. |
| `description` | string | Description assigned to the secret. |
| `kmsKeyId` | string | KMS key ID used to encrypt the secret (if customer managed). |
| `name` | string | Name of the secret. |
| `createdDate` | datetime | MATLAB `datetime` converted from the Java `Instant`. |

##### aws.secretsmanager.model.UpdateSecretResponse

| Property | Type | Description |
| --- | --- | --- |
| `arn` | string | ARN of the updated secret. |
| `name` | string | Name of the updated secret. |
| `versionId` | string | Identifier of the newly created secret version. |

#### aws.secretsmanager.Client

Interact with AWS Secrets Manager to create, rotate, restore, and retrieve application secrets.

##### aws.secretsmanager.Client.Client

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `'region'` | string | Optional. Region override for the client. |
| `'credentialsprovider'` | aws.auth.CredentialProvider | Optional. Custom credentials provider instance. |

##### aws.secretsmanager.Client.createSecret

Create a new secret containing text or binary data.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `name` | string | Required. Unique name for the secret (can include path-style segments). |
| `secretString` | string | Required when not sending `secretBinary`. Plaintext payload that AWS encrypts at rest. |
| `secretBinary` | aws.core.model.SdkBytes | Optional. Binary secret payload (use `aws.core.model.SdkBytes`). |
| `description` | string | Optional. Description for operators. |
| `tag` | dictionary | Optional. Map of tag key -> value strings applied to the secret. |

| Returns | Type | Description |
| --- | --- | --- |
| `createSecretResponse` | `aws.secretsmanager.model.CreateSecretResponse` | ARN/metadata for the new secret. |

##### aws.secretsmanager.Client.deleteSecret

Schedule a secret for deletion.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `secretId` | string | Required. Secret ARN or friendly name. |
| `recoveryWindowInDays` | int64 | Optional. Number of days (7-30) before permanent removal. |
| `forceDeleteWithoutRecovery` | logical | Optional. Set `true` to delete immediately with no recovery window. |

| Returns | Type | Description |
| --- | --- | --- |
| `deleteSecretResponse` | `aws.secretsmanager.model.DeleteSecretResponse` | ARN of the deleted/queued secret. |

##### aws.secretsmanager.Client.getSecretValue

Retrieve the latest or a specific version of a secret.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `secretId` | string | Required. Secret ARN or name. |
| `versionId` | string | Optional. Specific version identifier to fetch. |

| Returns | Type | Description |
| --- | --- | --- |
| `getSecretValueResponse` | `aws.secretsmanager.model.GetSecretValueResponse` | Contains text or binary secret payload. |

##### aws.secretsmanager.Client.initialize

aws.secretsmanager.Client/initialize is a function.

##### aws.secretsmanager.Client.listSecrets

List secrets in the account with optional pagination.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `nextToken` | string | Optional. Continue listing from a prior response. |
| `maxResults` | int32 | Optional. Limit the number of entries returned. |
| `sortOrder` | string | Optional. `"asc"` or `"desc"` order based on last changed date. |

| Returns | Type | Description |
| --- | --- | --- |
| `listSecretsResponse` | `aws.secretsmanager.model.ListSecretsResponse` | Page of secret metadata plus `nextToken`. |

##### aws.secretsmanager.Client.restoreSecret

Restore a secret that is pending deletion within its recovery window.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `secretId` | string | Required. Secret ARN or name scheduled for deletion. |

| Returns | Type | Description |
| --- | --- | --- |
| `restoreSecretResponse` | `aws.secretsmanager.model.RestoreSecretResponse` | Metadata for the restored secret. |

##### aws.secretsmanager.Client.updateSecret

Create a new version of an existing secret with updated metadata or payload.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `secretId` | string | Required. Secret ARN or name to update. |
| `secretString` | string | Optional. New plaintext secret to store. |
| `secretBinary` | aws.core.model.SdkBytes | Optional. New binary payload. |
| `description` | string | Optional. Updated description text. |
| `kmsKeyId` | string | Optional. Customer managed CMK ARN/ID for encryption. |
| `clientRequestToken` | string | Optional. Idempotency token you control. |

| Returns | Type | Description |
| --- | --- | --- |
| `updateSecretResponse` | `aws.secretsmanager.model.UpdateSecretResponse` | ARN, name, and new version ID. |

#### aws.sns

#### aws.sns.model

##### aws.sns.model.ConfirmSubscriptionResponse

| Property | Type | Description |
| --- | --- | --- |
| `subscriptionArn` | string | ARN assigned when the token is confirmed. |

##### aws.sns.model.CreateTopicResponse

| Property | Type | Description |
| --- | --- | --- |
| `topicArn` | string | ARN of the created (or existing) topic. |

##### aws.sns.model.DeleteTopicResponse

| Property | Type | Description |
| --- | --- | --- |
| `statusCode` | int32 | HTTP status returned by the SDK for diagnostics. |

##### aws.sns.model.GetSubscriptionAttributesResponse

| Property | Type | Description |
| --- | --- | --- |
| `attributes` | dictionary | Map of subscription attributes (string -> string). |

##### aws.sns.model.GetTopicAttributesResponse

| Property | Type | Description |
| --- | --- | --- |
| `attributes` | dictionary | Topic attributes represented as string pairs. |

##### aws.sns.model.ListSubscriptionsResponse

| Property | Type | Description |
| --- | --- | --- |
| `subscriptions` | struct array | Each entry exposes `subscriptionArn`, `topicArn`, `protocol`, `endpoint`, `owner`. |
| `nextToken` | string | Pagination token for additional pages. |

##### aws.sns.model.ListTopicsResponse

| Property | Type | Description |
| --- | --- | --- |
| `topics` | string array | Topic ARNs returned in this page. |
| `nextToken` | string | Pagination token when more results remain. |

##### aws.sns.model.MessageAttributeValue

Represents per-message attributes for the `publish` API.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `dataType` | string | Required. SNS data type such as "String", "Number", or "Binary". |
| `stringValue` | string | Optional. Text payload for the attribute. |
| `binaryValue` | aws.core.model.SdkBytes | Optional. Binary payload when `dataType` is Binary. |

##### aws.sns.model.PublishResponse

| Property | Type | Description |
| --- | --- | --- |
| `messageId` | string | Identifier assigned to the published message. |

##### aws.sns.model.SubscribeResponse

| Property | Type | Description |
| --- | --- | --- |
| `subscriptionArn` | string | Subscription ARN or "pending confirmation". |

##### aws.sns.model.UnsubscribeResponse

| Property | Type | Description |
| --- | --- | --- |
| `statusCode` | int32 | HTTP status returned by the SDK. |

#### aws.sns.Client

Interact with Amazon Simple Notification Service topics and subscriptions.

##### aws.sns.Client.Client

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `'region'` | string | Optional region override; defaults to the credential provider region. |
| `'credentialsprovider'` | aws.auth.CredentialProvider | Optional credentials source. |
| `'isCrt'` | logical | When `true`, use the AWS Common Runtime HTTP client. |

| Returns | Type | Description |
| --- | --- | --- |
| `sns` | `aws.sns.Client` | Client configured for the requested region. |

```matlab
sns = aws.sns.Client('region',"us-east-1");
```

##### aws.sns.Client.confirmSubscription

Confirm a pending subscription token.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `topicArn` | string | Required. Topic ARN being confirmed. |
| `token` | string | Required. Token from the Subscribe confirmation message. |
| `authenticateOnUnsubscribe` | string | Optional. Set to "true" to enforce authenticated unsubscribe requests. |

| Returns | Type | Description |
| --- | --- | --- |
| `confirmSubscriptionResponse` | `aws.sns.model.ConfirmSubscriptionResponse` | Contains the confirmed subscription ARN. |

##### aws.sns.Client.createTopic

Create (or retrieve) an SNS topic.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `name` | string | Required. Topic name (FIFO topics must end with `.fifo`). |
| `attributesWithStrings` | dictionary | Optional. Topic attributes (e.g., `DisplayName`). |
| `tags` | dictionary | Optional. Cost allocation tags (string -> string). |

| Returns | Type | Description |
| --- | --- | --- |
| `createTopicResponse` | `aws.sns.model.CreateTopicResponse` | Provides the topic ARN. |

##### aws.sns.Client.deleteTopic

Delete an SNS topic.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `topicArn` | string | Required. ARN of the topic to delete. |

| Returns | Type | Description |
| --- | --- | --- |
| `deleteTopicResponse` | `aws.sns.model.DeleteTopicResponse` | HTTP status metadata. |

##### aws.sns.Client.getSubscriptionAttributes

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `subscriptionArn` | string | Required. Subscription ARN to inspect. |

| Returns | Type | Description |
| --- | --- | --- |
| `getSubscriptionAttributesResponse` | `aws.sns.model.GetSubscriptionAttributesResponse` | Attribute map with key/value strings. |

##### aws.sns.Client.getTopicAttributes

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `topicArn` | string | Required. Topic ARN to inspect. |

| Returns | Type | Description |
| --- | --- | --- |
| `getTopicAttributesResponse` | `aws.sns.model.GetTopicAttributesResponse` | Attribute map with key/value strings. |

##### aws.sns.Client.listSubscriptions

List subscriptions with optional pagination.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `nextToken` | string | Optional. Continue from a previous response. |

| Returns | Type | Description |
| --- | --- | --- |
| `listSubscriptionsResponse` | `aws.sns.model.ListSubscriptionsResponse` | Subscription structs plus `nextToken`. |

##### aws.sns.Client.listTopics

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `nextToken` | string | Optional. Continue from a previous `listTopics` call. |

| Returns | Type | Description |
| --- | --- | --- |
| `listTopicsResponse` | `aws.sns.model.ListTopicsResponse` | Topic ARNs plus pagination token. |

##### aws.sns.Client.publish

Publish a payload to a topic or endpoint.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `topicArn` | string | Required when publishing to a topic. |
| `message` | string | Required. UTF-8 payload. |
| `subject` | string | Optional. Subject line (<= 100 chars). |
| `messageAttributes` | dictionary | Optional. Map of attribute name -> `aws.sns.model.MessageAttributeValue`. |

| Returns | Type | Description |
| --- | --- | --- |
| `publishResponse` | `aws.sns.model.PublishResponse` | Contains the published message ID. |

##### aws.sns.Client.subscribe

Register an endpoint with a topic.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `topicArn` | string | Required. Topic to subscribe to. |
| `protocol` | string | Required. Delivery protocol (`"lambda"`, `"email"`, `"sqs"`, etc.). |
| `endpoint` | string | Required. Endpoint ARN, email address, or URL. |

| Returns | Type | Description |
| --- | --- | --- |
| `SubscribeResponse` | `aws.sns.model.SubscribeResponse` | Contains the subscription ARN or `pending confirmation`. |

##### aws.sns.Client.unsubscribe

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `subscriptionArn` | string | Required. Subscription to remove. |

| Returns | Type | Description |
| --- | --- | --- |
| `unsubscribeResponse` | `aws.sns.model.UnsubscribeResponse` | HTTP status metadata. |


#### aws.sqs

#### aws.sqs.model

#### aws.sqs.model.CreateQueueResponse

| Property | Type | Description |
| --- | --- | --- |
| queueUrl | string | URL of the created queue. |
#### aws.sqs.model.DeleteMessageResponse

| Property | Type | Description |
| --- | --- | --- |
| statusCode | int32 | HTTP status returned by the SDK. |
#### aws.sqs.model.DeleteQueueResponse

Superclass: aws.Object

```text
DELETEQUEUERESPONSE Object to represent the Response of a deleteQueue
  call. This class encapsulates the response from the DeleteQueue operation
  in Amazon SQS. Typically, the operation is confirmed by the absence
  of exceptions.
```

##### aws.sqs.model.DeleteQueueResponse.DeleteQueueResponse

```text
DELETEQUEUERESPONSE Object to represent the Response of a deleteQueue
  call. This class encapsulates the response from the DeleteQueue operation
  in Amazon SQS. Typically, the operation is confirmed by the absence
  of exceptions.
```

#### aws.sqs.model.GetQueueAttributesResponse

Superclass: aws.Object

```text
GETQUEUEATTRIBUTESRESPONSE Object to represent the result of a getQueueAttributes call.
 
  This class encapsulates the response from the GetQueueAttributes operation
  in Amazon SQS, providing access to the queue attributes as a dictionary.
 
  Example:
     getQueueAttributesResult = sqs.getQueueAttributes(queueUrl, attributeNames);
     attributes = getQueueAttributesResult.attributes;
     maximumMessageSize = attributes("MaximumMessageSize");
```

##### aws.sqs.model.GetQueueAttributesResponse.GetQueueAttributesResponse

```text
GETQUEUEATTRIBUTESRESPONSE Object to represent the result of a getQueueAttributes call.
 
  This class encapsulates the response from the GetQueueAttributes operation
  in Amazon SQS, providing access to the queue attributes as a dictionary.
 
  Example:
     getQueueAttributesResult = sqs.getQueueAttributes(queueUrl, attributeNames);
     attributes = getQueueAttributesResult.attributes;
     maximumMessageSize = attributes("MaximumMessageSize");
```

#### aws.sqs.model.ListQueuesResponse

Superclass: aws.Object

```text
LISTQUEUESRESPONSE Response object for listing SQS queues.
 
  This class encapsulates the response from the ListQueues operation
  in Amazon SQS, providing access to the list of queue URLs.
 
  Example:
     listQueuesResponse = sqs.listQueues();
     queueUrls = listQueuesResponse.queueUrls;
```

##### aws.sqs.model.ListQueuesResponse.ListQueuesResponse

```text
LISTQUEUESRESPONSE Response object for listing SQS queues.
 
  This class encapsulates the response from the ListQueues operation
  in Amazon SQS, providing access to the list of queue URLs.
 
  Example:
     listQueuesResponse = sqs.listQueues();
     queueUrls = listQueuesResponse.queueUrls;
```

#### aws.sqs.model.Message

Superclass: aws.Object

```text
MESSAGE Object to represent an SQS message
 
  Example:
     receiveMessageResult = sqs.receiveMessage(queueUrl);
     messages = receiveMessageResult.getMessages();
     for n = 1:numel(messages)
        id = messages{n}.getMessageId();
        receiptHandle = messages{n}.getReceiptHandle();
        body = messages{n}.getBody();
     end
```

##### aws.sqs.model.Message.Message

```text
MESSAGE Object to represent an SQS message
 
  Example:
     receiveMessageResult = sqs.receiveMessage(queueUrl);
     messages = receiveMessageResult.getMessages();
     for n = 1:numel(messages)
        id = messages{n}.getMessageId();
        receiptHandle = messages{n}.getReceiptHandle();
        body = messages{n}.getBody();
     end
```

#### aws.sqs.model.ReceiveMessageResponse

Superclass: aws.Object

```text
RECEIVEMESSAGERESPONSE Response object for receiving messages from an SQS queue.
 
  This class encapsulates the response from the ReceiveMessage operation
  in Amazon SQS, providing access to the messages received.
  Example:
     receiveMessageResponse = sqs.receiveMessage(receiveMessageRequest);
     messagesReceived = receiveMessageResponse.messages
```

##### aws.sqs.model.ReceiveMessageResponse.ReceiveMessageResponse

```text
RECEIVEMESSAGERESPONSE Response object for receiving messages from an SQS queue.
 
  This class encapsulates the response from the ReceiveMessage operation
  in Amazon SQS, providing access to the messages received.
  Example:
     receiveMessageResponse = sqs.receiveMessage(receiveMessageRequest);
     messagesReceived = receiveMessageResponse.messages
```

#### aws.sqs.model.SendMessageResponse

Superclass: aws.Object

```text
SENDMESSAGERESPONSE Response object for sending a message to an SQS queue.
 
  This class encapsulates the response from the SendMessage operation
  in Amazon SQS, providing access to message ID and other relevant
  response properties.
```

##### aws.sqs.model.SendMessageResponse.SendMessageResponse

```text
SENDMESSAGERESPONSE Response object for sending a message to an SQS queue.
 
  This class encapsulates the response from the SendMessage operation
  in Amazon SQS, providing access to message ID and other relevant
  response properties.
```

#### aws.sqs.model.SetQueueAttributesResponse

Superclass: aws.Object

```text
SETQUEUEATTRIBUTESRESPONSE Object to represent the result of a setQueueAttributes call.
 
  This class encapsulates the response from the SetQueueAttributes operation
  in Amazon SQS. Since setting attributes typically does not return data,
  this class is primarily used for consistency and potential future extensions.
```

##### aws.sqs.model.SetQueueAttributesResponse.SetQueueAttributesResponse

```text
SETQUEUEATTRIBUTESRESPONSE Object to represent the result of a setQueueAttributes call.
 
  This class encapsulates the response from the SetQueueAttributes operation
  in Amazon SQS. Since setting attributes typically does not return data,
  this class is primarily used for consistency and potential future extensions.
```

#### aws.sqs.model.ChangeMessageVisibilityResponse

Superclass: aws.Object

```text
CHANGEMESSAGEVISIBILITYRESPONSE Object to represent the result of a ChangeMessageVisibility call.
 
  This class encapsulates the response metadata returned after updating the visibility
  timeout for a single message. The HTTP status code is exposed for diagnostics.
 
  Example:
     resp = sqs.changeMessageVisibility(queueUrl='url', receiptHandle='handle', visibilityTimeout=120);
     status = resp.statusCode;
```

##### aws.sqs.model.ChangeMessageVisibilityResponse.ChangeMessageVisibilityResponse

```text
CHANGEMESSAGEVISIBILITYRESPONSE Object to represent the result of a ChangeMessageVisibility call.
 
  This class encapsulates the response metadata returned after updating the visibility
  timeout for a single message. The HTTP status code is exposed for diagnostics.
```

#### aws.sqs.model.ChangeMessageVisibilityBatchResponse

Superclass: aws.Object

```text
CHANGEMESSAGEVISIBILITYBATCHRESPONSE Object to represent the result of a ChangeMessageVisibilityBatch call.
 
  The response exposes two collections, one for successful entries and another for failures,
  matching the AWS SDK response structure.
 
  Example:
     resp = sqs.changeMessageVisibilityBatch(queueUrl='url', entries=entriesStruct);
     successes = resp.successful;
     failures = resp.failed;
```

##### aws.sqs.model.ChangeMessageVisibilityBatchResponse.ChangeMessageVisibilityBatchResponse

```text
CHANGEMESSAGEVISIBILITYBATCHRESPONSE Object to represent the result of a ChangeMessageVisibilityBatch call.
 
  The response exposes two collections, one for successful entries and another for failures,
  matching the AWS SDK response structure.
```

#### aws.sqs.model.ChangeMessageVisibilityBatchResultEntry

Superclass: aws.Object

```text
CHANGEMESSAGEVISIBILITYBATCHRESULTENTRY Represents one successful entry from ChangeMessageVisibilityBatch.
 
  Only the identifier supplied in the request is returned when the update succeeds.
```

##### aws.sqs.model.ChangeMessageVisibilityBatchResultEntry.ChangeMessageVisibilityBatchResultEntry

```text
CHANGEMESSAGEVISIBILITYBATCHRESULTENTRY Represents one successful entry from ChangeMessageVisibilityBatch.
 
  Only the identifier supplied in the request is returned when the update succeeds.
```

#### aws.sqs.model.BatchResultErrorEntry

Superclass: aws.Object

```text
BATCHRESULTERRORENTRY Represents an error for one entry in a batch queue operation.
 
  Contains the entry ID, error code, message, and whether the failure was caused
  by the caller (senderFault = true).
```

##### aws.sqs.model.BatchResultErrorEntry.BatchResultErrorEntry

```text
BATCHRESULTERRORENTRY Represents an error for one entry in a batch queue operation.
 
  Contains the entry ID, error code, message, and whether the failure was caused
  by the caller (senderFault = true).
```

#### aws.sqs.Client

Superclass: aws.core.BaseClient

```text
CLIENT Amazon Simple Queue Service (SQS) Client
 
  This client is used to interact with the Amazon SQS service, allowing
  you to send, receive, and manage messages in your queues.
 
  Example:
        sqs = aws.sqs.Client();
        % Perform operations with SQS
        sqs.createQueue('myQueueName');
 
  Authentication Credentials - Please see the authentication section
  of the documentation for more details.
```

##### aws.sqs.Client.Client

```text
CLIENT Amazon Simple Queue Service (SQS) Client
 
  This client is used to interact with the Amazon SQS service, allowing
  you to send, receive, and manage messages in your queues.
 
  Example:
        sqs = aws.sqs.Client();
        % Perform operations with SQS
        sqs.createQueue('myQueueName');
 
  Authentication Credentials - Please see the authentication section
  of the documentation for more details.
```

##### aws.sqs.Client.createQueue

```text
CREATEQUEUE Creates a new Amazon SQS queue and returns a CreateQueueResponse object.
 
  This function facilitates the creation of a queue in Amazon SQS. It supports
  various options for configuration. For more detailed queue creation, consider
  using the underlying AWS SDK classes and methods directly.
 
  Arguments:
  queueName : The name of the new queue.
 
  Optional Arguments:
  attributesWithStrings : A map of attributes with their corresponding values.
  tags : Cost allocation tags for the queue.
 
  Example:
  sqs = aws.sqs.Client()
  createQueueResponse = sqs.createQueue(queueName='queue_name')
  OR
  attr = dictionary({'MaximumMessageSize', 'DelaySeconds'}, {'262144', '5'});
  createQueueResponse = sqs.createQueue(queueName='queue_name', attributesWithStrings = attr);
```

##### aws.sqs.Client.deleteMessage

Remove a message from an SQS queue using its receipt handle.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `queueUrl` | string | Required. Queue URL containing the message. |
| `receiptHandle` | string | Required. Handle returned by `receiveMessage`. |

| Returns | Type | Description |
| --- | --- | --- |
| `deleteMessageResponse` | `aws.sqs.model.DeleteMessageResponse` | HTTP metadata confirming the delete call. |

```matlab
resp = sqs.deleteMessage(queueUrl=myQueueUrl, receiptHandle=handle);
```

##### aws.sqs.Client.deleteQueue

Delete an SQS queue.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `queueUrl` | string | Required. Queue URL to remove. |

| Returns | Type | Description |
| --- | --- | --- |
| `deleteQueueResponse` | `aws.sqs.model.DeleteQueueResponse` | HTTP metadata returned by the SDK. |

```matlab
resp = sqs.deleteQueue(queueUrl=myQueueUrl);
```

##### aws.sqs.Client.getQueueAttributes

```text
GETQUEUEATTRIBUTES Retrieves attributes for the specified Amazon SQS queue.
 
  This function retrieves attributes from a specified SQS queue. It supports
  optional configurations to specify which attributes to retrieve.
 
  Arguments:
    queueUrl : The URL of the Amazon SQS queue from which attributes are retrieved.
 
  Optional Arguments:
    attributeNamesWithStrings : Names of the attributes to retrieve.
 
  Example:
  sqs = aws.sqs.Client();
  getQueueAttributesResponse = sqs.getQueueAttributes(queueUrl='queueUrl');
  OR
  getQueueAttributesResponse = sqs.getQueueAttributes(queueUrl='queueUrl', attributeNamesWithStrings = ["All"]);
```

##### aws.sqs.Client.initialize

```text
aws.sqs.Client/initialize is a function.
    initStat = initialize(obj, regionObj, credentialsProvider)
```

##### aws.sqs.Client.listQueues

```text
LISTQUEUES Lists the Amazon SQS queues.
 
  This function retrieves a list of SQS queues. It supports optional configurations
  to filter the queues based on specific criteria.
 
  Optional Arguments:
    queueNamePrefix : A string to use for filtering the list results.
    maxResults : The maximum number of results to return.
    nextToken : Token to specify where to start paginating.
 
  Example:
  sqs = aws.sqs.Client();
  listQueuesResponse = sqs.listQueues();
  OR
  listQueuesResponse = sqs.listQueues(queueNamePrefix = 'myQueue', maxResults = 10);
```

##### aws.sqs.Client.receiveMessage

```text
RECEIVEMESSAGE Receives messages from the specified Amazon SQS queue.
 
  This function retrieves messages from a specified SQS queue. It supports
  various optional configurations to customize the message retrieval process.
 
  Arguments:
    queueUrl : The URL of the Amazon SQS queue from which messages are received.
 
  Optional Arguments:
    maxNumberOfMessages : The maximum number of messages to return.
    messageAttributeNames : Names of the message attributes to retrieve.
    messageSystemAttributeNamesWithStrings : System attributes to retrieve with each message.
    visibilityTimeout : Duration (in seconds) messages are hidden after retrieval.
    waitTimeSeconds : Duration (in seconds) to wait for a message to arrive.
    receiveRequestAttemptId : Applies only to FIFO queues.
 
  Example:
  sqs = aws.sqs.Client();
  receiveMessageResponse = sqs.receiveMessage(queueUrl='queueUrl');
  OR
  receiveMessageResponse = sqs.receiveMessage(queueUrl='queueUrl', maxNumberOfMessages = 5, waitTimeSeconds = 10);
```

##### aws.sqs.Client.sendMessage

```text
SENDMESSAGE Sends a message to the specified Amazon SQS queue.
  A message can include only XML, JSON, and unformatted text. The following
  Unicode characters are allowed:
 
  #x9 | #xA | #xD | #x20 to #xD7FF | #xE000 to #xFFFD | #x10000 to #x10FFFF
 
  Any characters not included in this list will be rejected.
  Duplicate messages are allowed. A SendMessageResponse object is returned.
  The upper limit and default maximum message size is 262144 bytes.
 
  Arguments:
    queueUrl : The URL of the Amazon SQS queue to which the message is sent.
    messageBody : The body of the message to be sent.
 
  Optional Arguments:
    delaySeconds : The duration (in seconds) to delay the message.
    messageAttributes : Custom attributes to be associated with the message.
    messageDeduplicationId : A token used for deduplication of sent messages.
    messageGroupId : Tag that specifies that a message belongs to a specific message group.
 
  Example:
  sqs = aws.sqs.Client();
  sendMessageResponse = sqs.sendMessage(queueUrl='queue_Url', messageBody='Hello, World!');
  OR
  sendMessageResponse = sqs.sendMessage(queueUrl='queue_Url', messageBody='Hello, World!', delaySeconds = 5);
```

##### aws.sqs.Client.setQueueAttributes

```text
SETQUEUEATTRIBUTES Sets attributes for the specified Amazon SQS queue.
  This function sets attributes for a specified SQS queue. The attributes
  should be provided as a dictionary. When you change a queue's attributes 
  the change can take up to 60 seconds for the attributes to propagate 
  throughout the SQS system. However, changes made to the MessageRetentionPeriod 
  attribute can take up to 15 minutes. A list of parameters can be found 
  in the parameters section
 
  Arguments:
    queueUrl : The URL of the Amazon SQS queue to which attributes are set.
    attributesWithStrings : A dictionary or structure containing attribute names and values.
 
  Example:
  sqs = aws.sqs.Client();
  attributes = dictionary(["VisibilityTimeout", "MaximumMessageSize"], ["60", "262144"]);
  setQueueAttributesResponse = sqs.setQueueAttributes(queueUrl='queueUrl', attributesWithStrings = attributes);
```

##### aws.sqs.Client.changeMessageVisibility

```text
CHANGEMESSAGEVISIBILITY Changes the visibility timeout for a single message.
 
  Arguments:
    queueUrl          : The URL of the queue that contains the message.
    receiptHandle     : The receipt handle returned by receiveMessage.
    visibilityTimeout : The new timeout value (0 to 43200 seconds).
 
  Example:
  resp = sqs.changeMessageVisibility(queueUrl='queueUrl', ...
      receiptHandle='handle', visibilityTimeout=120);
```

##### aws.sqs.Client.changeMessageVisibilityBatch

```text
CHANGEMESSAGEVISIBILITYBATCH Changes visibility timeouts for up to 10 messages.
 
  Arguments:
    queueUrl : The URL of the queue that contains the messages.
    entries  : Struct array with fields id, receiptHandle, visibilityTimeout.
              Each struct element represents one batch entry.
 
  Example:
  entries = struct( ...
      'id', ["msg1","msg2"], ...
      'receiptHandle', ["handle1","handle2"], ...
      'visibilityTimeout', [60 180]);
  resp = sqs.changeMessageVisibilityBatch(queueUrl='queueUrl', entries=entries);
```

#### aws.ssm

Manage AWS Systems Manager documents and Parameter Store values from MATLAB.

#### aws.ssm.model

##### aws.ssm.model.CreateDocumentResponse

| Property | Type | Description |
| --- | --- | --- |
| `documentDescription` | aws.ssm.model.DocumentDescription | Metadata for the newly created document. |

##### aws.ssm.model.DeleteDocumentResponse

| Property | Type | Description |
| --- | --- | --- |
| `status` | string | Returns "Success" when the document delete request completed. |

##### aws.ssm.model.DeleteParameterResponse

| Property | Type | Description |
| --- | --- | --- |
| `status` | string | Returns "Success" when the parameter delete request completed. |

##### aws.ssm.model.DocumentDescription

| Property | Type | Description |
| --- | --- | --- |
| `name` | string | Document name. |
| `documentType` | string | Classification such as "Command" or "Automation". |
| `documentFormat` | string | "JSON" or "YAML". |
| `status` | string | Current publication status. |
| `versionName` | string | Friendly alias for the version, when supplied. |
| `documentVersion` | string | Version number assigned by Systems Manager. |

##### aws.ssm.model.GetParameterResponse

| Property | Type | Description |
| --- | --- | --- |
| `name` | string | Parameter name. |
| `arn` | string | Amazon Resource Name identifying the parameter. |
| `type` | string | "String", "StringList", or "SecureString". |
| `value` | string | Parameter value (decrypted when `withDecryption=true`). |
| `version` | double | Parameter version number. |

##### aws.ssm.model.PutParameterResponse

| Property | Type | Description |
| --- | --- | --- |
| `version` | double | Version assigned after the put/update call. |

#### aws.ssm.Client

Interact with Systems Manager documents and Parameter Store from MATLAB.

##### aws.ssm.Client.Client

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `'region'` | string | Optional region override; defaults to the shared credential region. |
| `'credentialsprovider'` | aws.auth.CredentialProvider | Optional custom credential chain. |
| `'isCrt'` | logical | Use the AWS Common Runtime HTTP stack when `true`. |

| Returns | Type | Description |
| --- | --- | --- |
| `ssm` | `aws.ssm.Client` | Client configured for Systems Manager API calls. |

```matlab
ssm = aws.ssm.Client('region',"us-east-1");
```

##### aws.ssm.Client.createDocument

Create or update a Systems Manager document.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `content` | string | Required. JSON or YAML definition of the document body. |
| `name` | string | Required. Friendly name for the document. |
| `documentType` | string | Required. "Command", "Policy", "Automation", "Session", "Package", "ApplicationConfiguration", "ApplicationConfigurationSchema", "DeploymentStrategy", or "ChangeCalendar". |
| `documentFormat` | string | Optional. "JSON" (default) or "YAML". |

| Returns | Type | Description |
| --- | --- | --- |
| `createDocumentResponse` | `aws.ssm.model.CreateDocumentResponse` | Contains the resulting document metadata. |

##### aws.ssm.Client.deleteDocument

Remove a Systems Manager document.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `name` | string | Required. Name of the document to delete. |

| Returns | Type | Description |
| --- | --- | --- |
| `deleteDocumentResponse` | `aws.ssm.model.DeleteDocumentResponse` | Delete status metadata. |

##### aws.ssm.Client.deleteParameter

Remove a parameter from the Parameter Store.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `name` | string | Required. Fully-qualified parameter name. |

| Returns | Type | Description |
| --- | --- | --- |
| `deleteParameterResponse` | `aws.ssm.model.DeleteParameterResponse` | Delete status metadata. |

##### aws.ssm.Client.getParameter

Read a Parameter Store value.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `name` | string | Required. Parameter path or friendly name. |
| `withDecryption` | logical | Optional. Set `true` to decrypt SecureString values. |

| Returns | Type | Description |
| --- | --- | --- |
| `getParameterResponse` | `aws.ssm.model.GetParameterResponse` | Contains the parameter metadata and value. |

##### aws.ssm.Client.initialize

```text
aws.ssm.Client/initialize is a function.
    initStat = initialize(obj, regionObj, credentialsProvider)
```

##### aws.ssm.Client.putParameter

Create or update a Parameter Store value.

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `name` | string | Required. Parameter path or name. |
| `value` | string | Required. Value to store. |
| `type` | string | Optional. "String" (default), "StringList", or "SecureString". |
| `overwrite` | logical | Optional. Set `true` to replace existing values. |

| Returns | Type | Description |
| --- | --- | --- |
| `putParameterResponse` | `aws.ssm.model.PutParameterResponse` | Provides the resulting version number. |
#### aws.sts

#### aws.sts.model

#### aws.sts.model.GetCallerIdentityResponse

Superclass: aws.Object

Represents the metadata returned by `getCallerIdentity`.

| Property | Type | Description |
| --- | --- | --- |
| `accountId` | string | AWS account ID of the caller. |
| `arn` | string | Full ARN (user or role) of the caller. |
| `userId` | string | IAM user or role unique identifier. |

```matlab
resp = sts.getCallerIdentity();
disp(resp.arn);
```

##### aws.sts.model.GetCallerIdentityResponse.GetCallerIdentityResponse

Wrap an existing AWS SDK response.

```matlab
javaResp = software.amazon.awssdk.services.sts.model.GetCallerIdentityResponse.builder() ...
    .account("123456789012").arn("arn:aws:iam::123456789012:user/demo").userId("demo").build();
resp = aws.sts.model.GetCallerIdentityResponse(javaResp);
```

#### aws.sts.Client

Superclass: aws.core.BaseClient

##### aws.sts.Client.Client

| Name-Value Argument | Type | Description |
| --- | --- | --- |
| `region` | string \\| software.amazon.awssdk.regions.Region | Optional. Region override. |
| `credentialsprovider` | aws.auth.CredentialProvider | Optional. Credential provider override. |
| `isCrt` | logical | Optional. Use the AWS Common Runtime HTTP client when true. |

```matlab
sts = aws.sts.Client('region',"us-east-1");
```

##### aws.sts.Client.getCallerIdentity

Retrieve the AWS Account, ARN, and user ID for the current credentials.

| Returns | Type | Description |
| --- | --- | --- |
| `response` | `aws.sts.model.GetCallerIdentityResponse` | Caller identity metadata. |

```matlab
resp = sts.getCallerIdentity();
fprintf("Caller ARN: %s\n", resp.arn);
```

##### aws.sts.Client.initialize

```text
aws.sts.Client/initialize is a function.
    initStat = initialize(obj, regionObj, credentialsProvider)
```

#### aws.Object

Superclass: handle

Shared base class for every MATLAB AWS wrapper. Provides logging,
proxy-configuration helpers, and a placeholder for the underlying Java
handle.

##### aws.Object.Object

Construct the base helper. Subclasses call this automatically when they
inherit from `aws.Object`.

##### aws.Object.configProxyHttpClient

Build an Apache HTTP client builder that honors `obj.ProxyConfiguration`.

| Returns | Type | Description |
| --- | --- | --- |
| `httpClientBuilder` | `software.amazon.awssdk.http.apache.ApacheHttpClient$Builder` \| [] | Configured builder or empty when no proxy settings are defined. |

##### aws.Object.initializeLogger

Configure the shared logger prefix used by MATLAB AWS objects.

| Positional Argument | Type | Description |
| --- | --- | --- |
| `clientPrefix` | string | Optional. Prefix added to every log message. |

##### aws.Object.useMATLABProxyPrefs

Populate `ProxyConfiguration` using MATLAB's proxy preferences (and the
system proxy on Windows) when no proxy host is currently set.

| Positional Argument | Type | Description |
| --- | --- | --- |
| `url` | string | Optional. URL used when querying the host OS for proxy settings. |

#### Logger

```text
LOGGER Robust, extensible logger for MATLAB scripts and applications.
 
    Provides log levels, colored output, file logging with rotation,
    and JSON/plain text formats.
 
    ================
    Syntax
    ================
    log = Logger.getLogger();
    log.write(level, message, ...);
 
    ================
    Examples
    ================
    % Get the singleton logger
    log = Logger.getLogger();
 
    % Set options
    log.MsgPrefix = 'MYAPP';
    log.LogFile = 'myapp.log';
    log.LogFormat = 'json'; % or 'plain'
    log.MaxLogFileSize = 1e6; % 1 MB for testing
    log.MaxLogFiles = 3;
 
    % Log various messages
    log.write('info', 'Starting process at %s', datestr(now));
    log.write('debug', 'Debug value: %.3f', pi);
    log.write('warning', 'This is a warning');
    log.write('error', 'This is an error: %s', 'something failed');
    log.write('verbose', 'Extra details: %d', 42);
 
    % Get logged messages (in memory)
    msgs = log.getMessages('info');
    disp(msgs);
 
    % Clear in-memory and file logs
    log.clearMessages();
    log.clearLogFile();
 
    ================
    Supported Levels
    ================
    'verbose', 'debug', 'info', 'warning', 'error'
 
    ================
    Properties
    ================
    LogFile         - Log file path (empty = no file logging)
    LogFormat       - 'plain' or 'json'
    MsgPrefix       - Custom prefix for all messages
    FileLogLevel    - Minimum level for file logging
    DisplayLogLevel - Minimum level for command window
    MaxLogFileSize  - Max log file size in bytes before rotation
    MaxLogFiles     - Number of rotated log files to keep
 
    See also: Logger.getLogger, Logger.write, Logger.getMessages
```

#### aws

```text
AWS, a wrapper to the AWS CLI utility
 
  The function assumes AWS CLI is installed and configured with authentication
  details. This wrapper allows use of the AWS CLI within the
  MATLAB environment.
 
  Examples:
     aws('s3api list-buckets')
 
  Alternatively:
     aws s3api list-buckets
 
  If no output is specified, the command will echo this to the MATLAB
  command window. If the output variable is provided it will convert the
  output to a MATLAB object.
 
    [status, output] = aws('s3api','list-buckets');
 
      output =
 
        struct with fields:
 
            Owner: [1x1 struct]
          Buckets: [15x1 struct]
 
  By default a struct is produced from the JSON format output.
  If the --output [text|table] flag is set a char vector is produced.
```

#### awsCommonRoot

```text
AWSCOMMONROOT Helper function to locate the AWS Common location
  Locate the installation of the AWS interface package to allow easier construction
  of absolute paths to the required dependencies.
```

#### awsRoot

```text
AWSROOT Function to locate the installation folder for the tooling
  awsRoot alone will return the root for the MATLAB code in the project.
 
  awsRoot with additional arguments will add these to the path
 
   funDir = awsRoot('app', 'functions')
 
   The special argument of a negative number will move up folders, e.g.
   the following call will move up two folders, and then into
   Documentation.
 
   docDir = awsRoot(-2, 'Documentation')
```

#### homedir

```text
HOMEDIR Function to return the home directory
  This function will return the users home directory.
```

#### isEC2

```text
ISEC2 returns true if running on AWS EC2 otherwise returns false
```

#### loadConfigurationSettings

```text
LOADCONFIGURATIONSETTINGS Method to read a JSON configuration settings from a file
  The file name must be as a specified argument.
  JSON values must be compatible with MATLAB JSON conversion rules.
  See jsondecode() help for details. A MATLAB struct is returned.
  Field names are case sensitive.
```

#### loadKeyPair

```text
LOADKEYPAIR2CERT Reads public and private key files and returns a key pair
  The key pair returned is of type java.security.KeyPair
  Algorithms supported by the underlying java.security.KeyFactory library
  are: DiffieHellman, DSA & RSA.
  However S3 only supports RSA at this point.
  If only the public key is a available e.g. the private key belongs to
  somebody else then we can still create a keypair to encrypt data only
  they can decrypt. To do this we replace the private key file argument
  with 'null'.
 
  Example:
   myKeyPair = loadKeyPair('c:\Temp\mypublickey.key', 'c:\Temp\myprivatekey.key')
 
   encryptOnlyPair = loadKeyPair('c:\Temp\mypublickey.key')
```

#### saveKeyPair

```text
SAVEKEYPAIR Writes a key pair to two files for the public and private keys
  The key pair should be of type java.security.KeyPair
 
  Example:
    saveKeyPair(myKeyPair, 'c:\Temp\mypublickey.key', 'c:\Temp\myprivatekey.key')
```

#### unlimitedCryptography

```text
UNLIMITEDCRYPTOGRAPHY Returns true if unlimited cryptography is installed
  Otherwise false is returned.
  Tests using the AES algorithm for greater than 128 bits if true then this
  indicates that the policy files have been changed to enabled unlimited
  strength cryptography.
```

#### writeSTSCredentialsFile

Request a temporary session token via the AWS CLI and write the credentials to `credentials_sts.json`.

| Positional Argument | Type | Description |
| --- | --- | --- |
| `tokenCode` | char vector | 6-digit MFA token from your authenticator. |
| `serialNumber` | char vector | ARN of the MFA device (for example, `arn:aws:iam::123456789012:mfa/user`). |
| `region` | char vector | Region to store alongside the credentials (e.g., `us-west-1`). |

| Returns | Type | Description |
| --- | --- | --- |
| `tf` | logical | `true` when the STS credentials file was written successfully. |

The helper shells out to `aws sts get-session-token` and rewrites the JSON output into the format expected by MATLAB tooling.

