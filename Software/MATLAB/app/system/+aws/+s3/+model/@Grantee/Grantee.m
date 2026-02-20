classdef Grantee < aws.Object
    % GRANTEE Represents the subject of an S3 ACL grant.
    %
    % Syntax
    %   g = aws.s3.model.Grantee(javaGrantee);
    %   g = aws.s3.model.Grantee(struct(id="1234", type="CanonicalUser"));

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = Grantee(varargin)

            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.Grantee')
                obj.Handle = varargin{1};

            elseif nargin == 1 && isstruct(varargin{1})

                granteeBuilder = software.amazon.awssdk.services.s3.model.Grantee.builder();
                obj.Handle = aws.internal.builder.build(granteeBuilder, varargin{1});

            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end
    end
end
