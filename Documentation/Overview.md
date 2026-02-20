## 📖 1. Overview

### 🧭 1.1 Introduction

This package provides MATLAB interfaces to the AWS SDK for Java v2, enabling access to multiple Amazon Web Services from MATLAB. Supported services include (non‑exhaustive): S3, SQS, SNS, DynamoDB, Lambda, SSM, STS, ECS, Redshift Data, Athena, Polly, and Bedrock Runtime.

```{note}
MATLAB has built‑in support for working with remote data on Amazon S3. Where built‑in functions cover your use case (e.g., dir, readtable, datastore), prefer those for simplicity:
- https://www.mathworks.com/help/matlab/ref/dir.html
- https://www.mathworks.com/help/matlab/import_export/work-with-remote-data.html
```

### 📋 1.2 Requirements


| Dependency | Version / Notes |
| --- | --- |
| MATLAB | R2023b or later |
| Java | JDK 8 through 17. |
| Maven | 3.8.8 or later |
| OS (tested) | Windows® 11, Ubuntu® 22.04 |


```{important}
Starting with MATLAB R2025b, users must Bring Your Own Java (BYOJ). Ensure a supported Java runtime is installed and configured. See [Configure Your System to Use Java](https://www.mathworks.com/help/matlab/matlab_external/configure-your-system-to-use-java.html)
```

### 💾 1.3 Installation

1. Clone or download the repository.
2. Build the Java components:
   ```bash
   cd Software/Java
   mvn clean package
   ```
3. In MATLAB, run `startup.m` from `Software/MATLAB` to add the interface to your path.
4. Follow the detailed [Installation guide](Installation.md) for advanced scenarios (proxy settings, custom SDK bundles, etc.).

```{caution}
- Build the Java components with Maven before running startup.m.
- Run mvn clean package to avoid stale class files.
```

### 📚 1.4 Documentation

This documentation set lives in the Documentation/ folder. Key pages:
- [Installation](Installation.md)
- [Authentication](Authentication.md)
- [Configuration](Configuration.md)
- Service guides (e.g., [Athena](Athena.md), [BedrockRuntime](BedrockRuntime.md))
- [API Reference](APIReference.md)

```{tip}
Add the interface to your MATLAB path persistently in startup.m if desired.
```

### 🔐 1.5 Authentication

You must supply AWS credentials before calling any service. The package supports:

1. **Default Credential Provider Chain** – honors AWS environment variables, shared config files, Java system properties, ECS/EC2 metadata (IMDS), and web identity/OIDC sources.
2. **Explicit Credential Providers** – create providers via `aws.auth.CredentialProvider` for named profiles, static or session credentials, web-identity tokens, or custom JSON secrets.

See [Authentication](Authentication.md) for step-by-step guidance.


```{important}
Use least‑privilege IAM credentials; avoid using AWS account root credentials.
```

### 🚀 1.6 Getting Started

Configure MATLAB with AWS clients and dependencies and call any of the of Amazon Web Service using the MATLAB interface.
```matlab
run(fullfile("Software","MATLAB","startup.m"));
```

### 🧪 1.7 Usage Examples

Default credentials and region:
```matlab
bedrockRuntime = aws.bedrock.runtime.Client();
resp = bedrockRuntime.invokeModel(modelId="amazon.titan-text-express-v1", body="Hello");
disp(resp.outputText);
```

Explicit provider, region, and CRT HTTP client:
```matlab
s3 = aws.s3.Client(credentialsprovider=credentialProvider, region=region, isCrt=true);
buckets = s3.listBuckets();
[resp, stream] = s3.getObject(bucket=bucketName, key="hello2.txt");
s3.saveS3ResponseInputStreamToFile(stream, "C:\\Temp\\file1.txt");
```

Read a Secret Value from Amazon Secret Manager
```matlab
sm = aws.secretsmanager.Client();
secret = sm.getSecretValue(secretId="prod/app/api");
disp(secret.secretString);
```

```{note}
By default, clients resolve credentials and region automatically via the Default Provider Chain. Override by passing a CredentialProvider and/or region string.
```

### ⚖️ 1.8 License

See [LICENSE.MD](../LICENSE.MD). Third‑party dependencies are declared in `Software/Java/pom.xml` and downloaded at build time.

### 🛠️ 1.9 Support

Please open an issue in this repository for questions or feature requests. For consulting on specific deployments, contact mwlab@mathworks.com.

Amazon S3, SQS, SNS and other names are trademarks of their respective owners.

```{seealso}
Request new reference architectures: https://www.mathworks.com/products/reference-architectures/request-new-reference-architectures.html
```

[//]: # (Copyright 2025 The MathWorks, Inc.)
