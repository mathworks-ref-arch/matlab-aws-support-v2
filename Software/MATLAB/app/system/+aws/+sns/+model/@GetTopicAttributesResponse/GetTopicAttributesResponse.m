classdef GetTopicAttributesResponse < aws.Object
    % GETTOPICATTRIBUTESRESPONSE MATLAB wrapper for topic attributes.
    %
    % Syntax
    %   resp = aws.sns.model.GetTopicAttributesResponse(javaResponse);
    %
    % Properties
    %   attributes - (dictionary) Map of attribute name -> value.
    %
    % Example
    %   resp = sns.getTopicAttributes(topicArn=arn);
    %   disp(resp.attributes("DisplayName"));

    % Copyright 2025 The MathWorks, Inc.

    properties
        attributes dictionary
    end

    methods
        function obj = GetTopicAttributesResponse(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.sns.model.GetTopicAttributesResponse')
                obj.Handle = varargin{1};
                % Convert Java Map to MATLAB containers.Map
                javaAttributesMap = varargin{1}.attributes();
                keys = javaAttributesMap.keySet().toArray();
                values = javaAttributesMap.values().toArray();
                obj.attributes = dictionary(string(keys), string(values));
            else
                write(obj.logObj, 'error', 'Invalid arguments');
            end
        end
    end
end
