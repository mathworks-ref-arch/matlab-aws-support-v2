classdef SynthesizeSpeechResponse < aws.Object
    %SYNTHESIZESPEECHRESPONSE Response from Polly synthesizeSpeech API.
    %
    % Properties
    %   audioStream      - (uint8[] | stream) Binary audio data.
    %   contentType      - (string) MIME type of the audio (e.g., "audio/mpeg").
    %   requestCharacters - (int32) Number of billed/request characters.
    %
    % Example
    %   polly = aws.polly.Client();
    %   resp  = polly.synthesizeSpeech(text="Hello", voiceId="Joanna", outputFormat="mp3");
    %   audiowrite("hello.mp3", decodeMp3(resp.audioStream), 24000); % example placeholder

    % Copyright 2025 The MathWorks, Inc

    properties
        audioStream
        contentType string
        requestCharacters int32
    end

    methods
        function obj = SynthesizeSpeechResponse(varargin)
            if nargin == 1 && isa(varargin{1}, 'software.amazon.awssdk.core.ResponseInputStream')
                obj.Handle = varargin{1};

                % This returns a signed int8 Java array:
                bytes = org.apache.commons.io.IOUtils.toByteArray(obj.Handle);
                obj.audioStream = typecast(bytes, 'uint8');
                synthesizeSpeechResponse = obj.Handle.response();

                if isa(synthesizeSpeechResponse, 'software.amazon.awssdk.services.polly.model.SynthesizeSpeechResponse')

                    obj.contentType = string(synthesizeSpeechResponse.contentType());
                    obj.requestCharacters = synthesizeSpeechResponse.requestCharacters().intValue();

                end
            else
                write(obj.logObj,'error','Invalid argument for SynthesizeSpeechResponse');
            end
        end

    end
end