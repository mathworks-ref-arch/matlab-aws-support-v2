classdef CopyObjectResponse < aws.Object
    %COPYOBJECTRESPONSE MATLAB wrapper for software.amazon.awssdk.services.s3.model.CopyObjectResponse.
    %
    % Syntax
    %   resp = aws.s3.model.CopyObjectResponse(javaResponse);
    %
    % Properties
    %   eTag                    - (string) Entity tag of the new object.
    %   lastModified            - (datetime) UTC timestamp when the copy completed.
    %   versionId               - (string) Version identifier assigned to the new object.
    %   copySourceVersionId     - (string) Version of the source object that was copied.
    %   requestCharged          - (string) Indicates whether the requester was charged.
    %   serverSideEncryption    - (string) SSE algorithm used for the destination object.
    %   sseCustomerAlgorithm    - (string) Algorithm for SSE-C (if used).
    %   sseCustomerKeyMD5       - (string) MD5 of the SSE-C key.
    %   ssekmsKeyId             - (string) AWS KMS key ARN used for encryption.
    %   ssekmsEncryptionContext - (string) SSE-KMS encryption context.
    %   bucketKeyEnabled        - (logical) True when S3 Bucket Keys were used.
    %
    % Example
    %   resp = s3.copyObject(...);
    %   fprintf("Copied version %s (ETag %s)\\n", resp.versionId, resp.eTag);

    % Copyright 2025 The MathWorks, Inc.

    properties
        eTag string
        lastModified datetime
        versionId string
        copySourceVersionId string
        requestCharged string
        serverSideEncryption string
        sseCustomerAlgorithm string
        sseCustomerKeyMD5 string
        ssekmsKeyId string
        ssekmsEncryptionContext string
        bucketKeyEnabled logical
    end

    methods
        function obj = CopyObjectResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.CopyObjectResponse')
                obj.Handle = varargin{1};

                % ETag
                if ~isempty(varargin{1}.copyObjectResult()) && ~isempty(varargin{1}.copyObjectResult().eTag())
                    obj.eTag = string(varargin{1}.copyObjectResult().eTag());
                end
                % LastModified
                if ~isempty(varargin{1}.copyObjectResult()) && ~isempty(varargin{1}.copyObjectResult().lastModified())
                    jLastMod = varargin{1}.copyObjectResult().lastModified();
                    epochMilli = jLastMod.toEpochMilli();
                    obj.lastModified = datetime(epochMilli/1000, 'ConvertFrom', 'posixtime', 'TimeZone', 'UTC');
                end
                % VersionId
                if ~isempty(varargin{1}.versionId())
                    obj.versionId = string(varargin{1}.versionId());
                end
                % CopySourceVersionId
                if ~isempty(varargin{1}.copySourceVersionId())
                    obj.copySourceVersionId = string(varargin{1}.copySourceVersionId());

                end
                % RequestCharged
                if ~isempty(varargin{1}.requestCharged())
                    obj.requestCharged = string(varargin{1}.requestCharged().toString());
                end
                % ServerSideEncryption
                if ~isempty(varargin{1}.serverSideEncryption())
                    obj.serverSideEncryption = string(varargin{1}.serverSideEncryption().toString());
                end
                % SSECustomerAlgorithm
                if ~isempty(varargin{1}.sseCustomerAlgorithm())
                    obj.sseCustomerAlgorithm = string(varargin{1}.sseCustomerAlgorithm());
                end
                % SSECustomerKeyMD5
                if ~isempty(varargin{1}.sseCustomerKeyMD5())
                    obj.sseCustomerKeyMD5 = string(varargin{1}.sseCustomerKeyMD5());
                end
                % SSEKMSKeyId
                if ~isempty(varargin{1}.ssekmsKeyId())
                    obj.ssekmsKeyId = string(varargin{1}.ssekmsKeyId());
                end
                % SSEKMSEncryptionContext
                if ~isempty(varargin{1}.ssekmsEncryptionContext())
                    obj.ssekmsEncryptionContext = string(varargin{1}.ssekmsEncryptionContext());
                end
                % BucketKeyEnabled
                if ~isempty(varargin{1}.bucketKeyEnabled())
                    obj.bucketKeyEnabled = varargin{1}.bucketKeyEnabled();
                end
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
