function response = deleteFunction(obj, options)
% DELETEFUNCTION Delete an AWS Lambda function or alias.
%
% Syntax
%   resp = lambda.deleteFunction(functionName="MyFunction");
%
% Name-Value Arguments
%   functionName - (string, required) Function name, full ARN, version, or alias.
%
% Returns
%   response - aws.lambda.model.DeleteFunctionResponse containing request metadata.
%
% Example
%   resp = lambda.deleteFunction(functionName="MyFunction:1");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.functionName (1,1) string {mustBeTextScalar, mustBeNonempty}
end

write(obj.logObj,'verbose','Delete Function in AWS Lambda Service');


% Call the AWS SDK deleteFunction method
deleteFunctionRequestBuilder = ...
    software.amazon.awssdk.services.lambda.model.DeleteFunctionRequest.builder();
deleteFunctionRequest = aws.internal.builder.build(deleteFunctionRequestBuilder, options);
responseJ = obj.Handle.deleteFunction(deleteFunctionRequest);

% Wrap the Java response object in a MATLAB response object
response = aws.lambda.model.DeleteFunctionResponse(responseJ);

end
