classdef GetLexiconResponse < aws.Object
    %GETLEXICONRESPONSE Response from Polly getLexicon API.
    %
    % Properties
    %   lexiconName    - (string) The lexicon identifier.
    %   lexiconContent - (string) The lexicon XML content.
    %
    % Example
    %   polly = aws.polly.Client();
    %   resp  = polly.getLexicon(lexiconName="MyLex");
    %   disp(resp.lexiconName)

    % Copyright 2025 The MathWorks, Inc.

    properties
        lexiconName string
        lexiconContent string
    end
    methods
        function obj = GetLexiconResponse(varargin)

            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.polly.model.GetLexiconResponse')
                obj.Handle = varargin{1};
                lexiconJ = obj.Handle.lexicon();
                obj.lexiconName = string(lexiconJ.name());
                obj.lexiconContent = string(lexiconJ.content());

            else
                write(obj.logObj, 'error', 'Invalid arguments');
                error('AWS:Polly:InvalidInput', 'Invalid arguments for GetLexiconResponse');
            end
        end
    end
end