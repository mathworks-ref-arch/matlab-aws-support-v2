function response = createDocument(obj, options)
% CREATEDOCUMENT Create a Systems Manager document.
%
% Syntax
%   resp = ssm.createDocument(content=docJson, name="MyDoc", documentType="Command");
%   resp = ssm.createDocument(content=docYaml, name="MyDoc", ...
%       documentType="Automation", documentFormat="YAML");
%
% Name-Value Arguments
%   content        - (string, required) JSON or YAML payload for the document body.
%   name           - (string, required) Friendly document name (1-128 chars).
%   documentType   - (string, required) One of "Command", "Policy", "Automation",
%                    "Session", "Package", "ApplicationConfiguration",
%                    "ApplicationConfigurationSchema", "DeploymentStrategy",
%                    or "ChangeCalendar".
%   documentFormat - (string) "JSON" (default) or "YAML".
%
% Returns
%   aws.ssm.model.CreateDocumentResponse containing the created document metadata.
%
% Example
%   ssm = aws.ssm.Client();
%   resp = ssm.createDocument(content=fileread("maintenance.json"), ...
%       name="NightlyMaintenance", documentType="Command");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.content (1,1) string
    options.name (1,1) string
    options.documentType (1,1) string {mustBeMember(options.documentType, ["Command","Policy","Automation","Session","Package","ApplicationConfiguration","ApplicationConfigurationSchema","DeploymentStrategy","ChangeCalendar"])}
    options.documentFormat (1,1) string {mustBeMember(options.documentFormat, ["JSON","YAML"])} = "JSON"
end
builder = software.amazon.awssdk.services.ssm.model.CreateDocumentRequest.builder();
requestJ = aws.internal.builder.build(builder, options);
responseJ = obj.Handle.createDocument(requestJ);

response = aws.ssm.model.CreateDocumentResponse(responseJ);
end
