classdef DescribeVoicesResponse < aws.Object
    %DESCRIBEVOICESRESPONSE Response from Polly DescribeVoices API.
    %
    % Properties
    %   voices    - (aws.polly.model.Voice[]) Array of available voices.
    %   nextToken - (string) Pagination token for retrieving additional results.
    %
    % Example
    %   polly = aws.polly.Client();
    %   resp  = polly.describeVoices();
    %   disp([resp.voices.name])

    % Copyright 2025 The MathWorks, Inc.

    properties
        voices aws.polly.model.Voice = aws.polly.model.Voice.empty(0,1)
        nextToken string
    end

    methods
        function obj = DescribeVoicesResponse(varargin)

            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.polly.model.DescribeVoicesResponse')
                obj.Handle = varargin{1};

                % Extract voices from the Java response
                voiceListJ = obj.Handle.voices();
                totalVoiceCount = voiceListJ.size();
                voiceListIterator = voiceListJ.iterator;
                obj.voices = aws.polly.model.Voice.empty(totalVoiceCount,0);

                index = 1;
                while voiceListIterator.hasNext()
                    voiceJ = voiceListIterator.next();
                    voiceObj = aws.polly.model.Voice(voiceJ);
                    obj.voices(index) = voiceObj;
                    index = index + 1;
                end
                obj.nextToken = obj.Handle.nextToken();

            else
                write(obj.logObj, 'error', 'Invalid arguments');
                error('AWS:Polly:InvalidInput', 'Invalid arguments for DescribeVoicesResponse');
            end
        end
    end
end