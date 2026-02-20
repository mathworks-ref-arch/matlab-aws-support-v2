## 🧩 11. Troubleshooting

Quick fixes and diagnostics for common setup and runtime issues when using the MATLAB AWS clients.

### 🔸 “AWS service … is not available in region …”
- Originates from region validation in `BaseClient`.
- Confirm the service supports your chosen region; try a supported region.
- For Bedrock Runtime, prefer `us-east-1` unless otherwise noted.

### 🔸 Missing region / “Region must be set”
- Either rely on `getDefaultCredentialProvider()` (which resolves a region), or
- Pass `'region', "us-east-1"` (or similar) to the client constructor.

### 🔸 Profile not found
- If using `getProfileCredentialProvider`, ensure the profile exists in `~/.aws/credentials` or `~/.aws/config`.
- If using `AWS_PROFILE`, confirm it matches an existing profile name.

### 🔸 JVM not available / MATLAB too old
- If `usejava('jvm')` is false or MATLAB < R2021b, initialization will fail.
- Start MATLAB with JVM enabled and upgrade to R2021b+ if possible.

### 🔸 AWS SDK v2 JARs not found
- If classes like `software.amazon.awssdk.services.s3.S3Client` are missing:
  - Ensure the AWS SDK v2 JARs are on the Java class path (`javaaddpath` or `classpath.txt`).
  - Restart MATLAB after changing the class path.

### 🔸 IMDS (instance profile) timeouts
- Outside AWS, IMDS is unreachable and timeouts are expected.
- Locally, prefer profiles or environment variables.
- On EC2/ECS, ensure network access to IMDS/ECS credential endpoints (IMDSv2 tokens, firewall).

### 🔸 Web identity token errors (IRSA/OIDC)
- Set these environment variables before MATLAB starts:
  - `AWS_ROLE_ARN`
  - `AWS_WEB_IDENTITY_TOKEN_FILE`
  - (Optional) `AWS_ROLE_SESSION_NAME`
- Note: `setenv` inside MATLAB does not affect the JVM environment.

### 🔸 JSON parsing issues or missing keys
- For `getJsonFileCredentialProvider` or custom loaders, validate your JSON file:
- Required keys: `aws_access_key_id`, `aws_secret_access_key`.
- Use MATLAB to verify structure and encoding:
```matlab
jsondecode(fileread('credentials.json'));
```

### 🔸 HTTP proxy issues
- If you need a proxy and CRT does not meet your needs:
  - Use the non-CRT path and implement `configProxyHttpClient` to return a configured Apache HTTP client builder.
  - Alternatively, set Java system properties if supported by your HTTP client stack.

### 🔸 CRT HTTP client quirks
- If using `'isCrt', true`:
  - Ensure CRT dependencies are on the class path.
  - If a proxy is required and not supported, switch `'isCrt'` to `false` and use the Apache client path.

```{seealso}
- Authentication overview: Authentication.md
- Client initialization: ClientInitialize.md
- Credential examples: CredentialProviderExample.md
```

