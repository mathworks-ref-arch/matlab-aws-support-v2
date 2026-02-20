## ⚙️ 2. Installation

### 📦 2.1 Prerequisites

- MATLAB R2023b or later
- Java Development Kit (JDK) 8 to < 18
- Apache Maven 3.8.8 or later

```{important}
Starting in MATLAB R2025b, Bring Your Own Java (BYOJ) applies. Ensure a supported Java is installed and selected.
```

### 🧲 2.2 Clone the Repository

Clone the repository including submodules if any:

```bash
git clone --recursive <repo-url>
cd matlab-aws-support-v2
```

### 📦 2.3 Build the MATLAB AWS SDK JAR

Build the Java components and package the JAR:

```bash
cd Software/Java
mvn clean package
```

Output:

```
Software/MATLAB/lib/jar/matlab-aws-support-v2-<version>.jar
```

### 🛠️ 2.4 Add to MATLAB Path and Initialize

Add the MATLAB interface folders to your path by running:

```matlab
run('Software/MATLAB/startup.m');
```

Verify:

```matlab
s3 = aws.s3.Client();
disp(s3.listBuckets());
```


```{note}
The above verification assumes that valid AWS credentials are available via the https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/credentials.html. This allows clients to be created without explicitly specifying a credential provider.
```

### 🧩 2.5 Optional: Static Java Class Path

Most workflows work with the dynamic path set by `startup.m`. If your workflow requires the JAR on the static class path (e.g., certain Java integrations), edit `javaclasspath.txt`:

```matlab
edit(fullfile(prefdir,'javaclasspath.txt'));
```

Add the absolute path to the JAR, e.g.:

```
/absolute/path/to/matlab-aws-support-v2/Software/MATLAB/lib/jar/matlab-aws-support-v2-<version>.jar
```

Then restart MATLAB.

```{note}
Prefer dynamic class path during development; use static only when required.
```

