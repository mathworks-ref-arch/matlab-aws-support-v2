classdef AccessControlPolicy < aws.Object
    % ACCESSCONTROLPOLICY Build an S3 access control policy (ACL).
    %
    % Syntax
    %   acp = aws.s3.model.AccessControlPolicy(owner=ownerObj, grants=grantCell);
    %
    % Name-Value Arguments
    %   owner  - (aws.s3.model.Owner, required) Owner of the object/bucket.
    %   grants - (cell array) Each cell contains an `aws.s3.model.Grant`.

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = AccessControlPolicy(options)
            arguments
                options.owner (1,1) aws.s3.model.Owner
                options.grants cell = {}
            end

            acpBuilder = software.amazon.awssdk.services.s3.model.AccessControlPolicy.builder();
            obj.Handle = aws.internal.builder.build(acpBuilder, options);
        end
    end
end
