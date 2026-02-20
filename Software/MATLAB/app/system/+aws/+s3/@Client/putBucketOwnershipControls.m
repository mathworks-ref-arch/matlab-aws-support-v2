function putBucketOwnershipControlsResponse = putBucketOwnershipControls(obj, options)
% PUTBUCKETOWNERSHIPCONTROLS Configure Object Ownership settings for a bucket.
%
% Syntax
%   resp = s3.putBucketOwnershipControls(bucket="<bucket>", objectOwnership="BucketOwnerPreferred");
%
% Name-Value Arguments
%   bucket              - (string, required) Bucket name.
%   objectOwnership     - (string, required) One of "BucketOwnerPreferred", "ObjectWriter",
%                         or "BucketOwnerEnforced".
%   expectedBucketOwner - (string) AWS account ID expected to own the bucket.
%
% Returns
%   putBucketOwnershipControlsResponse - aws.s3.model.PutBucketOwnershipControlsResponse containing
%                                        HTTP status information.
%
% Notes
%   "BucketOwnerEnforced" disables ACLs; the owner automatically owns every object.
%
% Example
%   s3 = aws.s3.Client();
%   resp = s3.putBucketOwnershipControls(bucket="my-bucket", objectOwnership="BucketOwnerPreferred");

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.objectOwnership (1,1) string ...
        {mustBeMember(options.objectOwnership, ...
        ["BucketOwnerPreferred","ObjectWriter","BucketOwnerEnforced"])}
    options.expectedBucketOwner (1,1) string {mustBeTextScalar} = ""
end

write(obj.logObj, 'info', 'Setting bucket ownership controls in Simple Storage Service');

import software.amazon.awssdk.services.s3.model.PutBucketOwnershipControlsRequest
import software.amazon.awssdk.services.s3.model.OwnershipControls
import software.amazon.awssdk.services.s3.model.OwnershipControlsRule
import software.amazon.awssdk.services.s3.model.ObjectOwnership

% Map MATLAB string to AWS enum
switch string(options.objectOwnership)
    case "BucketOwnerPreferred"
        ooEnum = ObjectOwnership.BUCKET_OWNER_PREFERRED;
    case "ObjectWriter"
        ooEnum = ObjectOwnership.OBJECT_WRITER;
    case "BucketOwnerEnforced"
        ooEnum = ObjectOwnership.BUCKET_OWNER_ENFORCED;
end
% Build the OwnershipControls with a single rule
rule = OwnershipControlsRule.builder() ...
    .objectOwnership(ooEnum) ...
    .build();
rules = java.util.Collections.singletonList(rule);
oc = OwnershipControls.builder().rules(rules).build();

% Build the PutBucketOwnershipControlsRequest
builder = PutBucketOwnershipControlsRequest.builder() ...
    .bucket(char(options.bucket)) ...
    .ownershipControls(oc);

if strlength(options.expectedBucketOwner) > 0
    builder = builder.expectedBucketOwner(char(options.expectedBucketOwner));
end

req = builder.build();

% Call the SDK
responseJ = obj.Handle.putBucketOwnershipControls(req);

% Wrap in MATLAB model
putBucketOwnershipControlsResponse = ...
    aws.s3.model.PutBucketOwnershipControlsResponse(responseJ);

write(obj.logObj, 'info', 'Set bucket ownership controls in Simple Storage Service');

end
