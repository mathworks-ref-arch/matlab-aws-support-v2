function rootStr = awsRoot(varargin)
% AWSROOT Function to locate the installation folder for the tooling
% awsRoot alone will return the root for the MATLAB code in the project.
%
% awsRoot with additional arguments will add these to the path
%
%  funDir = awsRoot('app', 'functions')
%
%  The special argument of a negative number will move up folders, e.g.
%  the following call will move up two folders, and then into
%  Documentation.
%
%  docDir = awsRoot(-2, 'Documentation')

% Copyright 2025 The MathWorks, Inc.

rootStr = fileparts(fileparts(fileparts(mfilename('fullpath'))));

for k=1:nargin
    arg = varargin{k};
    if isStringScalar(arg) || ischar(arg)
        rootStr = fullfile(rootStr, arg);
    elseif isnumeric(arg) && arg < 0
        for levels = 1:abs(arg)
            rootStr = fileparts(rootStr);
        end
    else
        error('AWS:awsroot_bad_argument', ...
            'Bad argument for awsRoot');
    end
end

end %function
