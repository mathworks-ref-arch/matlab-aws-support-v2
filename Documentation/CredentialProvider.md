## 🧩 7. Credential Provider

Examples showing how to build and pass credential providers to MATLAB AWS clients via `aws.auth.CredentialProvider`. Pair this with the overview in Authentication (4.1, 4.2).

#### 🔸 7.1 Using Profile Credential Provider

The `getProfileCredentialProvider` method allows you to authenticate using a named profile from your AWS credentials file. This is useful if you have multiple profiles configured in `~/.aws/credentials`.

```matlab
% Example: Using Profile Credential Provider
credProv = aws.auth.CredentialProvider.getProfileCredentialProvider('myProfile');

% Use the credential provider with any AWS client
awsClient = aws.someService.Client('credentialsprovider', credProv);
% e.g., for Bedrock Runtime service:
% bedrockRuntime = aws.bedrock.runtime.Client('credentialsprovider', credProv);
```

- **Profile Name**: Specify the profile name you want to use. If omitted, the default profile is used.

#### 🔸 7.2 Using Instance Profile Credential Provider

The `getInstanceProfileCredentialProvider` method is designed for use on AWS EC2 instances where an IAM role is assigned.

```matlab
% Example: Using Instance Profile Credential Provider
credProv = aws.auth.CredentialProvider.getInstanceProfileCredentialProvider();

% Use the credential provider with any AWS client
awsClient = aws.someService.Client('credentialsprovider', credProv);
% e.g., for Bedrock Runtime service:
% bedrockRuntime = aws.bedrock.runtime.Client('credentialsprovider', credProv);
```

- **EC2 Instances**: This method is ideal for EC2 instances with attached IAM roles, eliminating the need for explicit credentials.

#### 🔸 7.3 Using Basic Credential Provider

The `getBasicCredentialProvider` method authenticates using an AWS Access Key ID and Secret Access Key.

```matlab
% Example: Using Basic Credential Provider
credProv = aws.auth.CredentialProvider.getBasicCredentialProvider('yourAccessKeyId', 'yourSecretAccessKey');

% Initialize Athena client with the credential provider
% Use the credential provider with any AWS client
awsClient = aws.someService.Client('credentialsprovider', credProv);
% e.g., for Bedrock Runtime service:
% bedrockRuntime = aws.bedrock.runtime.Client('credentialsprovider', credProv);
```

- **Access Key and Secret Key**: Provide your AWS credentials directly for authentication.

#### 🔸 7.4 Using Session Credential Provider

The `getSessionCredentialProvider` method is used when a session token is required, in addition to the Access Key ID and Secret Access Key.

```matlab
% Example: Using Session Credential Provider
credProv = aws.auth.CredentialProvider.getSessionCredentialProvider('yourAccessKeyId', 'yourSecretAccessKey', 'yourSessionToken');

% Use the credential provider with any AWS client
awsClient = aws.someService.Client('credentialsprovider', credProv);
% e.g., for Bedrock Runtime service:
% bedrockRuntime = aws.bedrock.runtime.Client('credentialsprovider', credProv);
```

- **Session Token**: Include a session token for temporary credentials provided by AWS STS.

#### 🔸 7.5 Using JSON File Credential Provider

The `getJsonFileCredentialProvider` method reads credentials from a JSON file, which must include the necessary AWS credentials.

```matlab
% Example: Using JSON File Credential Provider
[credProv, awsRegion] = aws.auth.CredentialProvider.getJsonFileCredentialProvider('path/to/credentials.json');

% Use the credential provider with any AWS client
awsClient = aws.someService.Client('credentialsprovider', credProv, 'region', awsRegion);
% e.g., for Bedrock Runtime service:
% bedrockRuntime = aws.bedrock.runtime.Client('credentialsprovider', credProv, 'region', awsRegion);
```

- **JSON File**: Ensure your JSON file contains `aws_access_key_id`, `aws_secret_access_key`, and optionally `aws_session_token` and `region`.

#### 🔸 7.6 Using Default Credential Provider

The `getDefaultCredentialProvider` method utilizes the AWS SDK's Default Credential Provider Chain to authenticate. This approach is convenient as it automatically searches for credentials in a predefined order, allowing for flexible and environment-specific configurations.

```matlab
% Example: Using Default Credential Provider
[credProv, awsRegion] = aws.auth.CredentialProvider.getDefaultCredentialProvider();

% Use the credential provider with any AWS client
awsClient = aws.someService.Client('credentialsprovider', credProv, 'region', awsRegion);
% e.g., for Bedrock Runtime service:
% bedrockRuntime = aws.bedrock.runtime.Client('credentialsprovider', credProv, 'region', awsRegion);
```

The default credential provider chain searches for AWS credentials in the following order:

1. **Environment Variables**: The chain first checks for credentials in environment variables: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and optionally `AWS_DEFAULT_REGION`.

2. **Java System Properties**: If environment variables are not set, the chain checks Java system properties: `aws.accessKeyId` and `aws.secretKey`.

3. **Credentials Profiles File**: If system properties are not set, the chain looks for credentials in the default profile file, typically located at `~/.aws/credentials` on Linux or `C:\Users\username\.aws\credentials` on Windows. This file can be created and managed using the AWS CLI with the `aws configure` command.

4. **Amazon ECS Container Credentials**: If the credentials file is not present, the chain checks for ECS container credentials, which are available if the environment variable `AWS_CONTAINER_CREDENTIALS_RELATIVE_URI` is set.

5. **Instance Profile Credentials (EC2 Metadata Service)**: Finally, if none of the above methods provide credentials, the chain attempts to retrieve instance profile credentials from the EC2 metadata service, which is available for EC2 instances with an assigned IAM role.

This hierarchy allows for a seamless and flexible authentication process, adapting to various deployment environments without the need for explicit credential management.
