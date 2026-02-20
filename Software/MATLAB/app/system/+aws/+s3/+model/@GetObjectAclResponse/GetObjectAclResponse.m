classdef GetObjectAclResponse < aws.Object
    % GETOBJECTACLRESPONSE Wrapper for S3 GetObjectAcl results.
    %
    % Syntax
    %   resp = aws.s3.model.GetObjectAclResponse(javaResponse);
    %
    % Properties
    %   owner  - (aws.s3.model.Owner) Owner of the object.
    %   grants - (aws.s3.model.Grant array) Grants describing permissions.

    % Copyright 2025 The MathWorks, Inc.

    properties
        owner  aws.s3.model.Owner         % aws.s3.model.Owner
        grants aws.s3.model.Grant         % array of aws.s3.model.Grant
    end

    methods
        function obj = GetObjectAclResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.GetObjectAclResponse')
                obj.Handle = varargin{1};

                obj.owner = aws.s3.model.Owner(varargin{1}.owner());

                grantsJ = varargin{1}.grants();
                obj.grants = aws.s3.model.Grant.empty(1,0);
                if ~isempty(grantsJ)
                    for index = 1:grantsJ.size()
                        obj.grants(1, index) = aws.s3.model.Grant(grantsJ.get(index-1));
                    end
                end

            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
