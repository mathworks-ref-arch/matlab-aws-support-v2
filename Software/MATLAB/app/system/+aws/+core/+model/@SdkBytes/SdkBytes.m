classdef SdkBytes < aws.Object
    % SDKBYTES MATLAB wrapper for software.amazon.awssdk.core.SdkBytes.
    %
    % Syntax
    %   bytes = aws.core.model.SdkBytes("plain text");
    %   bytes = aws.core.model.SdkBytes("payload.zip"); % reads the file
    %   bytes = aws.core.model.SdkBytes(uint8([1 2 3]));
    %   bytes = aws.core.model.SdkBytes(javaBytes);
    %
    % The constructor inspects the input. Strings map to UTF-8 payloads unless
    % the value is a `.zip` file path, in which case the file is converted to
    % bytes. Numeric arrays are treated as raw bytes.

    % Copyright 2025 The MathWorks, Inc.

    methods
        function obj = SdkBytes(varargin)

            import java.nio.file.Files;
            import java.nio.file.Paths;

            if nargin == 1 && isa(varargin{1}, 'software.amazon.awssdk.core.SdkBytes')
                obj.Handle = varargin{1};

            elseif nargin == 1 && (isa(varargin{1},'uint8') || isa(varargin{1},'int8'))
                % Accept raw bytes
                bytes = varargin{1};
                if isa(bytes,'int8')
                    bytes = typecast(bytes,'uint8');
                end
                obj.Handle = software.amazon.awssdk.core.SdkBytes.fromByteArray(bytes);

            elseif nargin == 1 && (isStringScalar(varargin{1}) || ischar(varargin{1}))

                if obj.isValidFile(varargin{1})
                    fid = fopen(varargin{1}, 'rb');
                    fileBytes = fread(fid, Inf, '*uint8'); 
                    fclose(fid);
                    obj.Handle = software.amazon.awssdk.core.SdkBytes.fromByteArray(fileBytes);
                else
                    obj.Handle = software.amazon.awssdk.core.SdkBytes.fromUtf8String(varargin{1});
                end

            else
                logObj = Logger.getLogger();
                write(logObj,'error', 'Invalid arguments');
            end
        end

        function isValid = isValidFile(~, filePath)
            isValid = exist(filePath, 'file') == 2;
        end
    end
end

