function response = createFunction(obj, options)
% CREATEFUNCTION Create a new AWS Lambda function.
%
% Syntax
%   resp = lambda.createFunction( ...
%       functionName="MyFunction", runtime="python3.12", role=roleArn, ...
%       handler="app.lambda_handler", code=code);
%
% Name-Value Arguments
%   functionName - (string, required) Logical name for the Lambda function.
%   runtime      - (string, required) Runtime identifier such as "nodejs20.x" or "python3.12".
%   role         - (string, required) IAM role ARN assumed by Lambda during execution.
%   handler      - (string, required) Entry point in your code (`file.function`).
%   code         - (aws.lambda.model.FunctionCode, required) Function deployment package.
%   description  - (string) Optional description shown in the console.
%   timeout      - (int32) Execution timeout in seconds (default 3).
%   memorySize   - (int32) Memory allocation in MB (default 128).
%   tags         - (dictionary) Key/value metadata applied to the function.
%
% Returns
%   response - aws.lambda.model.CreateFunctionResponse containing metadata for the created function.
%
% Example
%   code = aws.lambda.model.FunctionCode(zipFile=aws.core.model.SdkBytes('function.zip'));
%   resp = lambda.createFunction( ...
%       functionName="demoFunction", runtime="nodejs20.x", role=roleArn, ...
%       handler="index.handler", code=code, description="Demo function");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.functionName (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.runtime (1,1) string {mustBeTextScalar}
    options.role (1,1) string {mustBeTextScalar}
    options.handler (1,1) string {mustBeTextScalar}
    options.code aws.lambda.model.FunctionCode
    options.description (1,1) string {mustBeTextScalar}
    options.timeout (1,1) int32 {mustBeNonnegative} = 3
    options.memorySize (1,1) int32 {mustBePositive} = 128
    options.tags dictionary = dictionary()
end

write(obj.logObj, 'info', 'Create Function in AWS Lambda Service');

% Build the CreateFunctionRequest using the AWS SDK
createFunctionRequestBuilder = software.amazon.awssdk.services.lambda.model.CreateFunctionRequest.builder();
createFunctionRequest = aws.internal.builder.build(createFunctionRequestBuilder, options);

% Call the AWS SDK createFunction method
responseJ = obj.Handle.createFunction(createFunctionRequest);

% Wrap the Java response object in a MATLAB response object
response = aws.lambda.model.CreateFunctionResponse(responseJ);

end
