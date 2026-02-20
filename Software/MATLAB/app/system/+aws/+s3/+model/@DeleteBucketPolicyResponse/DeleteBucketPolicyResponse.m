classdef DeleteBucketPolicyResponse < aws.Object
    % DELETEBUCKETPOLICYRESPONSE Wrapper for S3 DeleteBucketPolicy results.
    %
    % Syntax
    %   resp = aws.s3.model.DeleteBucketPolicyResponse(javaResponse);
    %
    % Properties
    %   statusCode - (double) HTTP status returned by the SDK (e.g., 204).
    %   status     - (string) `"Success"` when the request completed without error.

    % Copyright 2025 The MathWorks

    properties
        % Numeric HTTP status code from the SDK HTTP response (e.g., 204)
        statusCode (1,1) double = NaN
        status (1,1) string = "Failed"
    end

    methods
        function obj = DeleteBucketPolicyResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.DeleteBucketPolicyResponse')
                obj.Handle = varargin{1};

                sdkHttpResp = obj.Handle.sdkHttpResponse();
                % statusCode() returns a java.lang.Integer; convert to double
                obj.statusCode = double(sdkHttpResp.statusCode());
                if sdkHttpResp.isSuccessful()
                    obj.status = "Success";
                else
                    obj.status = "Failed";
                end

            else
                write(obj.logObj, 'error', 'Invalid arguments to DeleteBucketPolicyResponse constructor');
            end
        end
    end
end
