classdef DeleteObjectResponse < aws.Object
    %DELETEOBJECTRESPONSE MATLAB wrapper for the AWS SDK DeleteObject response.
    %
    % Syntax
    %   resp = aws.s3.model.DeleteObjectResponse(javaResponse);
    %
    % Properties
    %   deleteMarker    - (logical) True when the response represents a delete marker.
    %   versionId       - (string) Version identifier that was deleted (if any).
    %   requestCharged  - (string) Indicates whether the requester was charged.
    %
    % Example
    %   resp = s3.deleteObject(bucket="matlab-demo-bucket", key="path/to/key");
    %   fprintf("Version %s removed (marker=%d)\\n", resp.versionId, resp.deleteMarker);

    % Copyright 2025 The MathWorks, Inc.

    properties
        deleteMarker logical
        versionId string
        requestCharged string
    end

    methods
        function obj = DeleteObjectResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.DeleteObjectResponse')
                obj.Handle = varargin{1};

                obj.deleteMarker = varargin{1}.deleteMarker();
                obj.versionId = string(varargin{1}.versionId());
                obj.requestCharged = string(varargin{1}.requestChargedAsString());

            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
