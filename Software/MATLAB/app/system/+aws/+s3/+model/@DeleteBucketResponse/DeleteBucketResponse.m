classdef DeleteBucketResponse < aws.Object
    %DELETEBUCKETRESPONSE MATLAB wrapper for the AWS SDK DeleteBucket response.
    %
    % Syntax
    %   resp = aws.s3.model.DeleteBucketResponse(javaResponse);
    %
    % Properties
    %   requestCharged - (string) Indicates whether the requester was charged for the call.
    %
    % Example
    %   resp = s3.deleteBucket(bucket="matlab-demo-bucket");
    %   disp(resp.requestCharged);

    % Copyright 2025 The MathWorks, Inc.

    properties
        status string
    end

    methods
        function obj = DeleteBucketResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.DeleteBucketResponse')
                obj.Handle = varargin{1};
                obj.status = "Success";
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end