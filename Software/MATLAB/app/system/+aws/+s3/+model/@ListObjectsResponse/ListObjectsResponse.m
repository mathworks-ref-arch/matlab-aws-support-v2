classdef ListObjectsResponse < aws.Object
    %LISTOBJECTSRESPONSE MATLAB wrapper for software.amazon.awssdk.services.s3.model.ListObjectsResponse.
    %
    % Syntax
    %   resp = aws.s3.model.ListObjectsResponse(javaResponse);
    %
    % Properties
    %   s3Objects - (1xN aws.s3.model.S3Object) Objects returned in the listing.
    %   name      - (string) Bucket name echoed by S3.
    %
    % Example
    %   resp = s3.listObjects(bucket="my-bucket");
    %   keys = arrayfun(@(obj) obj.key, resp.s3Objects);

    % Copyright 2025 The MathWorks, Inc.

    properties
        s3Objects (1,:) aws.s3.model.S3Object = aws.s3.model.S3Object.empty
        name string = ""
    end

    methods
        function obj = ListObjectsResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.ListObjectsResponse')
                obj.Handle = varargin{1};
                obj.name = string(obj.Handle.name());

                % Convert the list of buckets from Java to MATLAB data type
                s3ObjectsJ = obj.Handle.contents();

                s3ObjectsJListIterator = s3ObjectsJ.iterator;

                while s3ObjectsJListIterator.hasNext()
                    obj.s3Objects(end+1) = aws.s3.model.S3Object(s3ObjectsJListIterator.next()); %#ok<AGROW>
                end
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
