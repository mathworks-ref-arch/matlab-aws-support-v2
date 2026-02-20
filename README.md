[![Latest release](Documentation/Images/release.svg)](https://github.com/mathworks-ref-arch/matlab-aws-support-v2/releases/latest)
[![License](Documentation/Images/license-badge.svg)](https://github.com/mathworks-ref-arch/matlab-aws-support-v2/blob/main/LICENSE.MD)
[![Docs](Documentation/Images/docs-badge.svg)](https://mathworks-ref-arch.github.io/matlab-aws-support-v2)

# MATLAB Interface *for Amazon Web Services*

## Introduction

`matlab-aws-support-v2` packages MATLAB® class wrappers around the AWS SDK for Java v2 so you can script AWS workflows directly from MATLAB. Clients are available for the most commonly used services, including:

- Amazon Simple Storage Service (S3)
- Amazon Simple Queue Service (SQS)
- Amazon Simple Notification Service (SNS)
- AWS Secrets Manager
- Amazon DynamoDB, ECS, Lambda, Redshift Data, STS, and more
- Amazon Bedrock Runtime for generative AI workloads

The [documentation portal](https://mathworks-ref-arch.github.io/matlab-aws-support-v2) lists every supported service and data model.

> **Tip:** MATLAB already includes built-in remote data helpers (for example, [`dir`](https://www.mathworks.com/help/matlab/ref/dir.html) and the [remote data workflow guide](https://www.mathworks.com/help/matlab/import_export/work-with-remote-data.html)). Use those higher-level features whenever they cover your scenario before dropping to the low-level SDK wrappers in this project.

## Requirements

| Dependency | Version / Notes |
| --- | --- |
| MATLAB | R2023b or later |
| Java | JDK 8 through 17. Starting with **R2025b**, Bring Your Own Java (BYOJ) is required. |
| Maven | 3.8.8 or later |
| OS (tested) | Windows® 11, Ubuntu® 22.04 |

## Installation Overview

1. Clone or download the repository.
2. Build the Java components:
   ```bash
   cd Software/Java
   mvn clean package
   ```
3. In MATLAB, run `startup.m` from `Software/MATLAB` to add the interface to your path.
4. Follow the detailed [Installation guide](https://mathworks-ref-arch.github.io/matlab-aws-support-v2/Overview.html#installation) for advanced scenarios (proxy settings, custom SDK bundles, etc.).

## Documentation

Full usage instructions, service-specific walkthroughs, and the MATLAB AWS API reference are published at the [MATLAB AWS documentation site](https://mathworks-ref-arch.github.io/matlab-aws-support-v2).

## Authentication

You must supply AWS credentials before calling any service. The package supports:

1. **Default Credential Provider Chain** – honors AWS environment variables, shared config files, Java system properties, ECS/EC2 metadata (IMDS), and web identity/OIDC sources.
2. **Explicit Credential Providers** – create providers via `aws.auth.CredentialProvider` for named profiles, static or session credentials, web-identity tokens, or custom JSON secrets.

See [Documentation/Authentication.md](Documentation/Authentication.md) for step-by-step guidance.

## Getting Started

```matlab
% Configure MATLAB with AWS clients and dependencies
run(fullfile("Software","MATLAB","startup.m"));

% Example: List buckets and read a secret
s3 = aws.s3.Client();
resp = s3.listBuckets();
disp({resp.buckets.name}');

sm = aws.secretsmanager.Client();
secret = sm.getSecretValue(secretId="prod/app/api");
disp(secret.secretString);
```

## License

The license for this project is provided in [LICENSE.md](/LICENSE.MD). Third-party software downloaded at build time is listed in `Software/Java/pom.xml` and is governed by its corresponding licenses.

## Enhancement Requests

Suggest new capabilities or managed services using the Reference Architecture request form: https://www.mathworks.com/products/reference-architectures/request-new-reference-architectures.html

## Support

- Email: `mwlab@mathworks.com`
- Or open an issue in this repository with reproducible steps and logs.
