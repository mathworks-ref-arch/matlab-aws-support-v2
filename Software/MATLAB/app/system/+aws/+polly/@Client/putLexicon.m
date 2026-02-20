function response = putLexicon(obj, options)
% PUTLEXICON Upload or update an Amazon Polly lexicon.
%
% Syntax
%   resp = polly.putLexicon(name="medicalTerms", content=lexiconXml);
%
% Name-Value Arguments
%   name    - (string, required) Lexicon identifier.
%   content - (string, required) Lexicon XML payload.
%
% Returns
%   response - aws.polly.model.PutLexiconResponse with request metadata.
%
% Example
%   xml = fileread("medicalTerms.pls");
%   resp = polly.putLexicon(name="medicalTerms", content=xml);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.name (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.content (1,1) string {mustBeTextScalar, mustBeNonempty}
end

builder = software.amazon.awssdk.services.polly.model.PutLexiconRequest.builder();
requestJ = aws.internal.builder.build(builder, options);
responseJ = obj.Handle.putLexicon(requestJ);

response = aws.polly.model.PutLexiconResponse(responseJ);
end
