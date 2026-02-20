classdef RequestBody < aws.Object
    % REQUESTBODY MATLAB wrapper for software.amazon.awssdk.core.sync.RequestBody.
    %
    % Syntax
    %   rb = aws.core.model.RequestBody("Hello world");      % string payload
    %   rb = aws.core.model.RequestBody("payload.bin");      % file on disk
    %   rb = aws.core.model.RequestBody(uint8([1 2 3]));     % byte array
    %   rb = aws.core.model.RequestBody(javaRequestBodyObj); % existing SDK object
    %
    % The constructor inspects the input and creates the appropriate AWS SDK
    % RequestBody (string, bytes, or file). Use this helper whenever an AWS
    % client method expects a RequestBody instance.

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = RequestBody(varargin)
            import software.amazon.awssdk.core.sync.RequestBody

            if nargin == 1 && isa(varargin{1}, 'software.amazon.awssdk.core.sync.RequestBody')
                % Wrap existing Java RequestBody
                obj.Handle = varargin{1};

            elseif nargin == 1 && (isStringScalar(varargin{1}) || ischar(varargin{1}))
                payload = char(varargin{1});
                if obj.isValidFile(payload)
                    obj.Handle = RequestBody.fromFile(java.io.File(payload));
                else
                    obj.Handle = RequestBody.fromString(payload);
                end

            elseif nargin == 1 && (isa(varargin{1}, 'uint8') || isa(varargin{1}, 'int8'))
                bytes = varargin{1};
                if isa(bytes,'int8')
                    bytes = typecast(bytes,'uint8');
                end
                obj.Handle = RequestBody.fromBytes(bytes);

            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments for RequestBody');
            end
        end

        function tf = isValidFile(~, filePath)
            % ISVALIDFILE Checks if the given input is a valid path to a file.
            tf = false;
            if ischar(filePath) || isstring(filePath)
                filePath = char(filePath);
                tf = exist(filePath, 'file') == 2;
            end
        end
    end
end
