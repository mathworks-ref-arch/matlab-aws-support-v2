function startup(varargin)
% STARTUP - Script to add paths to MATLAB path
% This script will add the paths below the root directory into the MATLAB
% path. It will omit the SVN and other undesirable paths.  Modify undesired path
% filter as desired.

% Copyright 2025 The MathWorks, Inc.

here = fileparts(mfilename('fullpath'));
if ~isdeployed()
    appStr = 'Adding Interface for Amazon Web Services';
    disp(appStr);
    disp(repmat('-',1,numel(appStr)));

    %% Set up the paths to add to the MATLAB path
    % This should be the only section of the code that needs modification
    % The second argument specifies whether the given directory should be
    % scanned recursively
    rootDirs={fullfile(here,'app'),true;...
        fullfile(here,'config'),true;...
        fullfile(here,'sys','modules'),true;...
        fullfile(here,'public'),true;...
        };

    %% Add the framework to the path
    iAddFilteredFolders(rootDirs);

    %% Handle the modules for the project.
    disp(' ')
    disp('Initializing all modules:');
    modRoot = fullfile(here,'sys','modules');

    % Get a list of all modules
    mList = dir(fullfile(modRoot,'*.'));
    for mCount = 1:numel(mList)
        % Only add proper folders
        dName = mList(mCount).name;
        if ~strcmpi(dName(1),'.')
            % Valid Module name
            candidateStartup = fullfile(modRoot,dName,'startup.m');
            if exist(candidateStartup,'file')
                % A module with a startup
                run(candidateStartup);
            else
                % Create a cell and add it recursively to the path
                iAddFilteredFolders({fullfile(modRoot,dName), true});
            end
        end
    end

    %% Post path-setup operations
    % Add post-setup operations here.
    disp(' ');
    disp('Setting up the AWS SDK for Java:');
    jarPath = fullfile(here,'lib','jar');
    tmp = fullfile(jarPath,'matlab-aws-support-v2-0.1.0.jar');
    jarFiles = dir(tmp);

    for jCount = 1:numel(jarFiles)
        disp('Adding the AWS SDK for Java to the Java classpath');
        iSafeAddToJavaPath(fullfile(jarPath,jarFiles(jCount).name));
    end

    %% Create the logger
    % Get the logger object - a singleton (one logger per MATLAB session)
    logObj = Logger.getLogger;
    % Adjust the log levels
    logObj.FileLogLevel = 'warning';
    logObj.DisplayLogLevel = 'debug';

    %% Check the environment

    % Check if the AWS SDK for Java is installed
    % Check the current environment for tools and dependencies
    iCheckEnvironment();
else
    % In a deployed use , add the jar file to the dynamic class path
    jarPath = fullfile(here,'lib','jar', 'matlab-aws-support-v2-0.1.0.jar');
    iSafeAddToJavaPath(jarPath);

end
end


%% Helper function to check the users environment
%% Should refactor to automatically add all java
function iCheckEnvironment()

disp(' ');
% Check if the AWS CLI is installed
[cliStatus, cliVersion] = system('aws --version');
rowVals = {"AWS CLI", ~cliStatus, "System", string(cliVersion)};
depTable = table(rowVals{:}, 'VariableNames', {'Name', 'Present', 'Type', 'Notes'});

% Check for docker support
[err, outStr] = system('docker --version');
rowVals = {"Docker", (err==0) , "System", string(strrep(outStr,newline,''))};
depTable(end+1,:) = table(rowVals{:});

% Check if Amazon Athena is available
isAthenaAvailable = exist('software.amazon.awssdk.services.athena.AthenaClient', 'class') == 8;
notes = "aws.athena.Client()";
depTable(end+1, :) = table("Amazon Athena", isAthenaAvailable, "Library", notes, ...
    'VariableNames', {'Name', 'Present', 'Type', 'Notes'});
    
% Check if Amazon Bedrock Runtime is available
isBedrockAvailable = exist('software.amazon.awssdk.services.bedrockruntime.BedrockRuntimeClient', 'class') == 8;
notes = "aws.bedrock.runtime.Client()";
depTable(end+1, :) = table("Amazon Bedrock", isBedrockAvailable, "Library", notes, ...
    'VariableNames', {'Name', 'Present', 'Type', 'Notes'});

% Check if Amazon Bedrock Runtime is available
isECS = exist('software.amazon.awssdk.services.ecs.EcsClient', 'class') == 8;
notes = "aws.ecs.Client()";
depTable(end+1, :) = table("Amazon Elastic Container Service", isECS, "Library", notes, ...
    'VariableNames', {'Name', 'Present', 'Type', 'Notes'});

isSTS = exist('software.amazon.awssdk.services.sts.StsClient', 'class') == 8;
notes = "aws.sts.Client()";
depTable(end+1, :) = table("Amazon Security Token Service", isSTS, "Library", notes, ...
    'VariableNames', {'Name', 'Present', 'Type', 'Notes'});

% Check if Amazon Redshift Data API is available
isRedshiftData = exist('software.amazon.awssdk.services.redshiftdata.RedshiftDataClient', 'class') == 8;
notes = "aws.redshiftdata.Client()";
depTable(end+1, :) = table("Amazon Redshift Data API", isRedshiftData, "Library", notes, ...
    'VariableNames', {'Name', 'Present', 'Type', 'Notes'});

% Check if Amazon Lambda is available
isLambda = exist('software.amazon.awssdk.services.lambda.LambdaClient', 'class') == 8;
notes = "aws.lambda.Client()";
depTable(end+1, :) = table("Amazon Lambda", isLambda, "Library", notes, ...
    'VariableNames', {'Name', 'Present', 'Type', 'Notes'});

% Check if Amazon SQS is available
isSQS = exist('software.amazon.awssdk.services.sqs.SqsClient', 'class') == 8;
notes = "aws.sqs.Client()";
depTable(end+1, :) = table("Amazon SQS", isSQS, "Library", notes, ...
    'VariableNames', {'Name', 'Present', 'Type', 'Notes'});

%Check if Amazon SNS is available
isSNS = exist('software.amazon.awssdk.services.sns.SnsClient', 'class') == 8;
notes = "aws.sns.Client()";
depTable(end+1, :) = table("Amazon SNS", isSNS, "Library", notes, ...
    'VariableNames', {'Name', 'Present', 'Type', 'Notes'});

%Check if Amazon DynamoDb is available
isDynamoDb = exist('software.amazon.awssdk.services.dynamodb.DynamoDbClient', 'class') == 8;
notes = "aws.dynamodb.Client()";
depTable(end+1, :) = table("Amazon DynamoDb", isDynamoDb, "Library", notes, ...
    'VariableNames', {'Name', 'Present', 'Type', 'Notes'});

%Check if Amazon Polly is available
isPolly = exist('software.amazon.awssdk.services.polly.PollyClient', 'class') == 8;
notes = "aws.polly.Client()";
depTable(end+1, :) = table("Amazon Polly", isPolly, "Library", notes, ...
    'VariableNames', {'Name', 'Present', 'Type', 'Notes'});

%Check if Amazon Systems Manager (SSM) is available
isSsm = exist('software.amazon.awssdk.services.ssm.SsmClient', 'class') == 8;
notes = "aws.ssm.Client()";
depTable(end+1, :) = table("Amazon SSM", isSsm, "Library", notes, ...
    'VariableNames', {'Name', 'Present', 'Type', 'Notes'});

%Check if Amazon S3 is available
isS3 = exist('software.amazon.awssdk.services.s3.S3Client', 'class') == 8;
notes = "aws.s3.Client()";
depTable(end+1, :) = table("Amazon S3", isS3, "Library", notes, ...
    'VariableNames', {'Name', 'Present', 'Type', 'Notes'});

%Check if Amazon S3 Transfer is available
isS3TransferManager = exist('software.amazon.awssdk.transfer.s3.S3TransferManager', 'class') == 8;
notes = "aws.transfer.s3.TransferManager()";
depTable(end+1, :) = table("Amazon S3 TransferManager", isS3TransferManager, "Library", notes, ...
    'VariableNames', {'Name', 'Present', 'Type', 'Notes'});

%Check if Amazon S3 Transfer is available
isSecretsManager = exist('software.amazon.awssdk.services.secretsmanager.SecretsManagerClient', 'class') == 8;
notes = "aws.secretsmanager.Client()";
depTable(end+1, :) = table("Amazon Secrets Manager", isSecretsManager, "Library", notes, ...
    'VariableNames', {'Name', 'Present', 'Type', 'Notes'});

% Display the environment
disp(depTable);
end


%% iAddFilteredFolders Helper function to add all folders to the path
function iAddFilteredFolders(rootDirs)
% Loop through the paths and add the necessary subfolders to the MATLAB path
for pCount = 1:size(rootDirs,1)

    rootDir=rootDirs{pCount,1};
    if rootDirs{pCount,2}
        % recursively add all paths
        rawPath=genpath(rootDir);

        if ~isempty(rawPath)
            rawPathCell=textscan(rawPath,'%s','delimiter',pathsep);
            rawPathCell=rawPathCell{1};
        end

    else
        % Add only that particular directory
        rawPath = rootDir;
        rawPathCell = {rawPath};
    end

    % if rawPath is empty then we have an entry in rootDir that does not
    % exist on the path so we should not try to add an entry for them
    if ~isempty(rawPath)

        % remove undesired paths
        svnFilteredPath=strfind(rawPathCell,'.svn');
        gitFilteredPath=strfind(rawPathCell,'.git');
        slprjFilteredPath=strfind(rawPathCell,'slprj');
        sfprjFilteredPath=strfind(rawPathCell,'sfprj');
        rtwFilteredPath=strfind(rawPathCell,'_ert_rtw');

        % loop through path and remove all the .svn entries
        if ~isempty(svnFilteredPath)
            for pCount=1:length(svnFilteredPath) %#ok<FXSET>
                filterCheck=[svnFilteredPath{pCount},...
                    gitFilteredPath{pCount},...
                    slprjFilteredPath{pCount},...
                    sfprjFilteredPath{pCount},...
                    rtwFilteredPath{pCount}];
                if isempty(filterCheck)
                    iSafeAddToPath(rawPathCell{pCount});
                else
                    % ignore
                end
            end
        else
            iSafeAddToPath(rawPathCell{pCount});
        end
    end
end

end

%% Helper function to add to MATLAB path.
function iSafeAddToPath(pathStr)

% Add to path if the file exists
if exist(pathStr,'dir')
    disp(['Adding ',pathStr]);
    addpath(pathStr);
else
    disp(['Skipping ',pathStr]);
end

end

%% Helper function to add to the Dynamic Java classpath
function iSafeAddToJavaPath(pathStr)

% Check the current java path
jPaths = javaclasspath('-dynamic');

% Add to path if the file exists
% TODO: Check if the file is already on the path
if exist(pathStr,'dir')||exist(pathStr,'file')
    disp(['Adding ',pathStr]);
    javaaddpath(pathStr);
else
    disp(['Skipping ',pathStr]);
end

end

%% Helper function to add arch specific suffix
function binDirName = iGetArchSuffix()

switch computer
    case 'PCWIN'
        binDirName = 'win32';
    case 'PCWIN64'
        binDirName = 'win64';
    case 'GLNX86'
        binDirName = 'glnx86';
    case 'GLNXA64'
        binDirName = 'glnxa64';
    case 'MACI64'
        binDirName = 'maci64';
    otherwise
        error('FW:Unsupported','The framework is not supported on this platform');
end
end

