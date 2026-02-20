function plan = buildfile
% buildfile of the interface

% Copyright 2025 The MathWorks, Inc.

import matlab.buildtool.*;
import matlab.buildtool.tasks.*;

% Create a plan from task functions
plan = buildplan(localfunctions);

% Define default tasks
plan.DefaultTasks = ["check" "test"];

% Enable cleaning derived build outputs
plan("clean") = CleanTask;

% Add a task to identify code issues
plan("check") = CodeIssuesTask;


outputFolder = fullfile(pwd, "public");
plan("setup:outdir") = Task(Actions=@createOutDirTask, Outputs=outputFolder);

% Build the allow-list of coverage folders under app/, excluding **/+model under +aws/**
includedSources = coverageSourcesAllowList("app", ...
    ExcludeAwsRedshiftData=true, ...
    AdditionalExclusions=["thirdparty","public"]);
plan("test:run") = TestTask(...
    SourceFiles = includedSources, ...
    Tag=["AuthUnit", "Unit"], ...
    TestResults=[ ...
    fullfile(outputFolder,"test-reports","junit.xml"), ...
    fullfile(outputFolder,"test-reports","test-results.html"), ...
    fullfile(outputFolder,"test-reports","test-results.mat")], ...
    CodeCoverageResults=[ ...
    fullfile(outputFolder,"code-coverage","cobertura-coverage.xml"), ...
    fullfile(outputFolder,"code-coverage","coverage.html"), ...
    fullfile(outputFolder,"code-coverage","coverage.mat")]);

plan("test:badges:results") = Task(Actions=@processTestResults,...
    Inputs=plan("test:run").TestResults(3), ...
    Outputs=fullfile(outputFolder,"testBadge.svg"));

plan("test:badges:coverage") = Task(Actions=@processCoverageResults,...
    Inputs=plan("test:run").CodeCoverageResults(3), ...
    Outputs=[...
    fullfile(outputFolder,"code-coverage","standalone.html"), ...
    fullfile(outputFolder,"coverageBadge.svg")]);

% Make 'test' run everything
plan("test:run").Dependencies = "setup:outdir";
plan("test:badges:results").Dependencies  = ["test:run","setup:outdir"];
plan("test:badges:coverage").Dependencies = ["test:run","setup:outdir"];

plan("test").Description  = "Run all tests and generate test and coverage reports and badges";

end

function createOutDirTask(context)
% Create output folder for build reports
outputFolder = context.Task.Outputs.paths;
if ~exist(outputFolder, 'dir')
    [status, message] = mkdir(outputFolder);
    assert(status==1, message);
end
end

function processTestResults(context)
testResults = load(context.Task.Inputs.paths);
testResults = testResults.result;
disp(testResults);
generateTestBadge(testResults, context.Task.Outputs.paths);
end

function processCoverageResults(context)
coverageResults = load(context.Task.Inputs.paths);
coverageResults = coverageResults.coverage;
disp(coverageResults);
[~] = generateStandaloneReport(coverageResults, context.Task.Outputs(1).paths); % Suppress opening of report by assigning to [~]
generateCoverageBadge(coverageResults, context.Task.Outputs(2).paths);
end

function generateTestBadge(results,badgeFile)
% See https://shields.io/badges/static-badge
numPassed = sum([results.Passed]);
numFailed = sum([results.Failed]);
numIncomplete = sum([results.Incomplete]);
color = "brightgreen";
if (numIncomplete>0)
    color = "orange";
end
if (numFailed>0)
    color = "red";
end
badgeContent = sprintf("%s-%i/%i-%s", ...
    "Unit%20Test", numPassed, numPassed + numFailed + numIncomplete, color);
websave(badgeFile, sprintf("%s/%s", "https://img.shields.io/badge", badgeContent));
end

function generateCoverageBadge(results,badgeFile)
% See https://shields.io/badges/static-badge
statementCov = sum(coverageSummary(results,"statement"));
percentage = 100*statementCov(1)/statementCov(2);
color = "brightgreen";
if (percentage < 75)
    color = 'red';
elseif (percentage < 80)
    color = 'orange';
elseif (percentage < 85)
    color = 'yellow';
elseif (percentage < 90)
    color = 'yellowgreen';
elseif (percentage < 95)
    color = 'green';
end

badgeContent = sprintf("%s-%.2f%%25-%s", ...
    "Coverage", percentage, color);
url = sprintf("%s/%s", "https://img.shields.io/badge", badgeContent);
websave(badgeFile, url);
end

function user = getUsername
user = "unknown";
[result, output] = system("whoami");
if result ==0
    user = string(strip(output));
    user = replace(user, extractBefore(user, "/")+"/", "");
    user = replace(user, extractBefore(user, "\")+"\", "");
else
    disp("Could not find username. Using user ""unknown"". Output:")
    disp(output)
end
end

function url = linkify(url)
if matlab.internal.display.isHot
    url = "<a href=""" + url + """>" + url + "</a>";
end
end

function src = coverageSourcesAllowList(appRoot, varargin)
% Returns a string array of FILE paths for coverage (absolute paths).
% Includes *.m, *.mlx, *.mlapp under appRoot; excludes:
%   - appRoot/test/**
%   - any .../+aws/.../+model/**
%   - any .../+aws/+lambda/+task/**
%   - any .../aws/@Object/** and .../+aws/@Object/**
%   - AdditionalExclusions by segment name (e.g., "thirdparty", "public")
%
% Example:
%   src = coverageSourcesAllowList(pwd, ...
%       'ExcludeAwsRedshiftData', true, ...
%       'AdditionalExclusions', ["thirdparty","public"]);

opts = struct('ExcludeAwsRedshiftData', true, 'AdditionalExclusions', string.empty);
opts = parseOpts(opts, varargin{:});

appRoot = string(appRoot);
assert(isfolder(appRoot), "coverageSourcesAllowList:MissingApp", "App root '%s' not found.", appRoot);

% Absolute root (robust across OS)
[~, fa] = fileattrib(appRoot);
appAbs = string(fa.Name);

% Collect files
Dm   = dir(fullfile(appAbs, '**', '*.m'));
Dmlx = dir(fullfile(appAbs, '**', '*.mlx'));
Dapp = dir(fullfile(appAbs, '**', '*.mlapp'));

toPaths = @(D) string(fullfile({D.folder}', {D.name}'));
files = unique([toPaths(Dm); toPaths(Dmlx); toPaths(Dapp)]);

if isempty(files)
    src = strings(0,1);
    return
end

% Normalize to relative-with-forward-slashes for matching
rel  = erase(files, appAbs + filesep);
ps   = replace(rel, filesep, '/');  % e.g., 'a/b/c.m'

exAwsRedshift = false(size(ps));
if opts.ExcludeAwsRedshiftData
    % match /+aws/.../+model or ending with /+model
    exAwsRedshift = contains(ps, '/+aws/') & (contains(ps, '/+redshiftdata/') | contains(ps, '/+redshift'));
end

% ----------------------
% Built-in exclusions
% ----------------------

% Exclude root-level functions (folder or file)
% exFunctions = startsWith(ps, "functions/") | ps == "functions";

% Exclude root-level test (folder or file)
exTest = startsWith(ps, "test/") | ps == "test";

% Exclude +aws/+model subtree (package form)
% match /+aws/.../+model or ending with /+model
exAwsModel = contains(ps, '/+aws/') & (contains(ps, '/+model/') | endsWith(ps, '/+model'));

% Exclude aws.lambda.task.* (package path: +aws/+lambda/+task/**)
% Be robust to different placements (e.g., nested under components)
exAwsLambdaTask = contains(ps, '/+aws/+lambda/+task/') | endsWith(ps, '/+aws/+lambda/+task');

% Exclude all files in aws/@Object and +aws/@Object (class folder)
% Handle both non-package (aws/@Object) and package (+aws/@Object)
exAwsAtObject = ...
      contains(ps, '/aws/@Object/')       | endsWith(ps, '/aws/@Object') ...
   |  contains(ps, '/+aws/@Object/')      | endsWith(ps, '/+aws/@Object');

% Exclude AdditionalExclusions by segment name
exExtra = false(size(ps));
for name = string(opts.AdditionalExclusions(:))'
    if strlength(name)==0, continue; end
    % Exclude if the path contains '/<name>/' as a segment, or ends with '/<name>', or equals '<name>'
    exExtra = exExtra ...
        | contains("/" + ps + "/", "/" + name + "/") ...
        | endsWith(ps, "/" + name) ...
        | (ps == name);
end

keep = ~(exTest | exAwsModel | exAwsLambdaTask | exAwsAtObject | exExtra | exAwsRedshift);
src  = files(keep);
end

function allDirs = listAllSubfolders(root)
root = string(root);
S = dir(root);
dirs = strings(0,1);

for k = 1:numel(S)
    if S(k).isdir && S(k).name ~= "." && S(k).name ~= ".."
        this = string(fullfile(S(k).folder, S(k).name));
        dirs(end+1,1) = this; %#ok<AGROW>
        dirs = [dirs; listAllSubfolders(this)]; %#ok<AGROW>
    end
end
allDirs = dirs;
end

function out = parseOpts(defaults, varargin)
out = defaults;
if rem(numel(varargin),2) ~= 0
    error("Options must be name-value pairs.");
end
for idx = 1:2:numel(varargin)
    name = varargin{idx};
    val  = varargin{idx+1};
    if ~isfield(out, name)
        error("Unknown option: %s", name);
    end
    out.(name) = val;
end
end