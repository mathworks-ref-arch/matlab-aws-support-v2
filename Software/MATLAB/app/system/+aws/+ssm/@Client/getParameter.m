function response = getParameter(obj, options)
% GETPARAMETER Retrieve a Systems Manager parameter.
%
% Syntax
%   resp = ssm.getParameter(name="/myparam");
%   resp = ssm.getParameter(name="/secure/secret", withDecryption=true);
%
% Name-Value Arguments
%   name           - (string, required) Parameter path or friendly name.
%   withDecryption - (logical) Set true to decrypt SecureString values (default false).
%
% Returns
%   aws.ssm.model.GetParameterResponse containing the parameter metadata and value.
%
% Example
%   ssm = aws.ssm.Client();
%   resp = ssm.getParameter(name="/db/password", withDecryption=true);
%   disp(resp.value);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.name (1,1) string
    options.withDecryption (1,1) logical = false
end
builder = software.amazon.awssdk.services.ssm.model.GetParameterRequest.builder();
requestJ = aws.internal.builder.build(builder, options);
responseJ = obj.Handle.getParameter(requestJ);

response = aws.ssm.model.GetParameterResponse(responseJ);
end
