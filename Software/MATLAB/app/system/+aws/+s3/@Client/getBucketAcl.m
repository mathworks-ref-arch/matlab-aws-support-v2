function getBucketAclResponse = getBucketAcl(obj, options)
% GETBUCKETACL Retrieve the ACL for an Amazon S3 bucket.
%
% Syntax
%   resp = s3.getBucketAcl(bucket="<bucket>");
%
% Name-Value Arguments
%   bucket              - (string, required) Bucket whose ACL should be returned.
%   expectedBucketOwner - (string) AWS account ID you expect to own the bucket (optional safety check).
%
% Returns
%   getBucketAclResponse - aws.s3.model.GetBucketAclResponse containing owner and grant entries.
%
% Example
%   s3 = aws.s3.Client();
%   resp = s3.getBucketAcl(bucket="my-bucket");
%   disp(resp.owner.id);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.expectedBucketOwner string
end

write(obj.logObj, 'info', 'Retrieving bucket ACL from Simple Storage Service');

% Build the GetBucketAclRequest
getBucketAclRequestBuilder = software.amazon.awssdk.services.s3.model.GetBucketAclRequest.builder();

getBucketAclRequest = aws.internal.builder.build(getBucketAclRequestBuilder, options);

% Call the getBucketAcl method from the AWS SDK
responseJ = obj.Handle.getBucketAcl(getBucketAclRequest);

% Wrap the Java response in a MATLAB BucketAclResponse object
getBucketAclResponse = aws.s3.model.GetBucketAclResponse(responseJ);
write(obj.logObj, 'info', 'Retrieved bucket ACL from Simple Storage Service');

end
