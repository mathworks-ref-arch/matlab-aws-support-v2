function updateSecretResponse = updateSecret(obj, options)
    % UPDATESECRET Updates a new secret
    %
    % Arguments:
    % name : The name of the secretsmanager.
    % secretString : The secret string of the secretsmanager.
    %
    % Optional Arguments:
    % description : The description for the secretsmanager.
    % tag : The dictionary containing tag information.
    %
    % Example:
    % ecs = aws.secretsmanager.Client();
    % updateSecretManagerResponse = ecs.updateSecret(name='secretmgr_name', secretString='aSKBDKAsbd#kas');

    % Copyright 2025 The MathWorks, Inc.

    arguments
        obj
        options.secretString (1,1) string {mustBeTextScalar}
        options.secretBinary (1,1) aws.core.model.SdkBytes  % accepts java SdkBytes wrapper too
        options.secretId (1,1) string {mustBeTextScalar}
        options.description (1,1) string {mustBeTextScalar}
        options.kmsKeyId (1,1) string {mustBeTextScalar}
        options.clientRequestToken (1,1) string {mustBeTextScalar}
    end

    write(obj.logObj, 'info', 'Updating Secret in Secrets Manager');

    % Update a secret request builder
    updateSecretRequestBuilder = software.amazon.awssdk.services.secretsmanager.model.UpdateSecretRequest.builder(); 
    updateSecretRequest = aws.internal.builder.build(updateSecretRequestBuilder, options);
 
    % Call the updateSecret method from the AWS SDK
    responseJ = obj.Handle.updateSecret(updateSecretRequest);

    % Wrap the Java response in a MATLAB UpdateSecretResponse object
    updateSecretResponse = aws.secretsmanager.model.UpdateSecretResponse(responseJ);
    write(obj.logObj, 'info', 'Updated Secret in Secrets Manager');
end
