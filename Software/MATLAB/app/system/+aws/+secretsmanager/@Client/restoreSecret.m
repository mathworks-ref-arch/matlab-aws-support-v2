function restoreSecretResponse = restoreSecret(obj, options)
%RESTORESECRET Restore a scheduled-deleted secret within the recovery window.
%
% Usage:
%   resp = sm.restoreSecret(secretId="prod/app/creds");
%
% Required:
%   options.secretId  : (1,1) string  Name or full ARN of the secret to restore.
%
% Notes:
%   - You can only restore a secret that was deleted with a recovery window
%     and is still within that window.

% Copyright 2025 The MathWorks, Inc.

    arguments
        obj
        options.secretId (1,1) string {mustBeTextScalar, mustBeNonzeroLengthText}
    end

    write(obj.logObj, 'info', 'Restoring Secret value in Secrets Manager');
    % Build the request
    reqB = software.amazon.awssdk.services.secretsmanager.model.RestoreSecretRequest.builder();
    restoreSecretRequest = aws.internal.builder.build(reqB, options);

    responseJ = obj.Handle.restoreSecret(restoreSecretRequest);
    
    % Wrap the Java response in a MATLAB UpdateSecretResponse object
    restoreSecretResponse = aws.secretsmanager.model.RestoreSecretResponse(responseJ);
    write(obj.logObj, 'info', 'Restored Secret in Secrets Manager');
end