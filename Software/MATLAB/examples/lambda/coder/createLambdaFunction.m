function response = createLambdaFunction(zipFileName)
% CREATELAMBDAFUNCTION Creates a Lambda function using a custom runtime.
% This function creates an AWS Lambda function that uses a custom runtime
% to execute a compiled C code executable.
%
% Example usage:
% response = createLambdaFunction(lambdaFunctionName, zipFileName);

% Copyright 2025 The MathWorks, Inc.


%zipFileName = createRedshiftLambdaRuntimeZip(matlabFunctionName,matlabFunctionArgs);

[~, fileName, fileExt] = fileparts(zipFileName);
zipFilePath = fullfile(pwd, [fileName fileExt]);
zipFile = aws.core.model.SdkBytes(zipFilePath);

codeSource = struct('zipFile', zipFile);
%codeSource = struct('s3Key', s3Key, 's3Bucket', bucketName);

functionCode = aws.lambda.model.FunctionCode(codeSource);
options = struct('functionName', fileName, ...
    'role', 'arn:aws:iam::171626478215:role/sivab-lambda-test', ...
    'handler', 'function.handler', ...
    'code', functionCode, ...
    'runtime', 'provided.al2', ...
    'timeout', 10);

logObj = Logger.getLogger();
write(logObj, 'verbose', 'Creating Lambda function with custom runtime');


lambda = aws.lambda.Client();

% Call the AWS SDK createFunction method
response = lambda.createFunction(fileName, options);

write(logObj, 'verbose', 'Function created successfully');

end