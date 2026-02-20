## ☁️ 6.9 SNS

MATLAB client for Amazon Simple Notification Service (SNS). Create topics, publish messages, and manage subscriptions.

```matlab
sns = aws.sns.Client();
```

### 🔧 6.9.1 List of Available Methods

- [createTopic](AWSSDKAPI.md#awssnsclientcreatetopic)  
- [deleteTopic](AWSSDKAPI.md#awssnsclientdeletetopic)  
- [listTopics](AWSSDKAPI.md#awssnsclientlisttopics)  
- [publish](AWSSDKAPI.md#awssnsclientpublish)  
- [subscribe](AWSSDKAPI.md#awssnsclientsubscribe)  
- [confirmSubscription](AWSSDKAPI.md#awssnsclientconfirmsubscription)  
- [unsubscribe](AWSSDKAPI.md#awssnsclientunsubscribe)
- [getTopicAttributes](AWSSDKAPI.md#awssnsclientgettopicattributes)  
- [getSubscriptionAttributes](AWSSDKAPI.md#awssnsclientgetsubscriptionattributes)

### 🧩 6.9.2 Examples

Create a topic and publish a message
```matlab
sns = aws.sns.Client();
ct = sns.createTopic(name="matlab-demo-topic");
topicArn = ct.topicArn;

p = sns.publish(topicArn=topicArn, message="Hello from MATLAB");
disp(p.messageId);
```

### 📘 6.9.3 Method Reference (Summary)

#### 🔸 `createTopic`
```matlab
ct = sns.createTopic(name="<name>");
```
*   Returns: `aws.sns.model.CreateTopicResponse`

#### 🔸 `deleteTopic`
```matlab
sns.deleteTopic(topicArn="<arn>");
```
*   Returns: `aws.sns.model.DeleteTopicResponse`

#### 🔸 `listTopics`
```matlab
lt = sns.listTopics();
```
*   Returns: `aws.sns.model.ListTopicsResponse`

#### 🔸 `publish`
```matlab
resp = sns.publish(topicArn="<arn>", message="<text>", subject="<subject>");
```
*   Returns: `aws.sns.model.PublishResponse`

#### 🔸 `subscribe`
```matlab
sr = sns.subscribe(topicArn="<arn>", protocol="email", endpoint="user@example.com");
```
*   Returns: `aws.sns.model.SubscribeResponse`

#### 🔸 `confirmSubscription`
```matlab
sns.confirmSubscription(topicArn="<arn>", token="<token>");
```
*   Returns: `aws.sns.model.ConfirmSubscriptionResponse`

#### 🔸 `unsubscribe`
```matlab
sns.unsubscribe(subscriptionArn="<subscription-arn>");
```
*   Returns: `aws.sns.model.UnsubscribeResponse`

#### 🔸 `getTopicAttributes`
```matlab
ga = sns.getTopicAttributes(topicArn="<arn>");
```
*   Returns: `aws.sns.model.GetTopicAttributesResponse`

#### 🔸 `getSubscriptionAttributes`
```matlab
gs = sns.getSubscriptionAttributes(subscriptionArn="<subscription-arn>");
```
*   Returns: `aws.sns.model.GetSubscriptionAttributesResponse`

```{seealso}
🔗 Data Models: CreateTopicResponse, PublishResponse, SubscribeResponse, ConfirmSubscriptionResponse, UnsubscribeResponse, ListTopicsResponse
```
