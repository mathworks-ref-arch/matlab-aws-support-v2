function response = deleteLexicon(obj, options)
% DELETELEXICON Remove a stored Amazon Polly lexicon.
%
% Syntax
%   resp = polly.deleteLexicon(name="medicalTerms");
%
% Name-Value Arguments
%   name - (string, required) Lexicon identifier to delete.
%
% Returns
%   response - aws.polly.model.DeleteLexiconResponse (request metadata).
%
% Example
%   resp = polly.deleteLexicon(name="medicalTerms");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.name (1,1) string {mustBeTextScalar, mustBeNonempty}
end

builder = software.amazon.awssdk.services.polly.model.DeleteLexiconRequest.builder();
requestJ = aws.internal.builder.build(builder, options);
responseJ = obj.Handle.deleteLexicon(requestJ);

response = aws.polly.model.DeleteLexiconResponse(responseJ);
end
