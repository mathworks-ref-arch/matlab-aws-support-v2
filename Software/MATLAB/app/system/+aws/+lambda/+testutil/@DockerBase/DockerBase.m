classdef (Abstract) DockerBase < matlab.unittest.TestCase
    % DOCKERBASE Base test fixture for Lambda Docker images.
    %
    % Syntax
    %   classdef MyDockerTest < aws.lambda.testutil.DockerBase
    %       properties
    %           imageName = "my-lambda-image";
    %       end
    %       methods (Test)
    %           function invokeEndpoint(testCase)
    %               webread("http://" + testCase.host + ":" + testCase.port + "/2015-03-31/functions/function/invocations");
    %           end
    %       end
    %   end
    %
    % Description
    %   Starts a container from `imageName` in `TestClassSetup`, maps port 8080
    %   to a random host port, and exposes `host`/`port` to derived tests. The
    %   container is automatically stopped in `TestClassTeardown`.

    % Copyright 2025 The MathWorks, Inc

    properties (Abstract)
        imageName
    end
    properties (Access=protected)
        dockerId
        port
        host
    end
    methods (TestClassSetup)
        function startContainer(testCase)
            % Start the container
            testCase.log(1,"Starting container...");
            [s,id] = system(sprintf('docker run --rm -d -p :8080 %s', testCase.imageName));
            testCase.assertEqual(s,0);
            testCase.dockerId = strip(id,newline);

            % Determine the port
            [s,p] = system(sprintf('docker container port %s 8080/tcp',testCase.dockerId));
            testCase.assertEqual(s,0);
            p = regexp(p,'0.0.0.0:(\d*)','tokens','once');
            testCase.port = p{1};
            testCase.log(1,sprintf('Container is running on port %s',testCase.port));

            % Set the host
            testCase.host = getenvd("DOCKERHOST","localhost");
        end
    end
    methods (TestClassTeardown)
        function stopContainer(testCase)
            testCase.log(1,'Stopping container...');
            if ~isempty(testCase.dockerId)
                system(sprintf('docker stop %s',testCase.dockerId));
            end
            testCase.log(1,'Container stopped.');
        end
    end
end

function val = getenvd(var,val)
% GETENVD getenv with default value
%
%   Returns the value of the specified environment variable if it is
%   set, returns the specified default value instead.
if isenv(var)
    val = getenv(var);
end
end
