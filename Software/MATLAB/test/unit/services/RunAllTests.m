function testResults = RunAllTests()
% Entry point for running all tests in the test suite.
% This is used by the CI/CD system to run all tests in the folder and generate the appropriate output.

% Copyright 2025 The MathWorks, Inc.

% Get all the test cases from this folder
testSuite = matlab.unittest.TestSuite.fromFolder(pwd, 'IncludingSubfolders', true);

% Generate a runner with the appropriate plugins
import matlab.unittest.plugins.XMLPlugin

% Create a minimal test runner
runner = testrunner("textoutput");
filename = awsRoot("results.xml");

% Configure the JUnit format plugin
plugin = XMLPlugin.producingJUnitFormat(filename);
addPlugin(runner,plugin);

% Run the tests
testResults = run(runner, testSuite);

end
