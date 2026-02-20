classdef testDocker < aws.lambda.testutil.DockerBase
    properties
        imageName = "matlab-awslambda-mps-example"
    end

    methods (Test)
        function testmyFun1(testCase)
            % Make the call
            payload.rawPath = '/foo/myFun1';
            payload.body = mps.json.encoderequest({21.0});

            req = matlab.net.http.RequestMessage( ...
                matlab.net.http.RequestMethod.POST, ...
                matlab.net.http.field.ContentTypeField("application/json"), ...
                payload ...
            );
            res = req.send(sprintf("http://%s:%s/2015-03-31/functions/function/invocations",testCase.host,testCase.port));
            testCase.verifyEqual(res.StatusCode,matlab.net.http.StatusCode.OK);
            data = jsondecode(res.Body.Data);
            testCase.verifyEqual(data.statusCode,200);
            output = mps.json.decoderesponse(data.body);
            testCase.verifyEqual(output,{42})
        end
        function testmyFun2(testCase)
            % Make the call
            payload.rawPath = '/foo/myFun2';
            payload.body = mps.json.encoderequest({[1,2,3],[4,5,6]},'nargout',2);

            req = matlab.net.http.RequestMessage( ...
                matlab.net.http.RequestMethod.POST, ...
                matlab.net.http.field.ContentTypeField("application/json"), ...
                payload ...
            );
            res = req.send(sprintf("http://%s:%s/2015-03-31/functions/function/invocations",testCase.host,testCase.port));
            testCase.verifyEqual(res.StatusCode,matlab.net.http.StatusCode.OK);
            data = jsondecode(res.Body.Data);
            testCase.verifyEqual(data.statusCode,200);
            output = mps.json.decoderesponse(data.body);
            testCase.verifyEqual(output,{[5,7,9];[-3,-3,-3]})
        end        
        function testNargoutError(testCase)
            payload.rawPath = '/foo/myFun1';
            payload.body = '{"rhs":[21.0]}';
            req = matlab.net.http.RequestMessage( ...
                matlab.net.http.RequestMethod.POST, ...
                matlab.net.http.field.ContentTypeField("application/json"), ...
                payload ...
            );
            res = req.send(sprintf("http://%s:%s/2015-03-31/functions/function/invocations",testCase.host,testCase.port));
            data = jsondecode(res.Body.Data);
            testCase.verifyEqual(data.statusCode,400)
        end  
       
    end
end

