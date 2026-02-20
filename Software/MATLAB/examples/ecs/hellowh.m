function response = mpsInfoWebHandler(request)
%% MPSINFOWEBHANDLER - is a Web Request Handler for HTTP calls.
% This function returns the version of MATLAB as below :
% {
%     "description": "This is the "/info" endpoint of MATLAB Production Server™.",
%     "creation_time": "0",
%     "server_version": "Release Version",
%     "name": "MATLAB Production Server™",
%      …
% }
%
% The purpose of this Web Handler is to expose an URL with '/info' that is
% configured in the routes.json that is configured at $MPS_INSTALL/config
% or at the archive level (since MATLAB version R2023b).

% Copyright 2025 The MathWorks, Inc.

disp(request);
disp('request.Headers:');
disp(request.Headers);
bodyText = char(request.Body);
disp('request.Body:');

% Prints first 100 characters of the request
if length(bodyText) > 100
    disp(bodyText(1:100));
    disp('...');
else
    disp(bodyText);
end

% Parse the request body using jsondecode
try
    parsedData = jsondecode(bodyText);
catch
    disp('Failed to parse JSON. Sending error response.');
    response = struct('ApiVersion', [1 0 0], ...
        'HttpCode', 400, ...
        'HttpMessage', 'Bad Request', ...
        'Headers', {{ ...
        'Server' 'MATLAB Production Server'; ...
        'Content-Type' 'application/JSON'; ...
        }},...
        'Body', unicode2native('{"error": "Invalid JSON"}', 'UTF-8'));
    return;
end

% Construct the data structure for the response
data = struct(...
    'description', 'This is the "/info" endpoint of MATLAB Production Server™ for Tableau Analytics Extensions.', ...
    'creation_time', '0', ...
    'server_version', version('-release'), ...
    'name', 'MATLAB Production Server™', ...
    'parsed_request', parsedData);  % Include parsed fields in the response

dataString = jsonencode(data);

% Construct a HTTP 200 response with a 'text/json' response body.
response = struct('ApiVersion', [1 0 0], ...
    'HttpCode', 200, ...
    'HttpMessage', 'OK', ...
    'Headers', {{ ...
    'Server' 'MATLAB Production Server'; ...
    'Content-Type' 'application/JSON'; ...
    }},...
    'Body', unicode2native(dataString,'UTF-8'));

disp(response);
disp('response.Headers:');
disp(response.Headers);

end