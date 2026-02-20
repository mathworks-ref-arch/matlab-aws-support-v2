function response = deleteDocument(obj, options)
% DELETEDOCUMENT Remove a Systems Manager document.
%
% Syntax
%   resp = ssm.deleteDocument(name="MyDoc");
%
% Name-Value Arguments
%   name - (string, required) Name of the SSM document to delete.
%
% Returns
%   aws.ssm.model.DeleteDocumentResponse indicating the delete status.
%
% Example
%   ssm = aws.ssm.Client();
%   ssm.deleteDocument(name="NightlyMaintenance");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.name (1,1) string
end
builder = software.amazon.awssdk.services.ssm.model.DeleteDocumentRequest.builder();
requestJ = aws.internal.builder.build(builder, options);
responseJ = obj.Handle.deleteDocument(requestJ);

response = aws.ssm.model.DeleteDocumentResponse(responseJ);
end
