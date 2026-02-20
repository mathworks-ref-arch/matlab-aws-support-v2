function getSecretValueResponse = getSecretValue(obj, options)
    % getSecretValue Retrieves the contents of the encrypted fields SecretString
    %
    % Arguments:
    %   secretId : The ARN or name of the secret to delete.
    %
    % Optional named argument:
    %   versionId: The unique identifier of the version of the secret to retrieve. 
    %
    % Example:
    %   sm = aws.secretsmanager.Client()
    %   getSecretValueResponse = sm.getSecretValue("arn:aws:secretsmanager:us-west-1:123456789012:secret:mySecret123456789-gajDCW")

    % Copyright 2025 The MathWorks, Inc.

    arguments
        obj
        options.secretId (1,1) string {mustBeTextScalar, mustBeNonzeroLengthText}
        options.versionId (1,1) string {mustBeTextScalar, mustBeNonzeroLengthText}
    end

    write(obj.logObj, 'info', 'Getting Secret value in Secrets Manager');

    % Create a secret request builder
    getSecretValueRequestBuilder = software.amazon.awssdk.services.secretsmanager.model.GetSecretValueRequest.builder();
    getSecretValueRequest = aws.internal.builder.build(getSecretValueRequestBuilder, options);
 
    % Call the getSecretValue method from the AWS SDK
    responseJ = obj.Handle.getSecretValue(getSecretValueRequest);

    % Wrap the Java response in a MATLAB GetSecretValueResponse object
    getSecretValueResponse = aws.secretsmanager.model.GetSecretValueResponse(responseJ);
    write(obj.logObj, 'info', 'Got Secret value in Secrets Manager');
end
