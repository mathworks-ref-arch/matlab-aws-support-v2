classdef DeleteObjectsResponse < aws.Object
    % DELETEOBJECTSRESPONSE Wrapper for S3 DeleteObjects results.
    %
    % Syntax
    %   resp = aws.s3.model.DeleteObjectsResponse(javaResponse);
    %
    % Properties
    %   hasDeleted - (logical) True when the request returned deleted keys.
    %   hasErrors  - (logical) True when any keys failed to delete.

    % Copyright 2025 The MathWorks, Inc.

    properties
        hasDeleted logical
        hasErrors logical
        % objects aws.s3.model.S3Object
    end

    methods
        function obj = DeleteObjectsResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.DeleteObjectsResponse')
                obj.Handle = varargin{1};
                % deleteMarker (Boolean)
                obj.hasDeleted = varargin{1}.hasDeleted();
                obj.hasErrors = varargin{1}.hasErrors();

            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
