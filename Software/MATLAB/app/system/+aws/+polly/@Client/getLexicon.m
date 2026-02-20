function response = getLexicon(obj, options)
% GETLEXICON Retrieve a stored lexicon definition.
%
% Syntax
%   resp = polly.getLexicon(name="medicalTerms");
%
% Name-Value Arguments
%   name - (string, required) Lexicon identifier.
%
% Returns
%   response - aws.polly.model.GetLexiconResponse containing the lexicon content.
%
% Example
%   resp = polly.getLexicon(name="medicalTerms");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.name (1,1) string {mustBeTextScalar, mustBeNonempty}
end

getLexiconBuilder = software.amazon.awssdk.services.polly.model.GetLexiconRequest.builder();
requestJ = aws.internal.builder.build(getLexiconBuilder, options);
responseJ = obj.Handle.getLexicon(requestJ);

response = aws.polly.model.GetLexiconResponse(responseJ);
end
