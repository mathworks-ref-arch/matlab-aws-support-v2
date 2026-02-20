function response = synthesizeSpeech(obj, options)
% SYNTHESIZESPEECH Convert text to speech (audio bytes or speech marks).
%
% Syntax
%   resp = polly.synthesizeSpeech(text="Hello world.", voiceId="Joanna");
%   resp = polly.synthesizeSpeech(text="Hello", voiceId="Joanna", ...
%                                 outputFormat="json", speechMarkTypesWithStrings="word");
%
% Name-Value Arguments
%   text                      - (string, required) Text or SSML payload to synthesize.
%   voiceId                   - (string, required) Voice identifier (e.g., "Joanna").
%   outputFormat              - (string) `"mp3"`, `"ogg_vorbis"`, `"pcm"`, or `"json"` (default `"mp3"`).
%   engine                    - (string) `"standard"`, `"neural"`, `"long-form"`, or `"generative"` (default `"standard"`).
%   languageCode              - (string) Override locale when supported.
%   sampleRate                - (string) Sample rate such as `"16000"` (optional, format dependent).
%   textType                  - (string) `"text"` or `"ssml"` (default `"text"`).
%   speechMarkTypesWithStrings- (string array) Speech mark types when `outputFormat="json"`.
%   lexiconNames              - (string array) Lexicon names that should be applied.
%
% Returns
%   response - aws.polly.model.SynthesizeSpeechResponse containing the audio bytes
%              (`audioStream`), the response content type, and character usage.
%
% Example
%   resp = polly.synthesizeSpeech(text="Hello from MATLAB", voiceId="Joanna");
%   fid = fopen("hello.mp3","w");
%   fwrite(fid, resp.audioStream, 'uint8');
%   fclose(fid);

% Copyright 2025 The MathWorks, Inc.


arguments
    obj
    options.text (1,1) string
    options.voiceId (1,1) string
    options.outputFormat (1,1) string {mustBeMember(options.outputFormat, ["mp3","ogg_vorbis","pcm","json"])} = "mp3"
    options.engine (1,1) string {mustBeMember(options.engine, ["standard", "neural", "long-form", "generative"])} = "standard"
    options.languageCode (1,1) string {mustBePollyLanguageCode}
    options.sampleRate (1,1) string {mustBeValidSampleRate} % e.g. "8000", "16000", "22050", "24000"
    options.textType (1,1) string {mustBeMember(options.textType, ["text","ssml"])} = "text"
    options.speechMarkTypesWithStrings (1,:) string = string.empty(1,0)  % e.g. ["sentence","word"]
    options.lexiconNames (1,:) string = string.empty(1,0)
end

synthesizeSpeechReqBuilder = software.amazon.awssdk.services.polly.model.SynthesizeSpeechRequest.builder();
synthesizeSpeechReq = aws.internal.builder.build(synthesizeSpeechReqBuilder, options);

responseJ = obj.Handle.synthesizeSpeech(synthesizeSpeechReq);
response = aws.polly.model.SynthesizeSpeechResponse(responseJ);

end

function mustBeValidSampleRate(sampleRate)
% mustBeValidSampleRate - validates that sampleRate is a string of 4 or 5 digits or empty

if strlength(sampleRate) == 0
    return; % Empty is allowed (means use AWS default)
end

if isempty(regexp(sampleRate, '^\d{4,5}$', 'once'))
    error('AWS:Polly:InvalidSampleRate', ...
        'sampleRate "%s" must be a string of 4 or 5 digits (e.g., "8000", "16000", "22050", "24000").', ...
        sampleRate);
end
end


function mustBePollyLanguageCode(input)
% Allow empty string (no language filtering)
if strlength(input) == 0
    return
end

% List of valid language codes for AWS Polly (case- and hyphen-accurate)
validCodes = [
    "ar-AE"
    "arb"
    "ca-ES"
    "cmn-CN"
    "cs-CZ"
    "cy-GB"
    "da-DK"
    "de-AT"
    "de-CH"
    "de-DE"
    "en-AU"
    "en-GB"
    "en-GB-WLS"
    "en-IE"
    "en-IN"
    "en-NZ"
    "en-SG"
    "en-US"
    "en-ZA"
    "es-ES"
    "es-MX"
    "es-US"
    "fi-FI"
    "fr-BE"
    "fr-CA"
    "fr-FR"
    "hi-IN"
    "is-IS"
    "it-IT"
    "ja-JP"
    "ko-KR"
    "nb-NO"
    "nl-BE"
    "nl-NL"
    "pl-PL"
    "pt-BR"
    "pt-PT"
    "ro-RO"
    "ru-RU"
    "sv-SE"
    "tr-TR"
    "yue-CN"
    ];

% Normalize input: lower-case, replace underscores with hyphens
normalized = strrep(input, "_", "-");

% Polly codes are case-sensitive, but AWS SDK is case-insensitive.
% We'll check against validCodes for exact match.
if ~ismember(normalized, validCodes)
    error(['languageCode must be empty or one of the standard Polly language codes (e.g. "en-US", "fr-FR"). ', ...
        'You provided "' input '".']);
end
end
