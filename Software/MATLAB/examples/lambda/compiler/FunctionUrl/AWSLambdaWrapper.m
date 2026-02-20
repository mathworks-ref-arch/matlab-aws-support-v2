function AWSLambdaWrapper
    % Determine the AWS endpoint to call to obtain the next function
    % invocation
    nextURI = sprintf("http://%s/2018-06-01/runtime/invocation/next",getenv('AWS_LAMBDA_RUNTIME_API'));
    % While the container is active, run one big loop which just keep 
    % querying for new incoming requests after it has finished the
    % previous one
    while true
        %% Call the next endpoint on AWS lambda to obtain a new request
        req = matlab.net.http.RequestMessage();
        resp = req.send(nextURI);
        reqId = resp.Header.getFields("Lambda-Runtime-Aws-Request-Id").Value;
        % Try to parse the input data, call the actual MATLAB function and
        % return the response to AWS
        try
            %% Parse the input body

            % If something goes wrong in this part, there was (likely)
            % something wrong with the input, this can be reported back
            % specifically to the invoker by statusCode 400 - Invalid
            % request. This errorCode variable is used in the CATCH clause
            % to report back a specific statusCode; the value can be
            % changed further down below to indicate different kinds of
            % errors.
            errorCode = 400;

            % Get the input data from the body. In this example it is
            % assumed that the lambda function is executed through a
            % Function URL, in this case the input body will have a fixed
            % format: https://docs.aws.amazon.com/lambda/latest/dg/urls-invocation.html#urls-payloads
            % and the actual input is in the "body" field. For this example
            % we assume this body will contain JSON data which we first
            % need to parse from a JSON string into a MATLAB structure
            data = jsondecode(resp.Body.Data.body);
            % For other functions this will have to be modified depending
            % on the inputs your actual MATLAB function requires and what
            % kind of interface you want the AWS function to have.

            % In this example we will also really verify the input and if
            % it is incorrect return a specific error to the invoker
            if ~isfield(data,'a') || ~isfield(data,'b')
                % Throw the actual error such that it is reported back to
                % the invoker
                error("awsexample:missinginput","Input fields a and b are required");
            end
            if ~isnumeric(data.a) || ~isnumeric(data.b)
                % Throw the actual error such that it is reported back to
                % the invoker
                error("awsexample:inputnotnumeric","Input a and b should be numeric");
            end
            
            %% End of input parsing

            % From this point forward if something goes wrong we will
            % report this back as a more generic error 500 - Internal
            % Server Error instead of 400 - Bad Request
            errorCode = 500;

            %% Call the actual MATLAB function
            y = myFun(data.a,data.b);
            % This will have to be updated to call the right function with
            % the right inputs when updating this for other functions

            %% POST the response to the response endpoint. 
            % In this example we return the output as a JSON object with a
            % field y containing the return value of the MATLAB function.
            % We will use the full output format for function URL
            % specifically:
            % https://docs.aws.amazon.com/lambda/latest/dg/urls-invocation.html#urls-payloads
            % such that we can for example also explicitly set the
            % statusCode

            % Form the response payload
            response.statusCode = 200;
            response.headers = containers.Map('Content-Type','application/json');
            % Body must be a string, so pre-encode our actual output as a JSON string
            response.body = jsonencode(struct('y',y));
            response.isBase64Encoded = false;
            
            % Form the response URI based on the AWS environment variable and request ID
            responseURI = sprintf("http://%s/2018-06-01/runtime/invocation/%s/response",getenv('AWS_LAMBDA_RUNTIME_API'),reqId);
            % Create the request message where we let the HTTP interface
            % encode the response struct into JSON
            req = matlab.net.http.RequestMessage(...
                matlab.net.http.RequestMethod.POST,...
                matlab.net.http.field.ContentTypeField("application/json"),...
                response... 
            );
            % Perform the request to deliver the output
            req.send(responseURI);
            % This can be customized depending on what kind of output you
            % want to return in which format exactly.
        catch ME
            % If anything went wrong during parsing the input, calling the
            % MATLAB function or sending the response, report an error.
            % Since this particular example is designed to be  called
            % through a function URL, we elect to really report back the
            % error to the invoker by not reporting a hard error and
            % instead reporting a response with an error statusCode
            
            % Form the result response payload
            response.statusCode = errorCode;
            response.headers = containers.Map('Content-Type','application/json');
            % Body must be a string, jsonencode a structure with error information
            response.body = jsonencode(ME);
            response.isBase64Encoded = false;
        
            % Form the response URI based on the AWS environment variable and request ID
            responseURI = sprintf("http://%s/2018-06-01/runtime/invocation/%s/response",getenv('AWS_LAMBDA_RUNTIME_API'),reqId);
            % Create the request message where we let the HTTP interface
            % encode the response struct into JSON
            req = matlab.net.http.RequestMessage(...
                matlab.net.http.RequestMethod.POST,...
                matlab.net.http.field.ContentTypeField("application/json"),...
                response... 
            );
            % Perform the request to deliver the output
            req.send(responseURI);
        end
        % After invocation and returning a response or error, just go back
        % to the start of the loop again and wait for another request to
        % come in (or for AWS Lambda to just stop the whole container).
    end

