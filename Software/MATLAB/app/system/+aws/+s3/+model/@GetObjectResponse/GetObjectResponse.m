classdef GetObjectResponse < aws.Object
    %GETOBJECTRESPONSE MATLAB wrapper for software.amazon.awssdk.services.s3.model.GetObjectResponse.
    %
    % Syntax
    %   resp = aws.s3.model.GetObjectResponse(javaResponse);
    %
    % Properties
    %   contentLength - (int64) Object size in bytes.
    %   contentType   - (string) MIME type reported by S3.
    %   eTag          - (string) Entity tag assigned by S3.
    %   lastModified  - (java.time.Instant) Object last-modified timestamp.
    %   versionId     - (string) Version identifier when versioning is enabled.
    %   storageClass  - (string) Storage class enumeration as text.
    %
    % Example
    %   [resp, stream] = s3.getObject(bucket="my-bucket", key="logs/output.json");
    %   disp(resp.contentType);

    % Copyright 2025 The MathWorks, Inc.

    properties
        contentLength
        contentType
        eTag
        lastModified
        % metadata
        versionId
        storageClass
        % Add more properties as needed
    end

    methods
        function obj = GetObjectResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.GetObjectResponse')
                obj.Handle = varargin{1};

                obj.contentLength = varargin{1}.contentLength();
                obj.contentType   = string(varargin{1}.contentType());
                obj.eTag          = string(varargin{1}.eTag());
                obj.lastModified  = varargin{1}.lastModified();
                obj.versionId     = string(varargin{1}.versionId());
                obj.storageClass  = string(varargin{1}.storageClassAsString());

            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
