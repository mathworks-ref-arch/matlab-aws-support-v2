classdef GetSubscriptionAttributesResponse < aws.Object
    % GETSUBSCRIPTIONATTRIBUTESRESPONSE MATLAB wrapper for subscription attributes.
    %
    % Syntax
    %   resp = aws.sns.model.GetSubscriptionAttributesResponse(javaResponse);
    %
    % Properties
    %   attributes - (dictionary) Map of attribute name -> value.
    %
    % Example
    %   resp = sns.getSubscriptionAttributes(subscriptionArn=arn);
    %   disp(resp.attributes("PendingConfirmation"));

    % Copyright 2025 The MathWorks, Inc.

    properties
        attributes dictionary
    end

    methods
        function obj = GetSubscriptionAttributesResponse(varargin)
            % Constructor for GetSubscriptionAttributesResponse
            if nargin == 1
                if ~isa(varargin{1}, 'software.amazon.awssdk.services.sns.model.GetSubscriptionAttributesResponse')
                    logObj = Logger.getLogger();
                    write(logObj, 'error', 'Argument not of type software.amazon.awssdk.services.sns.model.GetSubscriptionAttributesResponse');
                else
                    obj.Handle = varargin{1};
                    % Convert Java Map to MATLAB struct
                    obj.attributes = aws.internal.util.javaMapToDictionary(varargin{1}.attributes());
                end
            else
                logObj = Logger.getLogger();
                write(logObj, 'error', 'Invalid number of arguments');
            end
        end
    end
end
