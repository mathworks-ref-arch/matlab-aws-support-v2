classdef Owner < aws.Object
    % OWNER Represents the owner of an S3 bucket or object.
    %
    % Syntax
    %   o = aws.s3.model.Owner(javaOwner);
    %   o = aws.s3.model.Owner(struct(id="1234", displayName="me"));

    % Copyright 2025 The MathWorks, Inc.

    properties
        id string
    end

    methods
        function obj = Owner(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.s3.model.Owner')
                obj.Handle = varargin{1};
                obj.id = obj.Handle.id;

            elseif nargin == 1 && isstruct(varargin{1})

                ownerBuilder = software.amazon.awssdk.services.s3.model.Owner.builder();
                obj.Handle = aws.internal.builder.build(ownerBuilder, varargin{1});
                obj.id = obj.Handle.id;

            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end
    end
end
