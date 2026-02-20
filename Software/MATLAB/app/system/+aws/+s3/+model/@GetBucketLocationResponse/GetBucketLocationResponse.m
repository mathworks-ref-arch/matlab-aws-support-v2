classdef GetBucketLocationResponse < aws.Object
    %GETBUCKETLOCATIONRESPONSE MATLAB wrapper for software.amazon.awssdk.services.s3.model.GetBucketLocationResponse.
    %
    % Syntax
    %   resp = aws.s3.model.GetBucketLocationResponse(javaResponse);
    %
    % Properties
    %   locationConstraint - (string) Regional constraint returned by S3 (for example, "us-west-2").
    %
    % Example
    %   resp = s3.getBucketLocation(bucket="my-bucket");
    %   disp(resp.locationConstraint);

    % Copyright 2025 The MathWorks, Inc.

    properties
        locationConstraint string = ""
    end

    methods
        function obj = GetBucketLocationResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.GetBucketLocationResponse')
                obj.Handle = varargin{1};
                obj.locationConstraint = string(varargin{1}.locationConstraintAsString());
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
