## 💻 8. AWS CLI from within MATLAB

The **AWS Command Line Interface (AWS CLI)** provides a consistent command-line interface for interacting with AWS services.  
AWS CLI commands for different services are documented in the <https://aws.amazon.com/documentation/cli/>.

This MATLAB function acts as a wrapper around the AWS CLI, allowing you to run AWS CLI commands directly from the MATLAB command prompt.

```{important}
This function assumes:
- The AWS CLI is installed and available on your system `PATH`.
- AWS CLI is configured with valid credentials (via the default provider chain or `aws configure`).
```

***

### 🧩 8.1 Examples

Run an AWS CLI command from MATLAB:

```matlab
aws('s3api list-buckets')
```

Alternatively, you can omit parentheses:

```matlab
aws s3api list-buckets
```

#### Output Behavior

*   If **no output arguments** are specified, the command output is echoed to the MATLAB Command Window.
*   If **output arguments** are provided, the function returns:
    *   `status` — exit status of the CLI command.
    *   `output` — parsed output (struct by default).

Example:

```matlab
[status, output] = aws('s3api','list-buckets');

output =
  struct with fields:
    Owner: [1x1 struct]
    Buckets: [15x1 struct]
```

By default, JSON output from AWS CLI is converted to a MATLAB struct for easier programmatic use.  
If you specify `--output text` or `--output table`, the output will be returned as a character vector.

***

### ✅ Key Features

*   Supports **name-value arguments** for AWS CLI options.
*   Automatically decodes JSON output into MATLAB structs.
*   Falls back to raw text for non-JSON formats.

***

### 📘 Notes & Best Practices

*   Ensure AWS CLI is installed and configured before using this function.
*   Use `json` output for structured data; other formats (`text`, `table`) return raw strings.
*   Handle errors gracefully using `try/catch` when integrating into scripts.