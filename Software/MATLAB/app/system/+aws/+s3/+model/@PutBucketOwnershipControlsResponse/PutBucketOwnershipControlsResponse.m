classdef PutBucketOwnershipControlsResponse < aws.Object
    %PUTBUCKETOWNERSHIPCONTROLSRESPONSE MATLAB wrapper for the AWS SDK response.
    %
    % Syntax
    %   resp = aws.s3.model.PutBucketOwnershipControlsResponse(javaResponse);
    %
    % Properties
    %   statusCode - (double) HTTP status code returned by S3.
    %   status     - (string) `"Success"` when S3 reports success, otherwise `"Failed"`.
    %
    % Example
    %   resp = s3.putBucketOwnershipControls(bucket="bkt", objectOwnership="BucketOwnerPreferred");
    %   disp(resp.statusCode);

    % Copyright 2025 The MathWorks

    properties
        statusCode (1,1) double = NaN
        status     (1,1) string = "Failed"
    end

    methods
        function obj = PutBucketOwnershipControlsResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.PutBucketOwnershipControlsResponse')
                obj.Handle = varargin{1};
                sdkHttpResp = obj.Handle.sdkHttpResponse();
                obj.statusCode = double(sdkHttpResp.statusCode());
                if sdkHttpResp.isSuccessful()
                    obj.status = "Success";
                else
                    obj.status = "Failed";
                end
            else
                write(obj.logObj, 'error', ...
                    'Invalid arguments to PutBucketOwnershipControlsResponse constructor');
            end
        end
    end
end
