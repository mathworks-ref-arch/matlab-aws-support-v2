classdef Field < aws.Object
    % FIELD Wrapper for software.amazon.awssdk.services.redshiftdata.model.Field.
    %
    % Syntax
    %   f = aws.redshiftdata.model.Field(javaField);
    %
    % Properties
    %   value         - MATLAB representation (string/double/int64/logical/uint8/[]).
    %   stringValue   - (string) String representation when present.
    %   longValue     - (int64) Integer representation.
    %   doubleValue   - (double) Floating-point representation.
    %   booleanValue  - (logical) Boolean representation.
    %   blobValue     - (uint8 vector) Binary payload.
    %   isNull        - (logical) True when the field represents NULL.

    % Copyright 2025 The MathWorks, Inc.

    properties
        value
        stringValue string = ""
        longValue int64 = int64(0)
        doubleValue double = NaN
        booleanValue logical = false
        blobValue uint8 = uint8([])
        isNull logical = false
    end

    methods
        function obj = Field(varargin)
            if nargin == 1 && isa(varargin{1}, ...
                    'software.amazon.awssdk.services.redshiftdata.model.Field')
                fieldJ = varargin{1};
                obj.Handle = fieldJ;
                obj.populateFromHandle(fieldJ);
            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end

        function populateFromHandle(obj, fieldJ)
            if fieldJ.isNull()
                obj.isNull = true;
                obj.value = [];
                return
            end

            if ~isempty(fieldJ.stringValue())
                obj.stringValue = string(fieldJ.stringValue());
                obj.value = obj.stringValue;
            elseif ~isempty(fieldJ.booleanValue())
                obj.booleanValue = logical(fieldJ.booleanValue());
                obj.value = obj.booleanValue;
            elseif ~isempty(fieldJ.longValue())
                obj.longValue = int64(fieldJ.longValue().longValue());
                obj.value = obj.longValue;
            elseif ~isempty(fieldJ.doubleValue())
                obj.doubleValue = double(fieldJ.doubleValue());
                obj.value = obj.doubleValue;
            elseif ~isempty(fieldJ.blobValue())
                byteBuffer = fieldJ.blobValue();
                obj.blobValue = typecast(byteBuffer.array(), 'uint8');
                obj.value = obj.blobValue;
            else
                obj.value = [];
            end
        end

        function out = getValue(obj)
            % GETVALUE Return the best-effort MATLAB value.
            out = obj.value;
        end
    end
end
