function [headObjectResponse, doesExist] = headObject(obj, options)
% HEADOBJECT Retrieve metadata for an S3 object without downloading it.
%
% Syntax
%   [resp, exists] = s3.headObject(bucket="<bucket>", key="<key>");
%
% Name-Value Arguments (subset of HeadObjectRequest fields)
%   bucket               - (string, required) Bucket name.
%   key                  - (string, required) Object key.
%   ifMatch              - (string) Return metadata only if ETag matches.
%   ifModifiedSince      - (datetime | java.time.Instant) Conditional header.
%   ifNoneMatch          - (string) Return metadata only if ETag differs.
%   ifUnmodifiedSince    - (datetime | java.time.Instant) Conditional header.
%   partNumber           - (double) Part number for multipart objects.
%   range                - (string) HTTP range header.
%   requestPayer         - (string) Specify `"requester"` when requester pays.
%   sseCustomerAlgorithm - (string) Algorithm used for SSE-C.
%   sseCustomerKey       - (string) Base64-encoded key for SSE-C.
%   sseCustomerKeyMD5    - (string) MD5 hash of the SSE-C key.
%   versionId            - (string) Specific object version to probe.
%   expectedBucketOwner  - (string) AWS account ID expected to own the bucket.
%   checksumMode         - (string) Enable extended checksum validation when supported.
%
% Returns
%   headObjectResponse - aws.s3.model.HeadObjectResponse populated with object metadata.
%   doesExist          - logical scalar indicating whether the object exists (true on success).
%
% Example
%   s3 = aws.s3.Client();
%   [resp, exists] = s3.headObject(bucket="matlab-demo-bucket", key="logs/output.json");
%   assert(exists, "Object missing");
%   disp(resp.contentType);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.key (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.ifMatch string
    options.ifModifiedSince
    options.ifNoneMatch string
    options.ifUnmodifiedSince
    options.partNumber double
    options.range string
    options.requestPayer
    options.sseCustomerAlgorithm string
    options.sseCustomerKey string
    options.sseCustomerKeyMD5 string
    options.versionId string
    options.expectedBucketOwner string
    options.checksumMode
end

write(obj.logObj, 'info', 'Retrieving object metadata in Simple Storage Service');

% Create a head object request builder
headObjectRequestBuilder = software.amazon.awssdk.services.s3.model.HeadObjectRequest.builder();

% Build the request using the internal builder utility
headObjectRequest = aws.internal.builder.build(headObjectRequestBuilder, options);

% Call the headObject method from the AWS SDK
responseJ = obj.Handle.headObject(headObjectRequest);

% Wrap the Java response in a MATLAB HeadObjectResponse object
headObjectResponse = aws.s3.model.HeadObjectResponse(responseJ);
write(obj.logObj, 'info', 'Retrieved object metadata from Simple Storage Service');
doesExist = true;

end
