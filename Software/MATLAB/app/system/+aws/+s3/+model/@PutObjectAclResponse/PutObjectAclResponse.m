classdef PutObjectAclResponse < aws.Object
    % PUTOBJECTACLRESPONSE Wrapper for S3 PutObjectAcl responses.
    %
    % Syntax
    %   resp = aws.s3.model.PutObjectAclResponse(javaResponse);
    %
    % Properties
    %   statusCode - (double) HTTP status returned by the SDK.

    % Copyright 2025 The MathWorks, Inc.

    properties
        statusCode
    end

    methods
        function obj = PutObjectAclResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.PutObjectAclResponse')
                obj.Handle = varargin{1};

                obj.statusCode = varargin{1}.sdkHttpResponse().statusCode();

            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
