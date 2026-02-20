# Unit Tests

The package includes various MATLAB® Unit Tests for testing the different interfaces and clients for the different AWS® services. These tests can be found in `Software/MATLAB/test/unit` and they are further split into directories for different AWS services as well as a `common` directory:

* `/common`
* `/auth`
* `/services`

The `/services` directory includes projects like `/bedrock-runtime` and other aws services projects.

The Unit Tests are designed to test various methods of AWS credential authorization using MATLAB. It ensures that different AWS credential providers can be instantiated and function correctly. The test suite is built to run in both local environments and CI/CD environments, such as GitLab. It checks for the presence of specific environment variable (`GITLAB_CI`=`true`) to determine the execution environment.

**Credential Sources**
    ***GitLab**: Requires a credentials.json file that contains the necessary AWS credentials.
    ***Local Machine**: Reads credentials from the .aws/credentials file located in the user's home directory. Alternatively, you can use other approaches to create AWS Credential Provider and pass it to instantiate the AWS Client objects. Check [Credential Providers](CredentialProviderExample.md)

**Logging**
A logging object (`logObj`) is initialized for each test, which can be configured for different verbosity levels to aid in debugging and result tracking.

**CI/CD Compatibility**:
The class is designed with CI/CD pipelines in mind, automatically adapting its behavior based on environment variables to facilitate automated testing.

## `/auth` AWS Authentication Unit Tests

All Auth Unit Tests are performed using AWS credentials. There are no interactive tests, ensure that the AWS credentials used have the necessary permissions for authentication tests. See [Authentication](Authentication.md) for more details on different authentication means in CI/CD and local environments.

## `/services` AWS Service Unit Tests

This folder contains MATLAB unit test suite designed to validate the functionality of different AWS Services like Amazon Bedrock Runtime, S3, DynamoDB, etc. It tests basic operations of the respective service. Ensure that the necessary AWS resources (like S3 buckets, DynamoDB tables, Bedrock Foundation Models, etc.) are configured and accessible by the credentials used.

> **NOTE:** The services features cannot be tested entirely independently. To be properly tested, the authentication approach should be selected appropriately. The `/services` include individual test cases to test their respective AWS services like `BedrockRuntimeClient`, `S3Client`, `DynamoDBClient`, `SNSClient`, etc. Hence these tests also require corresponding AWS resources and athentication means.

[//]: #  (Copyright 2025 The MathWorks, Inc.)
