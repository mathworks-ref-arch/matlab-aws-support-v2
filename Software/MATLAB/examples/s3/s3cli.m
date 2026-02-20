function s3cli(command, options)
    % s3_cli Command Line Interface for S3 operations
    % Usage:
    %   s3cli('list', 'your-bucket-name') - Lists files in the specified S3 bucket
    %   s3cli('download', 'your-bucket-name', 'file-to-download') - Downloads the specified file
    % Example:
    %  s3cli('list) -Lists all the buckets
    %  s3cli("download",bucketName="matlab-s3test-bucket-20250826224322515",key="hello2Copy.txt",directory="c:\temp\file1.txt")

    % Set AWS credentials (ensure these are set in your environment)
    % Validate input parameters

    % Copyright 2025 The MathWorks, Inc.
    
    arguments
        command 
        options.bucketName
        options.key
        options.directory
    end
    if nargin < 1
        error('Insufficient arguments. Usage: s3cli(command, bucketName, fileName)');
    end
    s3Client = aws.s3.Client();
  
    switch lower(command)
        case 'list'
            if isfield(options,"bucketName")
                listObjectResponse =s3Client.listObjects(bucket=options.bucketName);
                for index = 1:length(listObjectResponse.keys)
                    fprintf('File: %s\n', listObjectResponse.keys{index});
                end
            else
                listBucketRespone = s3Client.listBuckets();
                for index = 1:length(listBucketRespone.buckets)
                    fprintf('Bucket: %s\n', listBucketRespone.buckets{index});
                end
            end
        case 'download'
            if isfield(options, "key")
                [getObjectResponse, inputStream] = s3Client.getObject(bucket=options.bucketName, key=options.key);
                fprintf('Downloaded: %s from bucket: %s\n', options.key, options.bucketName);
                s3Client.saveS3ResponseInputStreamToFile(inputStream, options.directory);
            else
                error('Object name must be specified for download.');
            end
        
    end