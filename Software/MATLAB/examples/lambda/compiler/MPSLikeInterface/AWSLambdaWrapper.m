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

            % Parse the input in MATLAB Production Server Style

            % Get the last part of the path to determine the function name,
            % the "archive name" (i.e. first part of the path) is ignored,
            % there are no multiple archives in a AWS Lambda deployment
            % like this.
            u = matlab.net.URI(resp.Body.Data.rawPath);
            fun = u.Path(end);
            % Parse the input body MATLAB Production Server Style
            body = resp.Body.Data.body;
            % Get nargout
            nargout = regexp(body,'"nargout"\s*:\s*(\d*)','tokens','once');
            if isempty(nargout)
                error('AwsLambdaFunction:MPSInterface:NargoutMissing','nargout input field is required');
            else
                nargout = str2double(nargout{1});
            end
            % Get outputFormat if any, start with default
            format = 'large';
            NaNInfType = 'string';
            % Find any settings in the request
            outputFormat = regexp(body,'"outputFormat"\s*:\s*(\{\s*.*?\s*\})','tokens','once');
            if ~isempty(outputFormat)
                % And override the settings which are set
                outputFormat = jsondecode(outputFormat{1});
                if isfield(outputFormat,'mode'), format = outputFormat.mode; end
                if isfield(outputFormat,'nanInfFormat'), NaNInfType = outputFormat.nanInfFormat; end
            end
            % Use decoderesponse to parse the actual inputs (since this
            % expects lhs instead of rhs though, first replace rhs with
            % lhs)
            inputs = mps.json.decoderesponse(regexprep(body,'"rhs"','"lhs"','once'));
            %% End of input parsing

            % From this point forward if something goes wrong we will
            % report this back as a more generic error 500 - Internal
            % Server Error instead of 400 - Bad Request
            errorCode = 500;

            %% Call the actual MATLAB function
            [out{1:nargout}] = feval(fun,inputs{:});

            %% POST the response to the response endpoint. 
            % First format the output into MPS style output
            out = cellfun(@(x)mps.json.encode(x,'Format',format,'NaNInfType',NaNInfType),out,'UniformOutput',false);
            out = ['{ "lhs": [' strjoin(out,',') ']}'];
            
            % Form the function URL response payload
            response.statusCode = 200;
            response.headers = containers.Map('Content-Type','application/json');
            response.body = out;
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
        % After invocation and returning a response or error, basically
        % just go back to the start of the loop again and wait for another
        % request to come in (or for AWS Lambda to just stop the whole
        % container).
        %
        % However, first do clear output out to avoid conflicts in the next
        % loop
        clear out
    end

