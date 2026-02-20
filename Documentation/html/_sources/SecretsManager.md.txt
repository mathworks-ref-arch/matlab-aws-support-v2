## ☁️ 6.13 Secrets Manager

MATLAB client for AWS Secrets Manager. Create, update, restore, and retrieve secure text or binary secrets used by your applications.

```matlab
sm = aws.secretsmanager.Client();
```

### 🔧 6.13.1 List of Available Methods

- [createSecret](AWSSDKAPI.md#aws-secretsmanager-client-createsecret)  
- [deleteSecret](AWSSDKAPI.md#aws-secretsmanager-client-deletesecret)  
- [getSecretValue](AWSSDKAPI.md#aws-secretsmanager-client-getsecretvalue)  
- [listSecrets](AWSSDKAPI.md#aws-secretsmanager-client-listsecrets)  
- [restoreSecret](AWSSDKAPI.md#aws-secretsmanager-client-restoresecret)  
- [updateSecret](AWSSDKAPI.md##aws-secretsmanager-client-updatesecret)

### 🧩 6.13.2 Examples

Create a secret and immediately retrieve it
```matlab
sm = aws.secretsmanager.Client();
payload = jsonencode(struct(user="analytics", password="SuperSecret123!"));

resp = sm.createSecret(name="prod/app/credentials", secretString=payload, ...
    description="Stored by MATLAB sample");

value = sm.getSecretValue(secretId=resp.arn);
disp(value.secretString);
```

List secrets, then update and restore as needed
```matlab
resp = sm.listSecrets(maxResults=int32(10));
for entry = resp.secrets
    fprintf("%s -> %s\n", entry.name, entry.arn);
end

sm.updateSecret(secretId=resp.secrets(1).arn, secretString="rotated-value");
sm.deleteSecret(secretId=resp.secrets(1).arn, recoveryWindowInDays=int64(7));
sm.restoreSecret(secretId=resp.secrets(1).arn);
```

### 6.13.3 Method Reference (Summary)

#### 🔸 `createSecret`
```matlab
resp = sm.createSecret(name="prod/app/api", secretString="token", tag=dictionary("team","labs"));
```
*   Returns: `aws.secretsmanager.model.CreateSecretResponse`

#### 🔸 `deleteSecret`
```matlab
resp = sm.deleteSecret(secretId="<arn-or-name>", recoveryWindowInDays=int64(7));
```
*   Returns: `aws.secretsmanager.model.DeleteSecretResponse`

#### 🔸 `getSecretValue`
```matlab
value = sm.getSecretValue(secretId="<arn-or-name>");
```
*   Returns: `aws.secretsmanager.model.GetSecretValueResponse`

#### 🔸 `listSecrets`
```matlab
resp = sm.listSecrets(maxResults=int32(20), sortOrder="asc");
```
*   Returns: `aws.secretsmanager.model.ListSecretsResponse`

#### 🔸 `restoreSecret`
```matlab
resp = sm.restoreSecret(secretId="<arn-or-name>");
```
*   Returns: `aws.secretsmanager.model.RestoreSecretResponse`

#### 🔸 `updateSecret`
```matlab
resp = sm.updateSecret(secretId="<arn-or-name>", secretString="new-value");
```
*   Returns: `aws.secretsmanager.model.UpdateSecretResponse`

### 💡 Notes & Best Practices

- Encode rich secrets as JSON via `jsonencode` so multiple key/value pairs live inside a single `secretString`.
- Use ARN-based `secretId` inputs for rotation or deletion workflows to avoid ambiguity across environments.
- Convert binary payloads with `aws.core.model.SdkBytes` helpers when sending `secretBinary` to `createSecret`/`updateSecret`.
- Honor pagination by checking the returned `nextToken` from `listSecrets` before assuming you enumerated everything.
- Never log secret values; capture only metadata such as the ARN, name, or version ID for audit trails.


```{seealso}
🔗 Data Models:
- [CreateSecretResponse](AWSSDKAPI.md#aws-secretsmanager-model-createsecretresponse)
- [DeleteSecretResponse](AWSSDKAPI.md#aws-secretsmanager-model-invokemodelresponse)
- [GetSecretValueResponse](AWSSDKAPI.md#aws-secretsmanager-model-message)
- [ListSecretsResponse](AWSSDKAPI.md#aws-secretsmanager-model-converseresponse)
- [RestoreSecretResponse](AWSSDKAPI.md#aws-secretsmanager-model-invokemodelresponse)
- [SecretListEntry](AWSSDKAPI.md#aws-secretsmanager-model-message)
- [UpdateSecretResponse](AWSSDKAPI.md#aws-secretsmanager-model-message)
```