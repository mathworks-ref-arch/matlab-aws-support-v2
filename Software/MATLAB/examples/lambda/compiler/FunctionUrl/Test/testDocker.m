classdef testDocker < aws.lambda.testutil.DockerBase
    properties
        imageName = "matlab-awslambda-functionurl-example"
    end
    methods (Test)
        function testSuccessfulInvoke(testCase)
            % Make the call
            req = matlab.net.http.RequestMessage( ...
                matlab.net.http.RequestMethod.POST, ...
                matlab.net.http.field.ContentTypeField("application/json"), ...
                struct('body',jsonencode(struct('a',21.0,'b',21.0))) ...
            );
            res = req.send(sprintf("http://%s:%s/2015-03-31/functions/function/invocations",testCase.host,testCase.port));
            testCase.verifyEqual(res.StatusCode,matlab.net.http.StatusCode.OK);
            data = jsondecode(res.Body.Data);
            testCase.verifyEqual(data.statusCode,200);
            bd = jsondecode(data.body);
            testCase.verifyEqual(bd.y,42.0);
        end
        function testInputError(testCase)
            % Make the call
            % Call with an invalid input (field b is missing)
            req = matlab.net.http.RequestMessage( ...
                matlab.net.http.RequestMethod.POST, ...
                matlab.net.http.field.ContentTypeField("application/json"), ...
                struct('body',jsonencode(struct('a',21.0))) ...
            );
            res = req.send(sprintf("http://%s:%s/2015-03-31/functions/function/invocations",testCase.host,testCase.port));
            testCase.verifyEqual(res.StatusCode,matlab.net.http.StatusCode.OK);
            data = jsondecode(res.Body.Data);
            % Verify that this returned 400 - Bad Request
            testCase.verifyEqual(data.statusCode,400);
        end  
        function testInvocationError(testCase)
            % Make the call
            % Call with inputs with incompatible dimensions
            req = matlab.net.http.RequestMessage( ...
                matlab.net.http.RequestMethod.POST, ...
                matlab.net.http.field.ContentTypeField("application/json"), ...
                struct('body',jsonencode(struct('a',[1,2,3],'b',[4,5]))) ...
            );
            res = req.send(sprintf("http://%s:%s/2015-03-31/functions/function/invocations",testCase.host,testCase.port));
            testCase.verifyEqual(res.StatusCode,matlab.net.http.StatusCode.OK);
            data = jsondecode(res.Body.Data);
            % Verify that this returned 500 - Internal Server Error
            testCase.verifyEqual(data.statusCode,500);
        end         
    end
end

