function createSecretResponse = createSecret(obj, options)
    % CREATESECRET Creates a new secret
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
    % createSecretsManagerResponse = ecs.createSecret(name='secretmgr_name', secretString='aSKBDKAsbd#kas');

    % Copyright 2025 The MathWorks, Inc.

    arguments
        obj
        options.name (1,1) string {mustBeTextScalar, mustBeNonzeroLengthText}
        options.secretString (1,1) string {mustBeTextScalar}
        options.secretBinary (1,1) aws.core.model.SdkBytes  % accepts java SdkBytes wrapper too
        options.description (1,1) string {mustBeTextScalar}
        options.tag dictionary
    end

    write(obj.logObj, 'info', 'Creating Secret in Secrets Manager');

    % Create a secret request builder
    createSecretRequestBuilder = software.amazon.awssdk.services.secretsmanager.model.CreateSecretRequest.builder(); 
    if isfield(options, 'tag')
        createSecretRequestBuilder.tags(aws.internal.builder.buildSdkObjectsFromDictionary(options.tag, ...
            'software.amazon.awssdk.services.secretsmanager.model.Tag'));
        options = rmfield(options, 'tag');
    end

    createSecretRequest = aws.internal.builder.build(createSecretRequestBuilder, options);
 
    % Call the createSecret method from the AWS SDK
    responseJ = obj.Handle.createSecret(createSecretRequest);

    % Wrap the Java response in a MATLAB CreateSecretResponse object
    createSecretResponse = aws.secretsmanager.model.CreateSecretResponse(responseJ);
    write(obj.logObj, 'info', 'Created Secret in Secrets Manager');
end
