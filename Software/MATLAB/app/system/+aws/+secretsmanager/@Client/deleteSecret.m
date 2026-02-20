function deleteSecretResponse = deleteSecret(obj, options)
    % deleteSecret Deletes a new secret
    %
    % Arguments:
    %   secretId : The ARN or name of the secret to delete.
    %
    % Optional named argument:
    %   recoveryWindowInDays : The number of days from 7 to 30 that Secrets Manager
    %                          waits before permanently deleting the secret.
    %
    % Example:
    %   sm = aws.secretsmanager.Client()
    %   deleteSecretResponse = sm.deleteSecret("arn:aws:secretsmanager:us-west-1:123456789012:secret:mySecret123456789-gajDCW")

    % Copyright 2025 The MathWorks, Inc.

    arguments
        obj
        options.secretId (1,1) string {mustBeTextScalar, mustBeNonzeroLengthText}
        options.recoveryWindowInDays (1,1) int64 {mustBeInteger}
        options.forceDeleteWithoutRecovery (1,1) logical
    end

    write(obj.logObj, 'info', 'Deleting Secret in Secrets Manager');

    % Create a secret request builder
    deleteSecretRequestBuilder = software.amazon.awssdk.services.secretsmanager.model.DeleteSecretRequest.builder();    
    deleteSecretRequest = aws.internal.builder.build(deleteSecretRequestBuilder, options);
 
    % Call the deleteSecret method from the AWS SDK
    responseJ = obj.Handle.deleteSecret(deleteSecretRequest);

    % Wrap the Java response in a MATLAB DeleteSecretResponse object
    deleteSecretResponse = aws.secretsmanager.model.DeleteSecretResponse(responseJ);
    write(obj.logObj, 'info', 'Deleted Secret in Secrets Manager');
end
