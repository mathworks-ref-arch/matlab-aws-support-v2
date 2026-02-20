function putObjectAclResponse = putObjectAcl(obj, options)
% PUTOBJECTACL Set the ACL for a single S3 object.
%
% Syntax
%   resp = s3.putObjectAcl(bucket="my-bucket", key="docs/report.pdf", acl="public-read");
%
% Name-Value Arguments
%   bucket              - (string, required) Bucket containing the object.
%   key                 - (string, required) Object key.
%   acl                 - (string) Canned ACL (e.g., "private", "public-read").
%   accessControlPolicy - (aws.s3.model.AccessControlPolicy | Java AccessControlPolicy) Custom ACL definition.
%   grantFullControl    - (string) Grant header for full control permissions.
%   grantRead           - (string) Grant header for READ permission.
%   grantReadACP        - (string) Grant header for READ_ACP permission.
%   grantWrite          - (string) Grant header for WRITE permission (rare).
%   grantWriteACP       - (string) Grant header for WRITE_ACP permission.
%   requestPayer        - (string) Set to `"requester"` for requester-pays buckets.
%   versionId           - (string) Version ID when targeting a specific object version.
%   expectedBucketOwner - (string) AWS account ID to validate bucket ownership.
%
% Returns
%   putObjectAclResponse - aws.s3.model.PutObjectAclResponse reporting status metadata.
%
% Example
%   s3 = aws.s3.Client();
%   resp = s3.putObjectAcl(bucket="media-bucket", key="public/logo.png", acl="public-read");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.key (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.acl string
    options.accessControlPolicy
    options.grantFullControl
    options.grantRead
    options.grantReadACP
    options.grantWrite
    options.grantWriteACP
    options.requestPayer
    options.versionId
    options.expectedBucketOwner
end

write(obj.logObj, 'info', 'Setting object ACL in Simple Storage Service');

% Create a PutObjectAclRequest builder
putObjectAclRequestBuilder = software.amazon.awssdk.services.s3.model.PutObjectAclRequest.builder();

% Prepare options for builder utility
builderOptions = options;

% Handle AccessControlPolicy if provided as MATLAB wrapper
if isfield(options, 'accessControlPolicy') && ~isempty(options.accessControlPolicy)
    if isa(options.accessControlPolicy, 'aws.s3.model.AccessControlPolicy')
        builderOptions.accessControlPolicy = options.accessControlPolicy.Handle;

    else
        error('accessControlPolicy must be an aws.s3.model.AccessControlPolicy or a Java AccessControlPolicy object.');
    end
end

% Build the request using the internal builder utility
putObjectAclRequest = aws.internal.builder.build(putObjectAclRequestBuilder, builderOptions);

% Call the putObjectAcl method from the AWS SDK
responseJ = obj.Handle.putObjectAcl(putObjectAclRequest);

% Wrap the Java response in a MATLAB PutObjectAclResponse object
putObjectAclResponse = aws.s3.model.PutObjectAclResponse(responseJ);
write(obj.logObj, 'info', 'Set object ACL in Simple Storage Service');

end