classdef HeadObjectResponse < aws.Object
    %HEADOBJECTRESPONSE MATLAB wrapper for software.amazon.awssdk.services.s3.model.HeadObjectResponse.
    %
    % Syntax
    %   resp = aws.s3.model.HeadObjectResponse(javaResponse);
    %
    % Properties
    %   contentLength - (double) Object size in bytes.
    %   contentType   - (string) MIME type reported by S3.
    %   eTag          - (string) Entity tag assigned to the object.
    %   lastModified  - (java.time.Instant) Timestamp returned by S3.
    %
    % Example
    %   resp = s3.headObject(bucket="matlab-demo-bucket", key="logs/output.json");
    %   fprintf("Content-Type: %s\\n", resp.contentType);

    % Copyright 2025 The MathWorks, Inc.

    properties
        contentLength double = NaN
        contentType string = ""
        eTag string = ""
        lastModified
    end

    methods
        function obj = HeadObjectResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.HeadObjectResponse')
                respJ = varargin{1};
                obj.Handle = respJ;
                obj.contentLength = double(respJ.contentLength());
                obj.contentType = string(respJ.contentType());
                obj.eTag = string(respJ.eTag());

                lm = respJ.lastModified();
                if ~isempty(lm)
                    obj.lastModified = lm;
                else
                    obj.lastModified = [];
                end
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
