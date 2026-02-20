classdef S3Object < aws.Object
    % S3OBJECT MATLAB wrapper for software.amazon.awssdk.services.s3.model.S3Object.
    %
    % Syntax
    %   obj = aws.s3.model.S3Object(javaObject);
    %   obj = aws.s3.model.S3Object(struct(key="path/file.txt", size=int64(42)));
    %
    % Inputs
    %   javaObject - (software.amazon.awssdk.services.s3.model.S3Object) Raw SDK object,
    %                typically returned by listObjects/listObjectsV2.
    %   struct      - (scalar struct) Builder-style fields consumed by the AWS SDK
    %                (key, size, eTag, storageClass, etc.).
    %
    % Properties
    %   key                  - (string) Object key as returned by S3.
    %   size                 - (double) Object size in bytes.
    %   lastModified         - (datetime, UTC) Timestamp of the object.
    %   eTag                 - (string) Entity tag (quoted MD5 for single-part uploads).
    %   checksumTypeAsString - (string) Reported checksum algorithm, if available.
    %   storageClassAsString - (string) Storage class (STANDARD, GLACIER, ...).
    %   owner                - (aws.s3.model.Owner) Owner information when requested.
    %
    % Example
    %   builder = software.amazon.awssdk.services.s3.model.S3Object.builder();
    %   builder = builder.key("folder/file.txt").size(int64(42));
    %   javaObj = builder.storageClass( ...
    %       software.amazon.awssdk.services.s3.model.StorageClass.STANDARD).build();
    %   obj = aws.s3.model.S3Object(javaObj);
    %   fprintf("Key: %s, Size: %d bytes\n", obj.key, obj.size);
    %
    % Notes
    %   Owner information is only populated when the listObjects request asks
    %   for ownership details, and storageClass may be empty for STANDARD objects.

    % Copyright 2025 The MathWorks, Inc.

    properties
        checksumTypeAsString string
        eTag string
        size double
        storageClassAsString string
        lastModified datetime
        key string
        owner aws.s3.model.Owner
    end

    methods
        function obj = S3Object(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.S3Object')
                obj.Handle = varargin{1};
                obj.checksumTypeAsString = varargin{1}.checksumTypeAsString();
                obj.eTag = varargin{1}.eTag();
                obj.size = varargin{1}.size();
                obj.key = varargin{1}.key();
                obj.owner = aws.s3.model.Owner(varargin{1}.owner());
                obj.storageClassAsString = varargin{1}.storageClassAsString();
                millis = obj.Handle.lastModified().toEpochMilli();
                obj.lastModified = datetime(double(millis)/1000, 'ConvertFrom','posixtime', 'TimeZone','UTC');

            elseif nargin == 1 && isstruct(varargin{1})

                builder = software.amazon.awssdk.services.s3.model.S3Object.builder();
                obj.Handle = aws.internal.builder.build(builder, varargin{1});
                obj.eTag = obj.Handle.eTag();
                obj.size = obj.Handle.size();
                obj.key = obj.Handle.key();
                obj.owner = aws.s3.model.Owner(obj.Handle.owner());
                obj.storageClassAsString = obj.Handle.storageClassAsString();
                millis = obj.Handle.lastModified().toEpochMilli();
                obj.lastModified = datetime(double(millis)/1000, 'ConvertFrom','posixtime', 'TimeZone','UTC');

            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments for S3Object');
            end
        end
    end
end
