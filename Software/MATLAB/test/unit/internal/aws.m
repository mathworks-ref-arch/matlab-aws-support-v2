function [status, out] = aws(varargin)
% Mocked aws() for tests that call aws directly (not the real wrapper call to system).
% Supports:
%   aws('s3api','list-buckets' [, '--output', 'json'|'text'])
%   aws('sts','get-session-token','--token-code', token, '--serial-number', arn)

% Copyright 2025 The MathWorks, Inc.

args = string(varargin);
status = 0;
out = [];

% Helper: case-insensitive equality
eqi = @(a,b) strcmpi(a,b);

% ---- Parse optional --output flag ----
outFormat = 'json';  % simulate CLI default (json)
for k = 1:numel(args)-1
    if eqi(args(k), '--output')
        outFormat = lower(args(k+1));
        break;
    end
end

% ---- s3api list-buckets ----
if numel(args) >= 2 && eqi(args(1), 's3api') && eqi(args(2), 'list-buckets')
    switch outFormat
        case 'text'
            % Simulate simple text output of bucket names
            out = sprintf('b1\nb2\n');
        otherwise
            % Simulate decoded JSON (struct) a caller would expect from your wrapper
            out = struct( ...
                'Owner', struct('DisplayName','alice'), ...
                'Buckets', struct('Name', {'b1','b2'}) );
    end
    return;
end

% ---- sts get-session-token (handy for writeSTSCredentialsFile tests) ----
if numel(args) >= 2 && eqi(args(1), 'sts') && eqi(args(2), 'get-session-token')
    out = struct( ...
        'Credentials', struct( ...
        'AccessKeyId',     'ASIAEXAMPLEACCESS', ...
        'SecretAccessKey', 'wJalrXUtnFEMI/K7MDENG+bPxRfiCYEXAMPLEKEY', ...
        'SessionToken',    'AQoDYXdzEJr...<token>...EXAMPLETOKEN', ...
        'Expiration',      '2030-01-01T00:00:00Z'));
    return;
end

% ---- Unknown command: make it fail so tests can detect unsupported paths ----
status = 1;
out = struct('message', 'Unsupported mock command');
end