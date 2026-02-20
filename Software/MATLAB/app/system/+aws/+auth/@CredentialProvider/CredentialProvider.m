classdef CredentialProvider < handle
    % CREDENTIALPROVIDER Factories for AWS credential providers (AWS SDK for Java v2).
    %
    % Syntax
    %   cp = aws.auth.CredentialProvider.getProfileCredentialProvider("analytics");
    %   [cp, region] = aws.auth.CredentialProvider.getDefaultCredentialProvider();
    %
    % Description
    %   Use this utility to create credential providers that can be supplied to any
    %   MATLAB AWS client via the 'credentialsprovider' Name-Value argument. Each
    %   factory returns a Java handle from the AWS SDK for Java v2.
    %
    % Notes
    %   - The default chain automatically discovers credentials from your
    %     environment, shared config files, and instance metadata services.
    %   - Profile-based access supports IAM Identity Center (SSO) profiles after
    %     you run `aws sso login --profile <name>`.
    %   - Helpers that accept Access Key ID/Secret pairs should only be used for
    %     short-lived development tasks.

    % Copyright 2025 The MathWorks, Inc.
    
    methods (Static)
        function [credProv, awsRegion] = getDefaultCredentialProvider()
            % GETDEFAULTCREDENTIALPROVIDER Resolve credentials and region via the default chain.
            %
            % Syntax
            %   [credProv, region] = aws.auth.CredentialProvider.getDefaultCredentialProvider();
            %
            % Returns
            %   credProv - software.amazon.awssdk.auth.credentials.DefaultCredentialsProvider.
            %   awsRegion - (string) Region resolved by DefaultAwsRegionProviderChain.
            %
            % Notes
            %   - Credential lookup follows the AWS SDK order: system properties,
            %     environment variables, web identity hints, shared config files,
            %     process credentials, then IMDS/ECS metadata.
            %   - Region resolution checks AWS_REGION/AWS_DEFAULT_REGION, system
            %     property aws.region, shared config, and metadata services.
            %
            import software.amazon.awssdk.auth.credentials.DefaultCredentialsProvider
            import software.amazon.awssdk.regions.providers.DefaultAwsRegionProviderChain

            credProv = DefaultCredentialsProvider.create();
            rp = DefaultAwsRegionProviderChain();
            awsRegion = char(rp.getRegion().id());
        end

        function credProv = getProfileCredentialProvider(profile)
            % GETPROFILECREDENTIALPROVIDER Load credentials from a named shared config profile.
            %
            % Syntax
            %   cp = aws.auth.CredentialProvider.getProfileCredentialProvider();
            %   cp = aws.auth.CredentialProvider.getProfileCredentialProvider("analytics");
            %
            % Inputs
            %   profile - (string, optional) Profile name found in ~/.aws/config or
            %             ~/.aws/credentials. Defaults to "default".
            %
            % Returns
            %   credProv - software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider.
            %
            % Notes
            %   - Profiles may source static keys, SSO sessions, credential_process,
            %     or assume-role directives exactly as the AWS CLI does.
            %   - Run `aws sso login --profile <name>` before using SSO-backed profiles.
            %
            arguments
                profile (1,1) string {mustBeTextScalar} = "default"
            end

            import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider
            credProv = ProfileCredentialsProvider.create(char(profile));
        end

        function credProv = getInstanceProfileCredentialProvider()
            % GETINSTANCEPROFILECREDENTIALPROVIDER Use the EC2 instance profile or ECS task role.
            %
            % Syntax
            %   cp = aws.auth.CredentialProvider.getInstanceProfileCredentialProvider();
            %
            % Returns
            %   credProv - software.amazon.awssdk.auth.credentials.InstanceProfileCredentialsProvider.
            %
            % Description
            %   Retrieves credentials from the Instance Metadata Service (IMDS) or the
            %   container metadata endpoint when running inside EC2, ECS, or similar
            %   managed compute environments.
            %
            import software.amazon.awssdk.auth.credentials.InstanceProfileCredentialsProvider
            credProv = InstanceProfileCredentialsProvider.builder().build();
        end

        function credProv = getBasicCredentialProvider(awsID, awsKey)
            % GETBASICCREDENTIALPROVIDER Create a static credential provider.
            %
            % Syntax
            %   cp = aws.auth.CredentialProvider.getBasicCredentialProvider("AKIA...", "SECRET...");
            %
            % Inputs
            %   awsID  - (string) AWS Access Key ID.
            %   awsKey - (string) AWS Secret Access Key.
            %
            % Returns
            %   credProv - software.amazon.awssdk.auth.credentials.StaticCredentialsProvider.
            %
            % Description
            %   Use only when you must embed long-lived IAM user credentials. Prefer
            %   roles or the default chain whenever possible.
            %
            arguments
                awsID (1,1) string {mustBeNonzeroLengthText}
                awsKey (1,1) string {mustBeNonzeroLengthText}
            end

            import software.amazon.awssdk.auth.credentials.AwsBasicCredentials
            import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider
            base = AwsBasicCredentials.create(char(awsID), char(awsKey));
            credProv = StaticCredentialsProvider.create(base);
        end

        function credProv = getSessionCredentialProvider(awsID, awsKey, awsSessionToken)
            % GETSESSIONCREDENTIALPROVIDER Wrap temporary STS or federation credentials.
            %
            % Syntax
            %   cp = aws.auth.CredentialProvider.getSessionCredentialProvider(id, key, token);
            %
            % Inputs
            %   awsID           - (string) Access Key ID.
            %   awsKey          - (string) Secret Access Key.
            %   awsSessionToken - (string) Session token from STS, SSO, or federation.
            %
            % Returns
            %   credProv - software.amazon.awssdk.auth.credentials.StaticCredentialsProvider.
            %
            % Description
            %   Call this helper when you already possess temporary credentials and
            %   simply need to package them into an SDK-compatible provider.
            %
            arguments
                awsID (1,1) string {mustBeNonzeroLengthText}
                awsKey (1,1) string {mustBeNonzeroLengthText}
                awsSessionToken (1,1) string {mustBeNonzeroLengthText}
            end

            import software.amazon.awssdk.auth.credentials.AwsSessionCredentials
            import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider
            ses = AwsSessionCredentials.create(char(awsID), char(awsKey), char(awsSessionToken));
            credProv = StaticCredentialsProvider.create(ses);
        end

        function credProv = getWebIdentityCredentialProvider()
            % GETWEBIDENTITYCREDENTIALPROVIDER Assume a role via OIDC/IRSA environment variables.
            %
            % Syntax
            %   cp = aws.auth.CredentialProvider.getWebIdentityCredentialProvider();
            %
            % Returns
            %   credProv - software.amazon.awssdk.auth.credentials.WebIdentityTokenFileCredentialsProvider.
            %
            % Description
            %   Reads AWS_ROLE_ARN, AWS_WEB_IDENTITY_TOKEN_FILE, and (optionally)
            %   AWS_ROLE_SESSION_NAME to exchange a web identity token for temporary
            %   credentials. Commonly used with Amazon EKS IAM Roles for Service Accounts.
            %
            import software.amazon.awssdk.auth.credentials.WebIdentityTokenFileCredentialsProvider
            credProv = WebIdentityTokenFileCredentialsProvider.create();
        end

        function [credProv, awsRegion] = getJsonFileCredentialProvider(jsonFile)
            % GETJSONFILECREDENTIALPROVIDER Load credentials from a simple JSON file.
            %
            % Syntax
            %   [cp, region] = aws.auth.CredentialProvider.getJsonFileCredentialProvider("creds.json");
            %
            % Inputs
            %   jsonFile - (string) Path to a JSON file that contains
            %              aws_access_key_id, aws_secret_access_key, optional
            %              aws_session_token, and optional region.
            %
            % Returns
            %   credProv  - Static or session credentials provider depending on whether
            %               aws_session_token is present.
            %   awsRegion - (string) Region from the file when supplied, otherwise "".
            %
            arguments
                jsonFile (1,1) string {mustBeNonzeroLengthText}
            end

            data = jsondecode(fileread(jsonFile));
            requiredFields = ["aws_access_key_id", "aws_secret_access_key"];
            for idx = 1:numel(requiredFields)
                fieldName = requiredFields(idx);
                if ~isfield(data, fieldName)
                    error('aws:auth:CredentialProvider:MissingJsonField', ...
                        'JSON credentials file "%s" is missing the "%s" field.', jsonFile, fieldName);
                end
            end

            accessKeyId = string(data.aws_access_key_id);
            secretAccessKey = string(data.aws_secret_access_key);
            sessionToken = "";
            if isfield(data, 'aws_session_token')
                sessionToken = string(data.aws_session_token);
            end

            if strlength(strtrim(sessionToken)) == 0
                credProv = aws.auth.CredentialProvider.getBasicCredentialProvider(accessKeyId, secretAccessKey);
            else
                credProv = aws.auth.CredentialProvider.getSessionCredentialProvider(accessKeyId, secretAccessKey, sessionToken);
            end

            awsRegion = "";
            if isfield(data, 'region') && strlength(strtrim(string(data.region))) > 0
                awsRegion = string(data.region);
            end
        end
    end

end
