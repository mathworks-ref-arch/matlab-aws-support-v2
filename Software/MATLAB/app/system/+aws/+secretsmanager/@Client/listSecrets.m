function ListSecretsResponse = listSecrets(obj, options)
    % LISTSECRETS Lists the secrets that are stored by Secrets Manager in the AWS account
    %
    % This function retrieves a list of all topics in Amazon SNS. It supports
    % pagination through the use of a next token. For more detailed topic listing,
    % consider using the underlying AWS SDK classes and methods directly.
    %
    % All Secrets Manager operations are eventually consistent. ListSecrets might not
    % reflect changes from the last five minutes.
    %
    % Optional Arguments:
    % nextToken : Token to specify where to start paginating. This is the
    %             NextToken from a previously truncated response.
    %
    % Example:
    %   sm = aws.secretsmanager.Client()
    %   listSecretsResponse = sm.listSecrets()
    %   OR
    %   listSecretsResponse = sm.listSecrets(nextToken='someToken')

    % Copyright 2025 The MathWorks, Inc.

    arguments
        obj
        options.nextToken (1,1) string {mustBeTextScalar, mustBeNonzeroLengthText}
        options.maxResults (1,1) int32 {mustBeInteger}
        options.sortOrder (1,1) string {mustBeTextScalar}
    end

    write(obj.logObj, 'info', 'Listing Secrets in Secrets Manager');

    % Create a list secrets request builder
    listSecretsRequestBuilder = software.amazon.awssdk.services.secretsmanager.model.ListSecretsRequest.builder();

    listSecretRequest = aws.internal.builder.build(listSecretsRequestBuilder, options);

    % Call the listTopics method from the AWS SDK
    responseJ = obj.Handle.listSecrets(listSecretRequest);

    % Wrap the Java response in a MATLAB ListTopicsResponse object
    ListSecretsResponse = aws.secretsmanager.model.ListSecretsResponse(responseJ);
    write(obj.logObj, 'info', 'Listed Secrets in Secrets Manager Service');

end
