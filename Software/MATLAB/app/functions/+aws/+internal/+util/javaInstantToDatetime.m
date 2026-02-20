function dt = javaInstantToDatetime(jInstant)
% Convert java.time.Instant to MATLAB datetime (UTC).

% Copyright 2025 The MathWorks, Inc.

if isempty(jInstant)
    dt = NaT;
    return
end

% Use epoch milliseconds to avoid timezone issues
epochMilli = jInstant.toEpochMilli();     % returns long
dt = datetime(double(epochMilli)/1000, ...
    'ConvertFrom','posixtime', ...
    'TimeZone','UTC');
end