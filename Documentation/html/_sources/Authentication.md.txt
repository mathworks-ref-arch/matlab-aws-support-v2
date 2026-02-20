## 4. AWS Authentication

The MATLAB AWS Support Package relies on the AWS SDK for Java v2 for all
credential management. Use `aws.auth.CredentialProvider` to build or
retrieve credential providers and pass them to any MATLAB client through
the `'credentialsprovider'` Name-Value argument.

### 4.1 Default Credential and Region Resolution

`aws.auth.CredentialProvider.getDefaultCredentialProvider` mirrors the AWS
SDK default chain. Credentials are resolved in the following order:

1. Environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`,
   `AWS_SESSION_TOKEN`).
2. Java system properties (`aws.accessKeyId`, `aws.secretAccessKey`,
   `aws.sessionToken`).
3. Shared configuration files (`~/.aws/credentials`, `~/.aws/config`).
4. `credential_process` entries defined in the shared config.
5. Web identity hints (`AWS_ROLE_ARN`, `AWS_WEB_IDENTITY_TOKEN_FILE`,
   `AWS_ROLE_SESSION_NAME`).
6. Instance metadata services (IMDS/ECS task roles).

Region selection follows the default region provider chain: environment
variables (`AWS_REGION`, `AWS_DEFAULT_REGION`), Java `aws.region`, shared
config profile, then metadata services.

```matlab
[cp, region] = aws.auth.CredentialProvider.getDefaultCredentialProvider();
s3 = aws.s3.Client('region', region, 'credentialsprovider', cp);
```

### 4.2 Credential Provider Factories

| Method | Purpose | Returns |
| --- | --- | --- |
| `getDefaultCredentialProvider` | Discover credentials/region via the default chain. | Java DefaultCredentialsProvider and region string. |
| `getProfileCredentialProvider` | Load credentials from a named profile (supports SSO profiles). | ProfileCredentialsProvider. |
| `getInstanceProfileCredentialProvider` | Use the EC2/ECS instance or task role via metadata. | InstanceProfileCredentialsProvider. |
| `getBasicCredentialProvider` | Wrap long-lived IAM user keys. | StaticCredentialsProvider. |
| `getSessionCredentialProvider` | Wrap temporary credentials you already possess. | StaticCredentialsProvider with session token. |
| `getWebIdentityCredentialProvider` | Assume a role using web identity environment variables. | WebIdentityTokenFileCredentialsProvider. |
| `getJsonFileCredentialProvider` | Read credentials (and optional region) from a simple JSON file. | Static or session provider plus region string. |

#### 4.2.1 getDefaultCredentialProvider

Returns the Java `DefaultCredentialsProvider` and the resolved AWS region.
Use this when you want the SDK to locate credentials automatically.

#### 4.2.2 getProfileCredentialProvider

Accepts an optional profile name (defaults to `"default"`). Profiles are
loaded from the standard shared config files and support IAM Identity
Center (SSO) if you run `aws sso login --profile <name>` beforehand.

```matlab
cp = aws.auth.CredentialProvider.getProfileCredentialProvider("analytics");
sqs = aws.sqs.Client('credentialsprovider', cp);
```

#### 4.2.3 getInstanceProfileCredentialProvider

Creates a provider that talks to the instance metadata service (IMDS) or
container metadata endpoint to retrieve the role credentials attached to
an EC2 instance, ECS task, or similar managed host.

#### 4.2.4 getBasicCredentialProvider

Wrap a long-lived IAM Access Key ID and Secret Access Key pair. Prefer to
use roles or temporary credentials when possible.

#### 4.2.5 getSessionCredentialProvider

Use when you already have temporary credentials from STS, federation, or
an external SSO integration and simply want to pass them to MATLAB code.

#### 4.2.6 getWebIdentityCredentialProvider

Reads `AWS_ROLE_ARN`, `AWS_WEB_IDENTITY_TOKEN_FILE`, and optionally
`AWS_ROLE_SESSION_NAME` to exchange a web identity token for temporary
credentials. Use for EKS IRSA scenarios.

#### 4.2.7 getJsonFileCredentialProvider

Load credentials from an ad-hoc JSON file:

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

### 4.3 Passing Providers to AWS Clients

Every MATLAB AWS client accepts a `'credentialsprovider'` Name-Value pair.
This keeps constructors uniform and avoids duplicating authentication
logic.

```matlab
cp = aws.auth.CredentialProvider.getDefaultCredentialProvider();
ddb = aws.dynamodb.Client('credentialsprovider', cp, 'region', "us-east-1");
resp = ddb.listTables();
```

If you omit `'credentialsprovider'`, each client falls back to
`getDefaultCredentialProvider`, so explicit setup is only required when
you need a specific source.
