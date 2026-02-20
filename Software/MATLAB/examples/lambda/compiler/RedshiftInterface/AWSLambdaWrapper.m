function AWSLambdaWrapper
% Determine the AWS endpoint to call to obtain the next function invocation
nextURI = sprintf("http://%s/2018-06-01/runtime/invocation/next", getenv('AWS_LAMBDA_RUNTIME_API'));

% While the container is active, run a loop to process incoming requests
while true
    % Call the next endpoint on AWS Lambda to obtain a new request
    req = matlab.net.http.RequestMessage();
    resp = req.send(nextURI);
    reqId = resp.Header.getFields("Lambda-Runtime-Aws-Request-Id").Value;

    % Parse the input body
    if isempty(resp.Body)
        error(['Invalid JSON input' char(resp.Body)]);
    end

    fprintf(2, "Request Body Data: %s\n", resp.Body);

    try
        inputData = jsondecode(char(resp.Body));
    catch ME
        fprintf(2, "Error decoding JSON: %s\n", ME.message);
        continue;
    end

    try
        % Extract the function name and arguments from the input JSON
        fun = inputData.external_function;
        arguments = inputData.arguments;
        numRecords = inputData.num_records;


        % Prepare the results container
        allResults = cell(1, numRecords);

        % Determine the size of the arguments array
        argumentsSize = size(arguments);

        % Iterate over each record
        for index = 1:numRecords
            if argumentsSize(1) == numRecords
                % If the size of arguments matches numRecords, use each row as a separate input set
                currentArgs = arguments(index, :);
            elseif argumentsSize(1) == 1 && numRecords > 1
                % If there's a single row and multiple records, treat each element as a separate input
                currentArgs = arguments(index);
            elseif numRecords == 1
                % If there's only one record, use the entire array as input
                currentArgs = arguments;
            else
                error('Arguments structure does not match expected format for numRecords');
            end

            % Ensure currentArgs is in the correct format for feval
            inputs = num2cell(currentArgs); % Convert numeric array to cell array for feval

            % Print the input arguments for the current iteration
            fprintf('Calling MATLAB Function: %s with Input Arguments: %s for Iteration: %d\n', ...
                fun, jsonencode(inputs), index);

            % Check if the function exists
            if ~exist(fun, 'file')
                error('Function %s not found', fun);
            end

            % Determine the number of outputs expected by the function
            nargoutFun = nargout(fun);

            % Call the MATLAB function with the parsed arguments and capture outputs
            [out{1:nargoutFun}] = feval(fun, inputs{:});

            % Process and store the results
            allResults{index} = formatResult(out{1});
        end

        % Prepare the response
        response = jsonencode(struct('success', true, 'num_records', numel(allResults), 'results', [allResults{:}]));

        % Send the response back to AWS Lambda
        responseURI = sprintf("http://%s/2018-06-01/runtime/invocation/%s/response", getenv('AWS_LAMBDA_RUNTIME_API'), reqId);
        req = matlab.net.http.RequestMessage(matlab.net.http.RequestMethod.POST, matlab.net.http.field.ContentTypeField("application/json"), response);
        req.send(responseURI);

    catch ME
        % Handle errors and send an error response
        errorMessage = sprintf('Error: %s', ME.message);
        response = jsonencode(struct('success', false, 'error_msg', errorMessage, 'num_records', 0, 'results', []));
        responseURI = sprintf("http://%s/2018-06-01/runtime/invocation/%s/error", getenv('AWS_LAMBDA_RUNTIME_API'), reqId);
        req = matlab.net.http.RequestMessage(matlab.net.http.RequestMethod.POST, matlab.net.http.field.ContentTypeField("application/json"), response);
        req.send(responseURI);
    end

    % Clear output to avoid conflicts in the next loop iteration
    clear out
end
end

function formatted = formatResult(value)
if isnumeric(value)
    formatted = value; % Return numeric value as is
else
    formatted = NaN; % Use NaN for unsupported types
end
end