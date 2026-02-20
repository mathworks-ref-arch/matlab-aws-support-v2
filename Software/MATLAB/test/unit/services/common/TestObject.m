classdef TestObject < matlab.unittest.TestCase
    % TESTOBJECT This is a test stub for a unit testing
    % The assertions that can be used in test cases:
    %
    %    assertTrue
    %    assertFalse
    %    assertEqual
    %    assertFilesEqual
    %    assertElementsAlmostEqual
    %    assertVectorsAlmostEqual
    %    assertExceptionThrown
    %
    %   A more detailed explanation goes here.
    %
    % Notes:

    % Copyright 2025 The MathWorks, Inc.

    methods (Test, TestTags = {'Unit'})
        function testConstructor(testCase)
            myobj = aws.Object();
            testCase.verifyClass(myobj,'aws.Object');
        end
    end
end
