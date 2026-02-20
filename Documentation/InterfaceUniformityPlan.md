## MATLAB AWS SDK – Interface & Documentation Uniformity Plan

### 1. Purpose & Scope
- Establish a single doc/comment template (Summary → Syntax → Name-Value Arguments → Inputs/Outputs → Example → Notes/Copyright) for every MATLAB file under `Software/MATLAB/app/system/+aws`, per repo guideline (“document every MATLAB file” and drop `Description`/`See also` sections).
- Align client/method signatures, logging, and builder usage so that every service follows the same constructor/Name-Value pattern enforced by `aws.core.BaseClient`.
- Modernize `Documentation/*.md` and `Documentation/AWSSDKAPI.md` to the table-driven style that already exists for Athena client methods, ensuring future additions/deletions are simple.
- Clean up supporting infrastructure (shared utilities, packaging assets, release docs) so that the support package is consistent and professional when shipped.

### 2. Current Coverage Snapshot
The repo contains **226 MATLAB files** under `Software/MATLAB/app/system/+aws`, and **135** now include the agreed `% Syntax` scaffold thanks to the DynamoDB/Lambda/SNS/SQS/SSM push.  
The table below (refreshed via the coverage script) shows which packages still need the new documentation template.

| Package          | MATLAB files | Files with new template |
|------------------|-------------:|------------------------:|
| +athena          | 12 | 8 |
| +auth            | 1  | 0 |
| +bedrock         | 8  | 0 |
| +core            | 3  | 0 |
| +dynamodb        | 40 | 34 |
| +ecs             | 19 | 0 |
| +lambda          | 11 | 11 |
| +polly           | 12 | 0 |
| +redshift        | 1  | 0 |
| +redshiftdata    | 8  | 0 |
| +s3              | 53 | 30 |
| +sns             | 22 | 22 |
| +sqs             | 18 | 18 |
| +ssm             | 12 | 12 |
| +sts             | 3  | 0 |
| @Object          | 3  | 0 |

### 3. Key Findings

#### 3.1 Client entry points
- **Bedrock runtime and S3 clients still use free-form prose.** Files such as `+bedrock/+runtime/@Client/Client.m` and `+s3/@Client/Client.m` lack Syntax/Name-Value sections, so constructors are undocumented and inconsistent with the newer Athena style.
- **Authentication messaging varies.** Several clients embed ad-hoc “Authentication Credentials” paragraphs while others rely on shared docs, leading to duplicated or stale guidance.
- **Base class defaults are duplicated.** `aws.core.BaseClient` requests default credentials and regions twice (once for credentials, once again inside the region block), which is wasteful and complicates overriding.

#### 3.2 Operation methods
- **Parameter names in docs don’t match the code.** `s3.createBucket` documents `bucketName` yet the `arguments` block exposes `options.bucket`, and examples still reference `aws.s3.S3Client`.
- **Many functions still reference positional inputs.** `ecs.createCluster`, `ecs.createService`, and `polly.synthesizeSpeech` still describe positional/struct inputs even though the implementations require Name-Value pairs via `options`.
- **Examples are incomplete or missing.** Large sections of the S3 TransferManager (`downloadDirectory`, `uploadDirectory`) and ECS waiters lack runnable examples and omit the return structure.
- **Bedrock helpers need validation.** `bedrock.runtime.Client.converse` performs manual `rmfield` manipulation and assumes `messages` is pre-populated, but the doc block never explains the lifecycle of `aws.bedrock.runtime.model.Message` or mutual exclusivity of prompt sources.

#### 3.3 Model & utility classes
- **Response models expose untyped/public fields.** Objects such as `aws.s3.model.GetObjectResponse` simply mirror Java handles into public MATLAB properties without documenting types, optionality, or related helper methods.
- **Core wrappers need cleanup.** `aws.core.model.RequestBody` contains an unreachable branch for file payloads due to duplicated string checks, and `aws.core.model.SdkBytes` uses `disp` in production code while assuming any string is either UTF-8 text or a `.zip` path.
- **Bedrock payload utilities are brittle.** `bedrock.runtime.utils.buildModelPayload` hardcodes JSON bodies per model without input validation or discoverability, making it difficult to extend when AWS adds new variants.

#### 3.4 Documentation set (`Documentation/*.md` + `AWSSDKAPI.md`)
- **Service pages still include `{seealso}` blocks.** `Documentation/S3.md` and `Documentation/Athena.md` retain sections the stakeholder asked to drop, and they list method anchors that no longer match the table IDs in `AWSSDKAPI.md`.
- **AWSSDK API entries mix old and new styles.** Athena, DynamoDB, Lambda, SNS, SQS, and SSM now use the table format, but the remaining heavyweights (S3, ECS, Polly, Bedrock, STS) still rely on the legacy prose with inconsistent class names such as `aws.s3.S3Client`.
- **Model coverage is sparse.** Many `aws.*.model` classes are listed without property tables, so it is unclear which MATLAB properties exist, how they map to the Java SDK, or whether setters are available.

#### 3.5 Support package infrastructure
- **`aws.internal.builder.build` lacks documentation and guardrails.** The helper silently converts MATLAB types into Java builders but does not warn when a field name is unsupported or when arrays contain unexpected classes.
- **Logging practices aren’t uniform.** Some routines (`RequestBody`, `SdkBytes`) call `disp` directly, while others use `Logger`. Error messaging should always go through `write(obj.logObj, …)` for consistency and testability.
- **Release assets reference outdated class names.** Examples in service docs and AWSSDK API sections still use `aws.s3.S3Client`, which predates the BaseClient refactor to `aws.s3.Client`.

### 4. Uniform Design Decisions (to be enforced)
1. **Doc comment template (applies to every `.m` file):**
   - Summary sentence (imperative form or noun phrase).
   - `Syntax` block with one or more canonical usage lines.
   - `Name-Value Arguments` block (or `Inputs`/`Outputs` for positional methods).
   - `Returns`/`Output Arguments`.
   - `Example` (concise, valid MATLAB snippet that compiles).
   - Optional `Notes` for auth/permissions (replace the old “Authentication Credentials” paragraph).
2. **Client/API signature rules:**
   - All client constructors remain Name-Value only (`region`, `credentialsprovider`, `isCrt`) and reference `aws.auth.CredentialProvider` for defaults.
   - Operation methods accept a single `options` struct via the `arguments` block. Documentation must mirror the exact field names.
   - Log strings use `write(obj.logObj, level, message)` with a consistent service name (e.g., “Amazon S3” instead of alternating full service titles).
3. **Model/response documentation:**
   - Each model class lists MATLAB properties in a table (Name, Type, Source Java accessor, Notes) and explains how to construct or wrap Java instances.
   - Helpers like `RequestBody`/`SdkBytes` expose explicit factory methods (`fromString`, `fromFile`, etc.) instead of guessing inside the constructor.
4. **AWSSDK API tables:**
   - For every method: `Name-Value Argument` table + `Returns` table + example fence block, matching the Athena entries.
   - For every model: `Property` table describing MATLAB property name, type, and read/write behavior.
   - Stop embedding ` ```text` fences for long prose; use concise Markdown tables for consistency and easy diffing.

### 5. Phased Implementation Plan

| Phase | Focus | Deliverables |
|-------|-------|--------------|
| **0. Template finalization & tooling** | Codify the MATLAB doc template in CONTRIBUTING and add a doc-lint script that fails when a file lacks the `% Syntax` marker. Update `BaseClient` once to remove the duplicate default-provider lookups. |
| **1. Client sweep (service by service)** | Continue with the remaining high-visibility services (S3, ECS, Polly, Bedrock) now that DynamoDB, Lambda, SNS/SQS, and SSM are aligned. For each client folder: update class docblocks, ensure constructor examples compile, and normalize logging strings. |
| **2. Operation + model alignment** | Document each public method/model under the service before moving on. Verify `arguments` blocks match documentation, add missing input validation, and refactor helpers like `RequestBody`/`SdkBytes` into clearer factory-style APIs. |
| **3. Documentation site refresh** | Convert `Documentation/*.md` sections to remove `Description/See also`, regenerate method tables from the updated MATLAB comments, and fully rewrite `AWSSDKAPI.md` using the table pattern. Ensure anchors stay stable for future additions. |
| **4. Support package polish** | Audit `aws.internal` utilities, replace `disp` with logger calls, ensure packaging scripts/tests reference the new docs, and run doc build (`make html`) to validate links. Provide release notes summarizing the uniform interface changes. |

Recommend tackling services in slices (e.g., “Complete S3” meaning client + operations + models + AWSSDK tables) before moving on, to avoid drifting documentation.

### 6. Automation & Tracking Ideas
- **Doc coverage dashboard:** Keep the Python-based counter (used for the table above) under `tools/` so CI can fail when coverage regresses.
- **AWSSDK generator stub:** Extract Name-Value definitions from each `arguments` block to auto-emit the Markdown tables, ensuring the source of truth lives in the MATLAB code.
- **Lint for legacy phrases:** Simple `rg` checks for `aws.s3.S3Client`, `Authentication Credentials`, and `See also` blocks can prevent reintroducing deprecated wording.
- **Example verifier:** Add lightweight smoke tests that instantiate each client with mocked credentials and execute the code shown in documentation examples (using stubbed responses where necessary).

### 7. Immediate Next Steps
1. Check in the doc-coverage script (used for the table above) and surface the 135/226 score in CI so regressions are caught automatically.
2. Complete the **ECS** slice (client, operations, waiters, models, and `Documentation/AWSSDKAPI.md` tables) to bring another high-touch service onto the unified template.
3. Finish the **S3** rewrite by covering the remaining TransferManager/streaming helpers and syncing their documentation tables with the MATLAB comments.
4. After ECS + S3 land, refactor `RequestBody`/`SdkBytes` into explicit factory helpers and gate the documentation build (`make html`) to ensure the refreshed AWSSDK tables render without errors.

This plan keeps interface, documentation, and packaging improvements moving in lockstep, providing a professional, uniform MATLAB experience across all AWS services in the support package.
