classdef PutBucketPolicyResponse < aws.Object
    % PUTBUCKETPOLICYRESPONSE Wrapper for S3 PutBucketPolicy responses.
    %
    % Syntax
    %   resp = aws.s3.model.PutBucketPolicyResponse(javaResponse);
    %
    % Properties
    %   statusCode - (double) HTTP status reported by the SDK.

    % Copyright 2025 The MathWorks, Inc.

    properties
        statusCode
    end

    methods
        function obj = PutBucketPolicyResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.PutBucketPolicyResponse')
                obj.Handle = varargin{1};

                obj.statusCode = varargin{1}.sdkHttpResponse().statusCode();
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
