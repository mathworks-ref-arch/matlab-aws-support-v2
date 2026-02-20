function response = invokeFunction(obj, options)
% INVOKEFUNCTION Invoke an AWS Lambda function.
%
% Syntax
%   resp = lambda.invokeFunction(functionName="MyFunction", payload=payloadBytes);
%   resp = lambda.invokeFunction(functionName="MyFunction", invocationType="Event", payload=payloadBytes);
%
% Name-Value Arguments
%   functionName   - (string, required) Name or ARN of the Lambda function, version, or alias.
%   clientContext  - (string) Up to 3,583 bytes of base64-encoded context passed to the function.
%   invocationType - (string) One of `"RequestResponse"`, `"Event"`, or `"DryRun"` (default `"RequestResponse"`).
%   logType        - (string) Set to `"Tail"` to include the last 4 KB of execution log in the response.
%   payload        - (aws.core.model.SdkBytes, required) UTF-8 or binary payload sent to the handler.
%   qualifier      - (string) Version number or alias to invoke.
%
% Returns
%   response - aws.lambda.model.InvokeFunctionResponse exposing status code, payload, and logs.
%
% Example
%   payload = aws.core.model.SdkBytes('{"message":"hello"}', 'utf-8');
%   resp = lambda.invokeFunction(functionName="MyFunction", payload=payload, logType="Tail");
%   disp(resp.statusCode);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.functionName (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.clientContext (1,1) string {mustBeTextScalar}
    options.invocationType (1,1) string {mustBeTextScalar} = "RequestResponse"
    options.logType (1,1) string {mustBeTextScalar}
    options.payload aws.core.model.SdkBytes
    options.qualifier (1,1) string {mustBeTextScalar}
end

write(obj.logObj, 'info', 'Invoke Function in AWS Lambda Service');

% Build the InvokeFunctionRequest using the AWS SDK
invokeRequestBuilder = software.amazon.awssdk.services.lambda.model.InvokeRequest.builder();
invokeRequest = aws.internal.builder.build(invokeRequestBuilder, options);

% Call the AWS SDK invoke method
responseJ = obj.Handle.invoke(invokeRequest);

% Wrap the Java response object in a MATLAB response object
response = aws.lambda.model.InvokeFunctionResponse(responseJ);

end
