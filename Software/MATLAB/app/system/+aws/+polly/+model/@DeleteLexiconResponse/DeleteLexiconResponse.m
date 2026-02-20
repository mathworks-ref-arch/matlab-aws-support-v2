classdef DeleteLexiconResponse < aws.Object
    %DELETELEXICONRESPONSE Response from Polly deleteLexicon API.
    %
    % Properties
    %   status - (string) Service-reported operation status (e.g., "OK").
    %
    % Example
    %   polly = aws.polly.Client();
    %   resp  = polly.deleteLexicon(lexiconName="MyLex");
    %   disp(resp.status)

    % Copyright 2025 The MathWorks, Inc.

    properties
        status string
    end
    methods
        function obj = DeleteLexiconResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.polly.model.DeleteLexiconResponse')
                obj.Handle = varargin{1};
                obj.status = "Success"; % Polly does not return any fields for deleteLexicon

            end
        end
    end
end