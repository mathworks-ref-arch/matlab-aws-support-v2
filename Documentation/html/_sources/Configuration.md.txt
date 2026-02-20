## 🛠️ 3. Configuration

### 🔧 3.1 Configure the MATLAB Java Class Path

Once the SDK JAR file is built, it must be added to MATLAB's Java class path so the AWS SDK for Java v2 can be accessed.

#### 🔹 Dynamic Class Path (Default)

The `startup.m` script automatically adds the JAR to MATLAB's **dynamic class path** for both local and deployed environments. This is sufficient for most workflows.

#### 🔹 Static Class Path (Advanced Use)

If your workflow involves:

*   Java services
*   Proxy configuration
*   Credential features that require early class loading (especially on Linux)

…then you may need to add the JAR to MATLAB's **static class path**.

#### 📝 How to Add to Static Class Path

1.  Open the `javaclasspath.txt` file in MATLAB's preferences directory:

    ```matlab
    edit(fullfile(prefdir, 'javaclasspath.txt'));
    ```

2.  Add the following entry (adjust path as needed):

    ```bash    
    <before>
    /absolute/path/to/matlab-aws-support-v2/Software/MATLAB/lib/jar/matlab-aws-support-v2-0.1.0.jar
    ```

```{tip}
*   Use full absolute paths.
*   Include both the JAR file and its containing directory (for Log4j config support).
*   The **<before**> tag ensures the JAR is loaded **at the beginning** of the class path (recommended for Linux).
```

3.  Restart MATLAB and verify the class path:

    ```matlab
    javaclasspath
    ```

    You should see the JAR listed at the start or end of the output.

```{note}
When using MathWorks features that automatically add JARs to the static class path (e.g., <https://www.mathworks.com/help/matlab/matlab_prog/create-and-share-custom-matlab-toolboxes.html> or MATLAB Compiler SDK components), the JAR is typically added to the **end** of the static path.  
In some cases, these features may fall back to adding the JAR to the **dynamic** path if static placement isn't feasible.
```

### 🔌 3.2 Initialize the Interface

To finalize setup, add the interface directories to your MATLAB path:

```matlab
run('matlab-aws-support-v2/Software/MATLAB/startup.m');
```

```{note}
When making use of MathWorks features which can automatically add jar files to the static class path, these typically add them to then *end* of the static class path. For example when working with a [packaged custom toolbox](https://www.mathworks.com/help/matlab/matlab_prog/create-and-share-custom-matlab-toolboxes.html) the included jar file is added to the *end* of the static path in the end user MATLAB installation. Or if working with MATLAB Compiler® (SDK) standalone components the jar file which was packaged into the component are automatically added to the *end* of the static class path at runtime. However there may be situations in which this is not possible and then these features may add the jar file to the dynamic class path. 
```
