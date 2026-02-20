classdef PutObjectResponse < aws.Object
    %PUTOBJECTRESPONSE MATLAB wrapper for software.amazon.awssdk.services.s3.model.PutObjectResponse.
    %
    % Syntax
    %   resp = aws.s3.model.PutObjectResponse(javaResponse);
    %
    % Properties
    %   eTag                  - (string) Entity tag assigned to the object.
    %   versionId             - (string) Version identifier (when versioning is enabled).
    %   expiration            - (string) Expiration configuration header.
    %   serverSideEncryption  - (string) SSE algorithm used by S3.
    %   sseCustomerAlgorithm  - (string) Customer-provided SSE algorithm, when applicable.
    %   sseCustomerKeyMD5     - (string) MD5 of the customer-provided SSE key.
    %   ssekmsKeyId           - (string) AWS KMS key ARN used for encryption.
    %   ssekmsEncryptionContext - (string) Optional SSE-KMS encryption context.
    %   bucketKeyEnabled      - (logical) True when S3 Bucket Keys were used.
    %   requestCharged        - (string) Indicates if the requester was charged.
    %   size                  - (double) Size of the uploaded payload, when provided by the SDK.
    %
    % Example
    %   resp = s3.putObject(...);
    %   fprintf("ETag: %s\\n", resp.eTag);

    % Copyright 2025 The MathWorks, Inc.

    properties
        eTag string
        versionId string
        expiration string
        serverSideEncryption string
        sseCustomerAlgorithm string
        sseCustomerKeyMD5 string
        ssekmsKeyId string
        ssekmsEncryptionContext string
        bucketKeyEnabled logical
        requestCharged string
        size double
    end

    methods
        function obj = PutObjectResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.PutObjectResponse')
                obj.Handle = varargin{1};
                obj.eTag                   = string(varargin{1}.eTag());
                obj.versionId              = string(varargin{1}.versionId());
                obj.expiration             = string(varargin{1}.expiration());
                obj.serverSideEncryption   = string(varargin{1}.serverSideEncryptionAsString());
                obj.sseCustomerAlgorithm   = string(varargin{1}.sseCustomerAlgorithm());
                obj.sseCustomerKeyMD5      = string(varargin{1}.sseCustomerKeyMD5());
                obj.ssekmsKeyId            = string(varargin{1}.ssekmsKeyId());
                obj.ssekmsEncryptionContext= string(varargin{1}.ssekmsEncryptionContext());
                obj.bucketKeyEnabled       = varargin{1}.bucketKeyEnabled();
                obj.requestCharged         = string(varargin{1}.requestChargedAsString());
                obj.size                   = varargin{1}.size();
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
