function listBucketsResponse = listBuckets(obj)
% LISTBUCKETS Retrieve all Amazon S3 buckets in the account.
%
% Syntax
%   resp = s3.listBuckets();
%
% Returns
%   listBucketsResponse - aws.s3.model.ListBucketsResponse containing bucket details.
%
% Example
%   s3 = aws.s3.Client();
%   resp = s3.listBuckets();
%   disp(resp.buckets);

% Copyright 2025 The MathWorks, Inc.

write(obj.logObj, 'info', 'Listing Buckets in Simple Storage Service');

% Call the listBuckets method from the AWS SDK
responseJ = obj.Handle.listBuckets();

% Wrap the Java response in a MATLAB BucketListResponse object
listBucketsResponse = aws.s3.model.ListBucketsResponse(responseJ);
write(obj.logObj, 'info', 'Retrieved Bucket List from Simple Storage Service');

end
