classdef Grant < aws.Object
    % GRANT Represents a single S3 ACL grant.
    %
    % Syntax
    %   grant = aws.s3.model.Grant(javaGrant);
    %   grant = aws.s3.model.Grant(struct(grantee=granteeObj, permission="READ"));

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = Grant(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.Grant')
                obj.Handle = varargin{1};

            elseif nargin == 1 && isstruct(varargin{1})

                ownerBuilder = software.amazon.awssdk.services.s3.model.Grant.builder();
                obj.Handle = aws.internal.builder.build(ownerBuilder, varargin{1});

            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end
    end
end
