classdef GetCallerIdentityResponse < aws.Object
    % GETCALLERIDENTITYRESPONSE Result returned by aws.sts.Client.getCallerIdentity.
    %
    % Syntax
    %   resp = aws.sts.model.GetCallerIdentityResponse(javaResponse);
    %
    % Properties
    %   accountId - (string) AWS account ID of the caller.
    %   arn       - (string) Full ARN (user or role) of the caller.
    %   userId    - (string) Unique identifier of the IAM user or role.
    %
    % Example
    %   resp = sts.getCallerIdentity();
    %   disp(resp.arn);

    % Copyright 2025 The MathWorks, Inc.

    properties
        accountId string = ""
        arn string = ""
        userId string = ""
    end

    methods
        function obj = GetCallerIdentityResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sts.model.GetCallerIdentityResponse')
                obj.Handle = varargin{1};
                if ~isempty(varargin{1}.account())
                    obj.accountId = string(varargin{1}.account());
                end
                if ~isempty(varargin{1}.arn())
                    obj.arn = string(varargin{1}.arn());
                end
                if ~isempty(varargin{1}.userId())
                    obj.userId = string(varargin{1}.userId());
                end
            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end
    end
end

