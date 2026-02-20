function varargout = aws(varargin)
% AWS Wrapper for AWS CLI
%
% Assumes AWS CLI is installed and configured with authentication details.
% Allows execution of AWS CLI commands from MATLAB.
%
% Examples:
%   aws('s3api list-buckets')
%   aws s3api list-buckets
%
% With output:
%   [status, output] = aws('s3api','list-buckets');
%
% By default, JSON output is decoded into a MATLAB struct.
% If --output [text|table] is specified, output is returned as char.

% Copyright 2025 The MathWorks, Inc.

cliCmd = 'aws';
ldPath = getenv('LD_LIBRARY_PATH');

try
    if nargout == 0
        echoFlag = '-echo';
    else
        echoFlag = '';
    end

    [varargout{1}, varargout{2}] = system([cliCmd,' ',strjoin(varargin)], echoFlag);

    splitargs = strsplit(strjoin(varargin));
    if length(splitargs) > 1
        if strcmpi(splitargs{end-1}, '--output')
            if strcmpi(splitargs{end}, 'json') && nargout == 2
                varargout{2} = jsondecode(varargout{2});
            end
        else
            if nargout == 2
                varargout{2} = jsondecode(varargout{2});
            end
        end
    end
catch ME
    setenv('LD_LIBRARY_PATH', ldPath);
    rethrow(ME);
end
end