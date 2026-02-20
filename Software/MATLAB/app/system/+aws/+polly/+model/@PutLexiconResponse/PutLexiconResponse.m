classdef PutLexiconResponse < aws.Object
    %PUTLEXICONRESPONSE Response from Polly putLexicon API.
    %
    % Properties
    %   status - (string) Service-reported operation status (e.g., "OK").
    %
    % Example
    %   polly = aws.polly.Client();
    %   resp  = polly.putLexicon(lexiconName="MyLex", content="<lexicon .../>");
    %   disp(resp.status)

    % Copyright 2025 The MathWorks, Inc

    properties
        status string
    end
    methods
        function obj = PutLexiconResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.polly.model.PutLexiconResponse')
                obj.Handle = varargin{1};
                obj.status = "Success"; % Polly does not return any fields for putLexicon

            end
        end
    end
end