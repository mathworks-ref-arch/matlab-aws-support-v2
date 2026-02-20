function response = describeVoices(obj, options)
% DESCRIBEVOICES List available Amazon Polly voices.
%
% Syntax
%   resp = polly.describeVoices(languageCode="en-US");
%
% Name-Value Arguments
%   languageCode                   - (string) Filter results by locale (e.g., "en-US").
%   engine                         - (string) Voice engine ("standard","neural","long-form","generative").
%   nextToken                      - (string) Pagination token from a previous response.
%   includeAdditionalLanguageCodes - (logical) When true, include voices that support other languages.
%
% Returns
%   response - aws.polly.model.DescribeVoicesResponse containing the voice list.
%
% Example
%   resp = polly.describeVoices(languageCode="en-US", engine="neural");

% Copyright 2025 The MathWorks, Inc.


arguments
    obj
    options.languageCode (1,1) string {mustBePollyLanguageCode}
    options.engine (1,1) string {mustBeMember(options.engine, ["standard", "neural", "long-form", "generative"])} = "standard"
    options.nextToken (1,1) string
    options.includeAdditionalLanguageCodes (1,1) logical
end

describeVoicesBuilder = software.amazon.awssdk.services.polly.model.DescribeVoicesRequest.builder();
describeVoicesReq = aws.internal.builder.build(describeVoicesBuilder, options);

responseJ = obj.Handle.describeVoices(describeVoicesReq);
response = aws.polly.model.DescribeVoicesResponse(responseJ);

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
