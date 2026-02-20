function [str] = awsCommonRoot(varargin)
% AWSCOMMONROOT Helper function to locate the AWS Common location
% Locate the installation of the AWS interface package to allow easier construction
% of absolute paths to the required dependencies.

% Copyright 2025 The MathWorks, Inc.

str = fileparts(fileparts(fileparts(mfilename('fullpath'))));

end %function