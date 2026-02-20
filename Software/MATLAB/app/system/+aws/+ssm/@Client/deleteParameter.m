function response = deleteParameter(obj, options)
% DELETEPARAMETER Remove a Systems Manager parameter.
%
% Syntax
%   resp = ssm.deleteParameter(name="/app/config");
%
% Name-Value Arguments
%   name - (string, required) Fully-qualified parameter name.
%
% Returns
%   aws.ssm.model.DeleteParameterResponse indicating success.
%
% Example
%   ssm = aws.ssm.Client();
%   ssm.deleteParameter(name="/apps/acme/config");

% Copyright 2025 The MathWorks, Inc.
arguments
    obj
    options.name (1,1) string
end
builder = software.amazon.awssdk.services.ssm.model.DeleteParameterRequest.builder();
requestJ = aws.internal.builder.build(builder, options);
responseJ = obj.Handle.deleteParameter(requestJ);

response = aws.ssm.model.DeleteParameterResponse(responseJ);
end
