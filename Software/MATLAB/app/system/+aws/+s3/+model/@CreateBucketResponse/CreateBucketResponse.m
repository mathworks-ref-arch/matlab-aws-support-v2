classdef CreateBucketResponse < aws.Object
    %CREATEBUCKETRESPONSE MATLAB wrapper for software.amazon.awssdk.services.s3.model.CreateBucketResponse.
    %
    % Syntax
    %   resp = aws.s3.model.CreateBucketResponse(javaResponse);
    %
    % Properties
    %   location - (string) Bucket location constraint reported by S3.
    %
    % Example
    %   resp = s3.createBucket(bucket="matlab-demo-bucket");
    %   disp(resp.location);

    % Copyright 2025 The MathWorks, Inc.

    properties
        location string
    end

    methods
        function obj = CreateBucketResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.CreateBucketResponse')
                obj.Handle = varargin{1};
                obj.location = string(varargin{1}.location());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
