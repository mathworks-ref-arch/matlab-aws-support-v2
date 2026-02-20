function listObjectsResponse = listObjects(obj, options)
% LISTOBJECTS List objects within an S3 bucket.
%
% Syntax
%   resp = s3.listObjects(bucket="<bucket>");
%   resp = s3.listObjects(bucket="<bucket>", prefix="photos/", delimiter="/");
%
% Name-Value Arguments
%   bucket             - (string, required) Bucket to enumerate.
%   prefix             - (string) Restrict results to keys that begin with this prefix.
%   delimiter          - (string) Character used to group keys hierarchically.
%   maxKeys            - (double) Maximum number of keys to return (up to 1000).
%   continuationToken  - (string) Token from a prior response for pagination.
%
% Returns
%   listObjectsResponse - aws.s3.model.ListObjectsResponse containing objects and pagination hints.
%
% Example
%   s3 = aws.s3.Client();
%   resp = s3.listObjects(bucket="my-bucket", prefix="photos/");
%   keys = arrayfun(@(obj) obj.key, resp.s3Objects);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.bucket (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.prefix string
    options.delimiter string
    options.maxKeys double
    options.continuationToken string
end

write(obj.logObj, 'info', 'Listing objects in Simple Storage Service');


% Create a ListObjectRquest builder
listObjectsRequestBuilder = software.amazon.awssdk.services.s3.model.ListObjectsRequest.builder();

% Create the listObject
listObjectsRequest = aws.internal.builder.build(listObjectsRequestBuilder,options);

% Call the listObjects method from the AWS SDK
responseJ = obj.Handle.listObjects(listObjectsRequest);

% Wrap the Java response in a MATLAB ListObjectsResponse object
listObjectsResponse = aws.s3.model.ListObjectsResponse(responseJ);
write(obj.logObj, 'info', 'Listed objects in Simple Storage Service');

end
