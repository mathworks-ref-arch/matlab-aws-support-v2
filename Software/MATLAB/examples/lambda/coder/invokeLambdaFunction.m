function responsePayload = invokeLambdaFunction(functionName, inputArg)
%
% This function invokes an AWS Lambda function that uses a custom runtime
% to execute a compiled C code executable binary.
%
% Example usage:
% response = invokeLambdaFunction('MATLAB_Modulus_Lambda', '11 4');

% Copyright 2025 The MathWorks, Inc.


inputJSONPayload = jsonencode(struct('input', inputArg));
payload = aws.core.model.SdkBytes(inputJSONPayload);
lambda = aws.lambda.Client();
functionResponse = lambda.invokeFunction(functionName, 'payload', payload);

% Get the payload from the response
responsePayload = functionResponse.getPayload();
disp(['Lambda Response: ', jsondecode(responsePayload)]);
end
