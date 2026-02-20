function response = deleteLambdaFunction(functionName)
%DELETELAMBDAFUNCTION     Deletes a Lambda function based on function name.
%
% Example usage:
% response = deleteLambdaFunction('MATLAB_Modulus_Lambda');

% Copyright 2025 The MathWorks, Inc.

logObj = Logger.getLogger();
write(logObj, 'verbose', 'Deleting Lambda function');

lambda = aws.lambda.Client();

% Call the AWS SDK createFunction method
response = lambda.deleteFunction(functionName);

write(logObj, 'verbose', 'Function deleted successfully');


end

