function deleteObjectsResponse = deleteObjects(obj, options)
% DELETEOBJECTS Delete multiple objects (or versions) from an S3 bucket.
%
% Syntax
%   resp = s3.deleteObjects(bucket="my-bucket", ...
%       objects=[aws.s3.model.S3Object(struct(key="logs/a.txt"))]);
%
% Name-Value Arguments
%   bucket  - (string, required) Name of the bucket that contains the objects.
%   objects - (array, required) Vector of `aws.s3.model.S3Object` entries whose
%             `key` (and optional version/eTag) identify objects to delete.
%
% Returns
%   deleteObjectsResponse - aws.s3.model.DeleteObjectsResponse reporting deleted keys.
%
% Example
%   targets = [aws.s3.model.S3Object(struct(key="data/file1.csv")), ...
%              aws.s3.model.S3Object(struct(key="data/file2.csv"))];
%   resp = s3.deleteObjects(bucket="archive-bucket", objects=targets);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.objects (1,:) aws.s3.model.S3Object
end

write(obj.logObj, 'info', 'Deleting Object in Simple Storage Service');


objectIdentifiers = javaArray('software.amazon.awssdk.services.s3.model.ObjectIdentifier', numel(options.objects));
cnt = 0;
for index = 1:numel(options.objects)
    objectIdentifierBuilder = software.amazon.awssdk.services.s3.model.ObjectIdentifier.builder();
    if ~isempty(options.objects(index).key)
        objectIdentifierBuilder.key(options.objects(index).key);
    end
    if ~isempty(options.objects(index).eTag)
        objectIdentifierBuilder.eTag(options.objects(index).eTag);
    end

    cnt = cnt + 1;
    objectIdentifiers(cnt) = objectIdentifierBuilder.build();

end

% Trim if any were skipped (not expected here)
if cnt < numel(objectIdentifiers)
    objectIdentifiers = objectIdentifiers(1:cnt);
end

% Build Delete and Request
deleteBuilder = software.amazon.awssdk.services.s3.model.Delete.builder();
deleteRequest = deleteBuilder.objects(objectIdentifiers).build();

deleteObjectsRequestBuilder = software.amazon.awssdk.services.s3.model.DeleteObjectsRequest.builder();
deleteObjectsRequest = deleteObjectsRequestBuilder.bucket(options.bucket).delete(deleteRequest).build();

% Execute
responseJ = obj.Handle.deleteObjects(deleteObjectsRequest);
deleteObjectsResponse = aws.s3.model.DeleteObjectsResponse(responseJ);
write(obj.logObj, 'info', 'Deleted Objects in Simple Storage Service');

end