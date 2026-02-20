classdef FunctionCode < aws.Object
    % FUNCTIONCODE Builder/wrapper for Lambda deployment packages.
    %
    % Syntax
    %   code = aws.lambda.model.FunctionCode(zipFile=sdkBytes);
    %   code = aws.lambda.model.FunctionCode(struct("s3Bucket","bucket","s3Key","function.zip"));
    %
    % Name-Value Arguments / Struct Fields
    %   zipFile          - (aws.core.model.SdkBytes) Inline deployment package (<= 50 MB).
    %   s3Bucket         - (string) Bucket containing the deployment archive.
    %   s3Key            - (string) Object key for the deployment archive.
    %   s3ObjectVersion  - (string) Optional object version.
    %   imageUri         - (string) Container image URI for image-based Lambda functions.
    %
    % Example
    %   payload = aws.core.model.SdkBytes("function.zip");
    %   code = aws.lambda.model.FunctionCode(zipFile=payload);

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = FunctionCode(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.lambda.model.FunctionCode')
                obj.Handle = varargin{1};
                return
            end

            if nargin == 1 && isstruct(varargin{1})
                opts = varargin{1};
            else
                if mod(nargin, 2) ~= 0
                    error('aws:lambda:FunctionCode:InvalidInput', ...
                        'Provide Name-Value pairs or a struct of FunctionCode options.');
                end
                opts = struct(varargin{:});
            end

            if isempty(fieldnames(opts))
                error('aws:lambda:FunctionCode:MissingFields', ...
                    'Specify at least one of zipFile, s3Bucket/s3Key, or imageUri.');
            end

            functionCodeBuilder = software.amazon.awssdk.services.lambda.model.FunctionCode.builder();
            obj.Handle = aws.internal.builder.build(functionCodeBuilder, opts);
        end
    end
end

