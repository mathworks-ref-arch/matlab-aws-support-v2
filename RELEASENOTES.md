# MATLAB Interface *for Amazon Web Services* - Release Notes

## 2.1.6 (8th May, 2026)

*   Made `temperature` and `topP` optional in `bedrock.converse()`. Neither is sent
    by default, fixing compatibility with models (e.g., Claude Haiku 4.5) that reject
    requests containing both parameters. Callers should pass only one.
*   Added `systemPrompt` parameter to `bedrock.converse()` for passing system-level
    instructions via the Converse API system field.
*   Added unit tests for optional `topP`, explicit `topP`, and `systemPrompt`.

## 2.1.5 (10th Feb, 2026)

*   Added an "endpointOverride" option to the AWS S3 Client & TM to override URL.

## 2.1.4 (26th Jan, 2026)

*   Updated Bedrock Runtime image model unit test cases.

## 2.1.3 (7th Jan, 2026)

*   Updated gitlab ci yaml for packaging the release.

## 2.1.2 (20th Nov, 2025)

*   Added Third party License.

## 2.1.1 (19th Nov, 2025)

*   Added Documentation support for below mentioned AWS services:    
*   Updated Unit Tests coverage for below AWS services:
    *   **Amazon S3** (Simple Storage Service)
    *   **Amazon SQS** (Simple Queue Service)
    *   **Amazon SNS** (Simple Notification Service)
    *   **AWS Lambda**
    *   **Amazon DynamoDB**
    *   **Amazon Redshift**
    *   **Amazon Polly**
    *   **Amazon Athena**
    *   **AWS Systems Manager (SSM)**
    *   **Amazon ECS** (Elastic Container Service)
    *   **Amazon Bedrock Runtime Service**
    *   **Amazon Secrets Manager**

## 2.1.0 (17th Nov, 2025)

*   Added Documentation support for below mentioned AWS services:    
*   Updated Unit Tests coverage for below AWS services:
    *   **Amazon S3** (Simple Storage Service)
    *   **Amazon SQS** (Simple Queue Service)
    *   **Amazon SNS** (Simple Notification Service)
    *   **AWS Lambda**
    *   **Amazon DynamoDB**
    *   **Amazon Redshift**
    *   **Amazon Polly**
    *   **Amazon Athena**
    *   **AWS Systems Manager (SSM)**
    *   **Amazon ECS** (Elastic Container Service)
    *   **Amazon Bedrock Runtime Service**
    *   **Amazon Secrets Manager**


## 2.0.9 (14th Nov, 2025)

*   Added support for the following AWS services:
    *   **Amazon Secrets Manager**
*   Added Unit Tests for Amazon Secrets Manager.

## 2.0.8 (11th Nov, 2025)

*   Documentation updates and API reference docs updates.
*   Continuous Integration Pipeline setup.
*   Added Unit Tests to increase code coverage.

## 2.0.7 (11th Nov, 2025)

*   Continuous Integration Pipeline setup.
*   Added Unit Tests to increase code coverage.

## 2.0.6 (7th Nov, 2025)

*   Added support for the following AWS services:
    *   **Amazon S3** (Simple Storage Service)
    *   **Amazon SQS** (Simple Queue Service)
    *   **Amazon SNS** (Simple Notification Service)
    *   **AWS Lambda**
    *   **Amazon DynamoDB**
    *   **Amazon Redshift**
    *   **Amazon Polly**
    *   **Amazon Athena**
    *   **AWS Systems Manager (SSM)**
*   Continued support for **Amazon Bedrock Runtime Service** with multimodal and image prompt capabilities.
*   Enhanced integration for **Amazon ECS** including Fargate deployment examples.
*   Basic support for retrieving caller identity via **Amazon STS** (Security Token Service).
*   Documentation updates to reflect new services and usage examples.

## 0.0.7 (20th Sep, 2024)

* AWS Bedrock Runtime Service: Enhanced performance and functionality.
* Added support for Amazon Elastic Container Service (ECS).
* Example for deploying MATLAB algorithms as microservices on Amazon ECS Fargate.
* Basic support for retrieving caller identity with Amazon Security Token Service (STS).

## 0.0.6 (30th Aug, 2024)

* Added image prompt support for multimodals in AWS Bedrock Runtime Service.

## 0.0.5 (30th Aug, 2024)

* Documentation Updates.

## 0.0.4 (29th Aug, 2024)

* CI release fixes.

## 0.0.3 (29th Aug, 2024)

* Added Documentation and CI release fixes.

## 0.0.2 (28th Aug, 2024)

* Added support to Amazon Bedrock Runtime service.
* Created Documentation for the Interface.
* Created Automated CI/CD Pipeline in GitLab.

## 0.0.1 (23rd Aug, 2024)

* Updated the POM.xml to use version 2 of the AWS SDK.
