classdef SecretListEntry < aws.Object
    %SECRETLISTENTRY Summary of this class goes here
    %   Detailed explanation goes here

    properties
        arn string
        description string
        kmsKeyId string
        name string
        createdDate datetime
    end

    methods
        function obj = SecretListEntry(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.secretsmanager.model.SecretListEntry')
                obj.Handle = varargin{1};
                obj.arn = varargin{1}.arn();
                obj.description = varargin{1}.description();
                obj.kmsKeyId = varargin{1}.kmsKeyId();
                obj.name = varargin{1}.name();
                obj.createdDate = aws.internal.util.javaInstantToDatetime(varargin{1}.createdDate());

            elseif nargin == 1 && isstruct(varargin{1})

                secretsBuilder = software.amazon.awssdk.services.secretsmanager.model.SecretListEntry.builder();
                obj.Handle = aws.internal.builder.build(secretsBuilder, varargin{1});

            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end
    end
end