classdef PutBucketAclResponse < aws.Object
    %PUTBUCKETACLRESPONSE MATLAB wrapper for software.amazon.awssdk.services.s3.model.PutBucketAclResponse.
    %
    % Syntax
    %   resp = aws.s3.model.PutBucketAclResponse(javaResponse);
    %
    % Properties
    %   statusCode     - (double) HTTP status code returned by S3.
    %   requestCharged - (string) Indicates whether the requester was charged.
    %
    % Example
    %   resp = s3.putBucketAcl(bucket="my-bucket", acl="public-read");
    %   disp(resp.statusCode);

    % Copyright 2025 The MathWorks, Inc.

    properties
        statusCode
    end

    methods
        function obj = PutBucketAclResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.PutBucketAclResponse')
                obj.Handle = varargin{1};

                obj.statusCode = varargin{1}.sdkHttpResponse().statusCode();
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
