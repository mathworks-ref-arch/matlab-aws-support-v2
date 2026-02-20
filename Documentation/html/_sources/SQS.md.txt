## ☁️ 6.10 SQS

MATLAB client for Amazon Simple Queue Service (SQS). Create queues, send/receive messages, and manage attributes.

```matlab
sqs = aws.sqs.Client();
```

### 🔧 6.10.1 List of Available Methods

- [createQueue](AWSSDKAPI.md#awssqsclientcreatequeue)  
- [deleteQueue](AWSSDKAPI.md#awssqsclientdeletequeue)  
- [sendMessage](AWSSDKAPI.md#awssqsclientsendmessage)  
- [receiveMessage](AWSSDKAPI.md#awssqsclientreceivemessage)  
- [deleteMessage](AWSSDKAPI.md#awssqsclientdeletemessage)  
- [getQueueAttributes](AWSSDKAPI.md#awssqsclientgetqueueattributes)  
- [setQueueAttributes](AWSSDKAPI.md#awssqsclientsetqueueattributes)  
- [listQueues](AWSSDKAPI.md#awssqsclientlistqueues)  

### 🧩 6.10.2 Examples

Create a queue and send/receive a message
```matlab
sqs = aws.sqs.Client();
q = sqs.createQueue(queueName="matlab-demo-queue");
queueUrl = q.queueUrl;

sqs.sendMessage(queueUrl=queueUrl, messageBody="Hello from MATLAB");
r = sqs.receiveMessage(queueUrl=queueUrl, maxNumberOfMessages=int32(1));
disp(r.messages);
```

### 📘 6.10.3 Method Reference (Summary)

#### 🔸 `createQueue`
```matlab
cq = sqs.createQueue(queueName="<name>", attributesWithStrings=dictionary());
```
*   Returns: `aws.sqs.model.CreateQueueResponse`

#### 🔸 `deleteQueue`
```matlab
sqs.deleteQueue(queueUrl="<url>");
```
*   Returns: `aws.sqs.model.DeleteQueueResponse`

#### 🔸 `sendMessage`
```matlab
sqs.sendMessage(queueUrl="<url>", messageBody="<text>");
```
*   Returns: `aws.sqs.model.SendMessageResponse`

#### 🔸 `receiveMessage`
```matlab
rm = sqs.receiveMessage(queueUrl="<url>", maxNumberOfMessages=int32(1));
```
*   Returns: `aws.sqs.model.ReceiveMessageResponse`

#### 🔸 `deleteMessage`
```matlab
sqs.deleteMessage(queueUrl="<url>", receiptHandle="<handle>");
```
*   Returns: `aws.sqs.model.DeleteMessageResponse`

#### 🔸 `getQueueAttributes`
```matlab
ga = sqs.getQueueAttributes(queueUrl="<url>");
```
*   Returns: `aws.sqs.model.GetQueueAttributesResponse`

#### 🔸 `setQueueAttributes`
```matlab
sqs.setQueueAttributes(queueUrl="<url>", attributesWithStrings=dictionary());
```
*   Returns: `aws.sqs.model.SetQueueAttributesResponse`

#### 🔸 `listQueues`
```matlab
ql = sqs.listQueues();
```
*   Returns: `aws.sqs.model.ListQueuesResponse`

```{seealso}
🔗 Data Models: CreateQueueResponse, SendMessageResponse, ReceiveMessageResponse, DeleteMessageResponse, GetQueueAttributesResponse, SetQueueAttributesResponse
```
