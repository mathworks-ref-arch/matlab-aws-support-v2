function AWSLambdaWrapper
    % Determine the AWS endpoint to call to obtain the next function
    % invocation. This will be based on the AWS_LAMBDA_RUNTIME_API
    % environment variable which the AWS Lambda endpoint will have set
    % for us when the Docker container is launched by AWS Lambda.
    nextURI = sprintf("http://%s/2018-06-01/runtime/invocation/next",getenv('AWS_LAMBDA_RUNTIME_API'));
    % While the container is active, run one big loop which just keep 
    % querying for new incoming requests after it has finished the
    % previous one. 
    while true
        %% Call the next endpoint on AWS lambda to obtain a new request
        % This is a blocking request which will just wait until the a new
        % function invocation has taken place. Or while we are waiting
        % here AWS Lambda might stop the entire container, which is fine.
        req = matlab.net.http.RequestMessage();
        resp = req.send(nextURI);
        
        % In the response a header will be set which identifies the request.
        % When returning the result or an error we will need this ID. Get
        % this value from the relevant header field.
        reqId = resp.Header.getFields("Lambda-Runtime-Aws-Request-Id").Value;
           
        % Try to parse the input data, call the actual MATLAB function and
        % return the response to AWS. This is inside a TRY-CATCH such that
        % if an error occurs we can report it to the error endpoint and then
        % continue listening for new invocations again.
        try
            %% Parse the input body
            % Get the input data from the body. In this example it is
            % assumed that we will have received a JSON payload which the
            % MATLAB HTTP Interface will have automatically parsed into a
            % MATLAB structure. The structure is expected to contain a
            % field x containing a numeric scalar or array.
            x = resp.Body.Data.x;
            % For other functions this will have to be modified depending
            % on the inputs your actual MATLAB function requires and what
            % kind of interface you want the AWS function to have.

            %% Call the actual MATLAB function
            y = myFun(x);
            % For other functions, this would obviously have to be updated 
            % to call the right function with the right inputs.

            %% POST the response to the response endpoint. 
            % In this example we return the output as a JSON object with a
            % field y containing the return value of the MATLAB function.
            % We let the MATLAB HTTP Interface automatically form this JSON
            % object based on a MATLAB structure.
            req = matlab.net.http.RequestMessage(...
                matlab.net.http.RequestMethod.POST,...
                matlab.net.http.field.ContentTypeField("application/json"),...
                struct('y',y)...
            );
            responseURI = sprintf("http://%s/2018-06-01/runtime/invocation/%s/response",getenv('AWS_LAMBDA_RUNTIME_API'),reqId);
            req.send(responseURI);
            % This can be customized depending on what kind of output you
            % want to return in which format exactly.
        catch ME
            % If anything went wrong during parsing the input, calling the
            % MATLAB function or sending the response, post a message to
            % the error endpoint on AWS
            req = matlab.net.http.RequestMessage(...
                matlab.net.http.RequestMethod.POST,...
                matlab.net.http.field.ContentTypeField("application/json"),...
                struct('errorMessage',ME.message,'errorType',ME.identifier)...
            );
            errorURI = sprintf("http://%s/2018-06-01/runtime/invocation/%s/error",getenv('AWS_LAMBDA_RUNTIME_API'),reqId);
            req.send(errorURI);
        end
        % After invocation and returning a response or error, just go back
        % to the start of the loop again and wait for another request to
        % come in (or for AWS Lambda to just stop the whole container).
    end
