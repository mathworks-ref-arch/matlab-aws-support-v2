classdef Bucket < aws.Object
    % BUCKET MATLAB wrapper for S3 bucket metadata.
    %
    % Syntax
    %   b = aws.s3.model.Bucket(javaBucket);
    %   b = aws.s3.model.Bucket(struct(name="my-bucket"));
    %
    % Properties
    %   bucketArn     - (string) ARN when returned by supporting APIs.
    %   bucketRegion  - (string) Region reported by newer APIs.
    %   name          - (string) Bucket name.
    %   creationDate  - (datetime) UTC creation timestamp.

    % Copyright 2025 The MathWorks, Inc.

    properties
        bucketArn
        bucketRegion
        name
        creationDate
    end

    methods
        function obj = Bucket(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.Bucket')
                obj.Handle = varargin{1};
                obj.bucketArn = varargin{1}.bucketArn();
                obj.bucketRegion = varargin{1}.bucketRegion();
                obj.name = varargin{1}.name();
                millis = obj.Handle.creationDate().toEpochMilli();
                obj.creationDate = datetime(double(millis)/1000, 'ConvertFrom','posixtime', 'TimeZone','UTC');

            elseif nargin == 1 && isstruct(varargin{1})
                builder = software.amazon.awssdk.services.s3.model.Bucket.builder();
                obj.Handle = aws.internal.builder.build(builder, varargin{1});
                obj.bucketArn = obj.Handle.bucketArn();
                obj.bucketRegion = obj.Handle.bucketRegion();
                obj.name = obj.Handle.name();
                millis = obj.Handle.creationDate().toEpochMilli();
                obj.creationDate = datetime(double(millis)/1000, 'ConvertFrom','posixtime', 'TimeZone','UTC');

            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments for Bucket');
            end
        end
    end
end
