classdef Voice < aws.Object
    %VOICE Polly voice description.
    %
    % Properties
    %   id               - (string) Voice identifier (e.g., "Joanna").
    %   name             - (string) Display name of the voice.
    %   languageCode     - (string) BCP-47 language tag (e.g., "en-US").
    %   languageName     - (string) Human-readable language name.
    %   gender           - (string) Gender metadata (e.g., "Female").
    %   supportedEngines - (string) Supported engines (e.g., "standard, neural").
    %
    % Example
    %   polly = aws.polly.Client();
    %   resp  = polly.describeVoices();
    %   v     = resp.voices(1);
    %   disp([v.id, " - ", v.languageCode])

    % Copyright 2025 The MathWorks, Inc.

    properties
        id string
        name string
        languageCode string
        languageName string
        gender string
        supportedEngines string
    end

    methods
        function obj = Voice(varargin)
            if nargin == 1 && isa(varargin{1}, 'software.amazon.awssdk.services.polly.model.Voice')
                obj.Handle = varargin{1};
                obj.id = obj.Handle.idAsString();
                obj.name = obj.Handle.name();
                obj.languageCode = obj.Handle.languageCodeAsString();
                obj.languageName = obj.Handle.languageName();
                obj.gender = obj.Handle.genderAsString();
                % Convert Java List<String> to MATLAB string array
                enginesJ = obj.Handle.supportedEnginesAsStrings();
                n = enginesJ.size();
                engines = strings(1, n);
                for index = 1:n
                    engines(index) = string(enginesJ.get(index-1));
                end
                obj.supportedEngines = engines;
            else
                write(obj.logObj,'error','Invalid argument for Voice');
            end
        end
    end
end