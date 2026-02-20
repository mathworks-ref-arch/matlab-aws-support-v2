function response = putParameter(obj, options)
% PUTPARAMETER Create or update a Systems Manager parameter.
%
% Syntax
%   resp = ssm.putParameter(name="/myparam", value="foo");
%   resp = ssm.putParameter(name="/secure/password", value="secret", ...
%       type="SecureString", overwrite=true);
%
% Name-Value Arguments
%   name      - (string, required) Parameter path or name.
%   value     - (string, required) Value to store (plain text unless SecureString).
%   type      - (string) "String" (default), "StringList", or "SecureString".
%   overwrite - (logical) Allow replacing existing values (default false).
%
% Returns
%   aws.ssm.model.PutParameterResponse with the new parameter version.
%
% Example
%   ssm = aws.ssm.Client();
%   resp = ssm.putParameter(name="/db/password", value="s3cret", ...
%       type="SecureString", overwrite=true);

% Copyright 2025 The MathWorks, Inc.
arguments
    obj
    options.name (1,1) string
    options.value (1,1) string
    options.type (1,1) string {mustBeMember(options.type, ["String","StringList","SecureString"])} = "String"
    options.overwrite (1,1) logical = false
end
builder = software.amazon.awssdk.services.ssm.model.PutParameterRequest.builder();
requestJ = aws.internal.builder.build(builder, options);
responseJ = obj.Handle.putParameter(requestJ);
response = aws.ssm.model.PutParameterResponse(responseJ);
end
