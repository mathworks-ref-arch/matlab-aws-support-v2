## ❓ 12. FAQ

### 🔸 How do I change library logging level?
- MATLAB ships SLF4J and configures Log4j as the backend. Version depends on your MATLAB release (≤ R2021b Update 2 → Log4j 1.x; newer → Log4j 2.x).
- Configure logging via one of:
  - `Software/MATLAB/lib/jar/log4j.properties` (Log4j 1.x):
    - Example: `log4j.rootLogger=INFO, stdout`
  - `Software/MATLAB/lib/jar/log4j2.xml` (Log4j 2.x):
    - Example: `<Root level="info" additivity="false">`

### 🔸 “Unable to resolve the name 'software.amazon.awssdk.auth.credentials.DefaultCredentialsProvider'”
- The AWS SDK v2 JARs are not on the Java static classpath.
- Run `Software/MATLAB/startup.m` and review its output; ensure the JARs are added and restart MATLAB.

### 🔸 “Unrecognized method, property, or field” when calling a client
- The MATLAB files are not on the MATLAB path.
- Run `Software/MATLAB/startup.m` to add classes and functions to the path.

### 🔸 “Unable to resolve the name 'aws.bedrock.runtime.Client'”
- Same cause as above: MATLAB path not initialized.
- Run `Software/MATLAB/startup.m` to register the package paths.

### 🔸 “The security token included in the request is expired”
- Temporary credentials (session tokens) have expired.
- Refresh credentials so that `~/.aws/credentials` is updated. If the `.aws` folder does not exist, create it and add the required files.

```{seealso}
- Troubleshooting.md
- Authentication.md
- ClientInitialize.md
```
