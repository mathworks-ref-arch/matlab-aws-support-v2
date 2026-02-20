classdef GetBucketAclResponse < aws.Object
    %GETBUCKETACLRESPONSE MATLAB wrapper for software.amazon.awssdk.services.s3.model.GetBucketAclResponse.
    %
    % Syntax
    %   resp = aws.s3.model.GetBucketAclResponse(javaResponse);
    %
    % Properties
    %   owner  - (aws.s3.model.Owner) Bucket owner metadata.
    %   grants - (1xN aws.s3.model.Grant) Collection of grant entries defining ACL permissions.
    %
    % Example
    %   resp = s3.getBucketAcl(bucket="my-bucket");
    %   disp(resp.owner.id);

    % Copyright 2025 The MathWorks, Inc.

    properties
        owner aws.s3.model.Owner
        grants (1,:) aws.s3.model.Grant = aws.s3.model.Grant.empty
    end

    methods
        function obj = GetBucketAclResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.GetBucketAclResponse')
                obj.Handle = varargin{1};

                % Owner
                obj.owner = aws.s3.model.Owner(varargin{1}.owner());

                % Grants (Java List)
                grantsJ = varargin{1}.grants();
                if ~isempty(grantsJ)
                    for index = 1:grantsJ.size()
                        obj.grants(end+1) = aws.s3.model.Grant(grantsJ.get(index-1)); %#ok<AGROW>
                    end
                end

            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
