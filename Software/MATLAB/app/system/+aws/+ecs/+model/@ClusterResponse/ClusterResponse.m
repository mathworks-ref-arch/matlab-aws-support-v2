classdef ClusterResponse < aws.Object
    % CLUSTERRESPONSE MATLAB wrapper for ECS cluster responses.
    %
    % Syntax
    %   resp = aws.ecs.model.ClusterResponse(javaResponse);
    %
    % Properties
    %   clusterArn - (string) ARN of the affected cluster.

    % Copyright 2025 The MathWorks, Inc.

    properties
        clusterArn string
    end

    methods
        function obj = ClusterResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ecs.model.CreateClusterResponse')
                obj.Handle = varargin{1};
                obj.clusterArn = varargin{1}.cluster.clusterArn;
            elseif nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.ecs.model.DeleteClusterResponse')
                obj.Handle = varargin{1};
                obj.clusterArn = varargin{1}.cluster.clusterArn;
            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end
    end
end

