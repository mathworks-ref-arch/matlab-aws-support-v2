function zipFileName = createCustomRuntimeZip(functionName, args)
% CREATECUSTOMRUNTIME (Linux Only) creates an AWS Lambda function Custom Runtime
% as a zip file containing the MATLAB executable.

% Copyright 2025 The MathWorks, Inc.

% Check if the operating system is Windows
if ispc
    error(['AWS Lambda custom runtimes are only supported on Amazon Linux. ', ...
        'Please use a Linux-based operating system to create the runtime.']);
end

% Add the parent directory containing mMod to MATLAB path
addpath('./functions');
% Define the configuration for code generation
cfg = coder.config('lib'); % Use 'lib' instead of 'exe' to generate only C code

% Generate code
codegen('-config', cfg, functionName, '-args', args);
fprintf('C code generation successful.\n');


funcC = ['./codegen/lib/' functionName '/' functionName '.h'];
funcCFile = fullfile(pwd, funcC);

generateMainCFromHeader(funcCFile);

% Define the configuration for code generation
cfg = coder.config('exe');
cfg.CustomSource = 'main.c';
cfg.CustomInclude = './lambda-custom-runtime';
cfg.PostCodeGenCommand = 'buildInfo.addLinkFlags("-static")';
executableBinaryName = 'matlabFunction';
zipFileName = ['matlab-' functionName '-lambda.zip'];

% Generate code
try
    codegen('-config', cfg, functionName, '-args', args, '-o', executableBinaryName);
    fprintf('Code generation successful. Output file: %s\n', executableBinaryName);
catch ME
    error('Error during code generation: %s\n', ME.message);
end

% Set permissions for generated executable
setPermission(executableBinaryName, '755');

% Handle necessary files
try
    handleFileOperations();
catch ME
    error('File operation error: %s\n', ME.message);
end

% Create the ZIP file
filesToZip = {'bootstrap', 'function.sh', 'matlabFunction', 'jq'};
zip(zipFileName, filesToZip);
fprintf('ZIP file "%s" created successfully.\n', zipFileName);
setPermission(strcat('./', zipFileName), '755');

% Clean up copied files
delete('bootstrap', 'function.sh', 'jq', 'matlabFunction', 'main.c');

end

function handleFileOperations()
% Handle file copying, creation, and permission settings

% Copy necessary files
copyAndSetPermission('./lambda-custom-runtime/bootstrap', './bootstrap', '755');
copyAndSetPermission('./lambda-custom-runtime/function.sh', './function.sh', '755');

% Download and set permission for jq binary
jqUrl = 'https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64';
jqFilePath = './jq';
websave(jqFilePath, jqUrl);
setPermission(jqFilePath, '755');
end

function copyAndSetPermission(source, destination, permission)
% Copy a file and set its permissions
copyfile(source, destination);
setPermission(destination, permission);
end

function setPermission(filePath, permission)
% SETPERMISSION sets the specified permissions on a file
[status, cmdout] = system(['chmod ', permission, ' ', filePath]);
if status ~= 0
    error('Failed to set permissions for %s: %s\n', filePath, cmdout);
end
end

function generateMainCFromHeader(headerFile)
% Read the contents of the header file
fileContent = fileread(headerFile);

% Use a regular expression to extract the function signature
funcPattern = 'extern\s+([a-zA-Z_][a-zA-Z0-9_ ]*)\s+([a-zA-Z_][a-zA-Z0-9_]*)\(([^)]*)\);';
tokens = regexp(fileContent, funcPattern, 'tokens');

if isempty(tokens)
    error('No function declaration found in header file: %s', headerFile);
end

% Extract return type, function name, and arguments
returnType = strtrim(tokens{1}{1});
functionName = strtrim(tokens{1}{2});
args = strtrim(tokens{1}{3});

% Split the arguments by comma and trim spaces
argList = strsplit(args, ',');
numArgs = length(argList);

% Create and open the main.c file for writing
mainFile = fopen('main.c', 'w');
if mainFile == -1
    error('Could not create main.c file');
end

% Write the initial includes
fprintf(mainFile, '#include <stdio.h>\n');
fprintf(mainFile, '#include <stdlib.h>\n');
fprintf(mainFile, '#include "%s"\n\n', headerFile);

% Write the main function
fprintf(mainFile, 'int main(int argc, char *argv[]) {\n');
fprintf(mainFile, '    if (argc != %d) {\n', numArgs + 1);
fprintf(mainFile, '        printf("Usage: %%s <args...>\\n", argv[0]);\n');
fprintf(mainFile, '        return 1;\n');
fprintf(mainFile, '    }\n\n');
% Declare variables for arguments
for index = 1:numArgs
    [argType, argName] = strtok(argList{index});
    argName = sprintf('arg%d', index);

    % Handle different argument types
    if contains(argType, 'double')
        fprintf(mainFile, '    double %s = atof(argv[%d]);\n', argName, index);
    elseif contains(argType, 'float')
        fprintf(mainFile, '    float %s = atof(argv[%d]);\n', argName, index);
    elseif contains(argType, 'int')
        fprintf(mainFile, '    int %s = atoi(argv[%d]);\n', argName, index);
    elseif contains(argType, 'char')
        fprintf(mainFile, '    char %s = argv[%d][0];\n', argName, index);
    else
        fprintf('Warning: Unsupported argument type: %s. Defaulting to double.\n', argType);
        fprintf(mainFile, '    double %s = atof(argv[%d]);\n', argName, index);
    end
end
fprintf(mainFile, '\n');

% Call the function and handle the return type
if contains(returnType, 'double')
    fprintf(mainFile, '    double result = %s(', functionName);
elseif contains(returnType, 'float')
    fprintf(mainFile, '    float result = %s(', functionName);
elseif contains(returnType, 'int')
    fprintf(mainFile, '    int result = %s(', functionName);
elseif contains(returnType, 'char')
    fprintf(mainFile, '    char result = %s(', functionName);
elseif contains(returnType, 'creal_T')
    fprintf(mainFile, '    creal_T result = %s(', functionName);
else
    fprintf('Warning: Unsupported return type: %s. Defaulting to double.\n', returnType);
    fprintf(mainFile, '    double result = %s(', functionName);
end

for index = 1:numArgs
    if index < numArgs
        fprintf(mainFile, 'arg%d, ', index);
    else
        fprintf(mainFile, 'arg%d', index);
    end
end
fprintf(mainFile, ');\n');

% Print the result
if contains(returnType, 'double') || contains(returnType, 'float')
    fprintf(mainFile, '    printf("%%f", result);\n');
elseif contains(returnType, 'int')
    fprintf(mainFile, '    printf("%%d", result);\n');
elseif contains(returnType, 'char')
    fprintf(mainFile, '    printf("%%c", result);\n');
elseif contains(returnType, 'creal_T')
    fprintf(mainFile, '    printf("%%f%%f", result.re, result.im);\n');
else
    fprintf('Warning: Unsupported return type for printing: %s. Defaulting to double.\n', returnType);
    fprintf(mainFile, '    printf("%%f", (double)result);\n');
end
fprintf(mainFile, '\n    return 0;\n');
fprintf(mainFile, '}\n');

% Close the file
fclose(mainFile);

fprintf('main.c generated successfully for function %s.\n', functionName);
end

