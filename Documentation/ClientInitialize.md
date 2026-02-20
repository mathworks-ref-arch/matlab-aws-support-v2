## 🧑‍💻 5. MATLAB AWS Client

### 🔧 5.1 How Service Clients Use Credentials & Region

Service clients derive from `aws.core.BaseClient` and support optional constructor name–value pairs.

#### 5.1.1 Supported Constructor Parameters

*   `'credentialsprovider'`: a MATLAB Credential Provider from `aws.auth.CredentialProvider`.  
```{caution}
Do not pass raw Java SDK objects.
```    
```matlab
cp = aws.auth.CredentialProvider.getProfileCredentialProvider("analytics");
s3 = aws.s3.Client('credentialsprovider', cp, 'region', "us-west-2");

% Or:

[cp, region] = aws.auth.CredentialProvider.getDefaultCredentialProvider();
s3 = aws.s3.Client('credentialsprovider', cp, 'region', region);
```

*   **`'region'`**: Region string (e.g., `"us-east-1"`) or a `software.amazon.awssdk.regions.Region` object.

*   **`'isCrt'`**: Logical flag to enable the **AWS CRT HTTP client** (`true|false`).
```{note}
Passing a string is preferred in MATLAB; the base client will convert via `Region.of()`.
```

#### 5.1.2 Fallback Behavior

If you **do not** supply parameters:

*   `credentialsprovider` → resolved via `aws.auth.CredentialProvider.getDefaultCredentialProvider()`
*   `region` → resolved via `aws.auth.CredentialProvider.getDefaultCredentialProvider()` (region part)

This means you can get started with *no parameters* when your environment is configured properly.

#### 5.1.3 HTTP Client (CRT & Proxy)

`BaseClient` applies an HTTP client to the service builder:

*   If `'isCrt' == true` → uses `software.amazon.awssdk.http.crt.AwsCrtHttpClient`.
*   Otherwise → optionally configures an Apache HTTP client for **proxy support** via `configProxyHttpClient(obj)` (if required and available).  
    This allows service-wide proxy configuration when CRT is not in use.

#### 5.1.4 Lifecycle & Logging

*   On successful build, the client logs **"Client initialized"** and stores the handle.
*   The client implements cleanup via `onCleanup` and calls `.close()` on the Java client in `delete`.
*   Logging prefix is service-specific (e.g., `AMAZON:S3`).

***

### 🚀 5.2 S3 Client: Examples

#### 5.2.1 Rely on Defaults

```matlab
s3 = aws.s3.Client();
[getResp, stream] = s3.getObject(bucket="my-bucket", key="hello.txt");
```

#### 5.2.2 Provide Only Region

```matlab
s3 = aws.s3.Client('region', "us-east-1");
```

#### 5.2.3 Use Named Profile

```matlab
cp = aws.auth.CredentialProvider.getProfileCredentialProvider("analytics");
s3 = aws.s3.Client('credentialsprovider', cp, 'region', "us-west-2");
```

#### 5.2.4 Use Session Credentials from JSON

```matlab
creds = loadConfigurationSettings('credentials.json');
cp = aws.auth.CredentialProvider.getSessionCredentialProvider( ...
    creds.aws_access_key_id, creds.aws_secret_access_key, creds.aws_session_token);
s3 = aws.s3.Client('credentialsprovider', cp, 'region', "eu-central-1");
```

#### 5.2.5 Web Identity / IRSA

```matlab
% Requires env vars: AWS_ROLE_ARN, AWS_WEB_IDENTITY_TOKEN_FILE

cp = aws.auth.CredentialProvider.getWebIdentityCredentialProvider();
s3 = aws.s3.Client('credentialsprovider', cp, 'region', "us-west-2");
```

#### 5.2.6 EC2/ECS Role

```matlab
cp = aws.auth.CredentialProvider.getInstanceProfileCredentialProvider();
s3 = aws.s3.Client('credentialsprovider', cp, 'region', "us-east-1");
```

***

#### 5.2.7 JSON Credentials File Schema

Use this when calling `getJsonFileCredentialProvider(jsonFile)` or when manually loading credentials.

```json
{
  "aws_access_key_id": "AKIA...",
  "aws_secret_access_key": "SECRET...",
  "aws_session_token": "SESSION_TOKEN",
  "region": "us-west-2"
}
```

```{note}
*   If `aws_session_token` is present and non-empty → builds a **session** provider.
*   Otherwise → builds a **static** provider.
*   Returns `region` if present; empty string otherwise.
```

***

### 🧩 5.3 Troubleshooting

For common setup and runtime issues, see the dedicated guide:

- Troubleshooting.md

***

### ⚠️ 5.4 Security Best Practices

*   ✅ Prefer **role-based** access (IMDS on EC2/ECS, IRSA on EKS) over long-lived keys.
*	✅ For local development, use **named profiles** or `credential_process`.
*   ❌ Avoid embedding secrets in code or config checked into source control.
*   🔄 Rotate temporary credentials regularly.
*   🧼 Never commit credential files to source control.
*   🔍 Apply least-privilege IAM policies.


```{seealso}
*   [AWS SDK for Java v2 — **Credentials**:](https://docs.aws.amazon.com/sdk-for-java/v2/developer-guide/credentials.html)
*   [AWS SDK for Java v2 — **Regions**:](https://docs.aws.amazon.com/sdk-for-java/v2/developer-guide/java-dg-region-selection.html)
*   [IAM Roles for Service Accounts (IRSA):](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html)
*   [EC2 Instance Metadata Service (IMDS):](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html)
```
