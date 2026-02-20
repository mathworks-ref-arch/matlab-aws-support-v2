function [filteredSignal, HRV] = processSignal(Fs)
% processSignal - Processes a physiological signal to filter noise and calculate HRV.
%
% Syntax: [filteredSignal, HRV] = processSignal(Fs)
%
% Inputs:
%   Fs - Sampling frequency of the signal in Hz.
%
% Outputs:
%   filteredSignal - The filtered version of the input signal.
%   HRV - Calculated heart rate variability (standard deviation of peak intervals).

% Copyright 2025 The MathWorks, Inc.

%   rawSignal - A vector containing the raw physiological signal data.
time = 0:0.01:10; % 10 seconds of data at 100 Hz
rawSignal = sin(2 * pi * 1 * time) + 0.5 * randn(size(time)); % Simulated signal

% Define filter parameters
Fc = 2; % Cut-off frequency for low-pass filter
[b, a] = butter(6, Fc/(Fs/2), 'low'); % 6th order Butterworth filter

% Apply the filter to the raw signal
filteredSignal = filtfilt(b, a, rawSignal);

% Find peaks in the filtered signal
[~, locs] = findpeaks(filteredSignal);

% Calculate HRV as the standard deviation of the intervals between peaks
HRV = std(diff(locs)) * (1/Fs); % Convert to seconds

end