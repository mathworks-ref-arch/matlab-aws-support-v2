classdef ListBucketsResponse < aws.Object
    %LISTBUCKETSRESPONSE MATLAB wrapper for software.amazon.awssdk.services.s3.model.ListBucketsResponse.
    %
    % Syntax
    %   resp = aws.s3.model.ListBucketsResponse(javaResponse);
    %
    % Properties
    %   buckets - (1xN aws.s3.model.Bucket) Array of bucket metadata objects.
    %
    % Example
    %   resp = s3.listBuckets();
    %   bucketNames = arrayfun(@(b) b.name, resp.buckets);

    % Copyright 2025 The MathWorks, Inc.

    properties
        buckets (1,:) aws.s3.model.Bucket
    end

    methods
        function obj = ListBucketsResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.ListBucketsResponse')
                obj.Handle = varargin{1};
                % Convert the list of buckets from Java to MATLAB data type
                bucketsJ = obj.Handle.buckets();

                bucketsJListIterator = bucketsJ.iterator;

                while bucketsJListIterator.hasNext()
                    obj.buckets(end+1) = aws.s3.model.Bucket(bucketsJListIterator.next()); %#ok<AGROW>
                end

            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
