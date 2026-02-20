classdef testDocker < aws.lambda.testutil.DockerBase
    properties
        imageName = "matlab-awslambda-example"
    end
    methods (Test)
        function testInvoke(testCase)
            % Make the call
            req = matlab.net.http.RequestMessage( ...
                matlab.net.http.RequestMethod.POST, ...
                matlab.net.http.field.ContentTypeField("application/json"), ...
                struct('x',21) ...
            );
            res = req.send(sprintf("http://%s:%s/2015-03-31/functions/function/invocations",testCase.host,testCase.port));
            testCase.verifyEqual(res.StatusCode,matlab.net.http.StatusCode.OK);
            data = jsondecode(res.Body.Data);
            testCase.verifyEqual(data.y,42.0);
        end
    end
end
