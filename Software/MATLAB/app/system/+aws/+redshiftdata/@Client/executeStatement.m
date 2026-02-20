function response = executeStatement(obj, options)
% EXECUTESTATEMENT Run a SQL statement against a Redshift cluster or workgroup.
%
% Syntax
%   resp = rsData.executeStatement(sql="SELECT 1", ...
%            clusterIdentifier="my-cluster", database="dev");
%   resp = rsData.executeStatement(sql=stmt, workgroupName="serverless", database="dev");
%
% Name-Value Arguments
%   sql                      - (string, required) SQL statement text.
%   database                 - (string, required) Target database.
%   clusterIdentifier        - (string) Provisioned cluster identifier. Use this OR `workgroupName`.
%   workgroupName            - (string) Serverless workgroup name/ARN. Mutually exclusive with `clusterIdentifier`.
%   clientToken              - (string) Idempotency token.
%   dbUser                   - (string) Database user to run as.
%   parameters               - (dictionary) SQL parameters (name -> scalar).
%   resultFormat             - (string) `"JSON"`, `"TEXT"`, etc.
%   secretArn                - (string) Secrets Manager ARN for database credentials.
%   sessionId                - (string) Identifier for an existing session.
%   sessionKeepAliveSeconds  - (double) Seconds to keep session alive (provisioned only).
%   statementName            - (string) Friendly name for the statement.
%   withEvent                - (logical) Publish status events to EventBridge.
%
% Returns
%   response - aws.redshiftdata.model.ExecuteStatementResponse containing the statement ID.
%
% Example
%   resp = rs.executeStatement( ...
%       sql="SELECT :id AS identifier", ...
%       workgroupName="demo-serverless", ...
%       database="dev", ...
%       parameters=dictionary("id", 42));

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.sql (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.database (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.clusterIdentifier (1,1) string {mustBeTextScalar} = string.empty
    options.workgroupName (1,1) string {mustBeTextScalar} = string.empty
    options.clientToken (1,1) string {mustBeTextScalar} = string.empty
    options.dbUser (1,1) string {mustBeTextScalar} = string.empty
    options.parameters dictionary = dictionary()
    options.resultFormat (1,1) string {mustBeTextScalar} = string.empty
    options.secretArn (1,1) string {mustBeTextScalar} = string.empty
    options.sessionId (1,1) string {mustBeTextScalar} = string.empty
    options.sessionKeepAliveSeconds (1,1) double {mustBeNonnegative} = 0
    options.statementName (1,1) string {mustBeTextScalar} = string.empty
    options.withEvent (1,1) logical = false
end

validateExecutionTarget(options);
write(obj.logObj, 'info', 'Execute SQL Statement in Redshift Data API');

builder = software.amazon.awssdk.services.redshiftdata.model.ExecuteStatementRequest.builder();
builder.sql(options.sql);
builder.database(options.database);

if strlength(options.clusterIdentifier) > 0
    builder.clusterIdentifier(options.clusterIdentifier);
end
if strlength(options.workgroupName) > 0
    builder.workgroupName(options.workgroupName);
end
if strlength(options.clientToken) > 0
    builder.clientToken(options.clientToken);
end
if strlength(options.dbUser) > 0
    builder.dbUser(options.dbUser);
end
if strlength(options.resultFormat) > 0
    builder.resultFormat(options.resultFormat);
end
if strlength(options.secretArn) > 0
    builder.secretArn(options.secretArn);
end
if strlength(options.sessionId) > 0
    builder.sessionId(options.sessionId);
end
if options.sessionKeepAliveSeconds > 0
    builder.sessionKeepAliveSeconds(int32(options.sessionKeepAliveSeconds));
end
if strlength(options.statementName) > 0
    builder.statementName(options.statementName);
end
if options.withEvent
    builder.withEvent(true);
end

if numEntries(options.parameters) > 0
    builder.parameters(buildSqlParameters(options.parameters));
end

request = builder.build();
responseJ = obj.Handle.executeStatement(request);
response = aws.redshiftdata.model.ExecuteStatementResponse(responseJ);

end

function validateExecutionTarget(options)
if strlength(options.clusterIdentifier) == 0 && strlength(options.workgroupName) == 0
    error('aws:redshiftdata:executeStatement:MissingTarget', ...
        'Specify either clusterIdentifier or workgroupName.');
end
if strlength(options.clusterIdentifier) > 0 && strlength(options.workgroupName) > 0
    error('aws:redshiftdata:executeStatement:ConflictingTarget', ...
        'clusterIdentifier and workgroupName are mutually exclusive.');
end
end

function list = buildSqlParameters(paramsDict)
paramKeys = keys(paramsDict);
list = java.util.ArrayList();
for idx = 1:numel(paramKeys)
    name = paramKeys{idx};
    value = paramsDict(name);
    fieldHandle = convertToField(value);
    sqlParam = software.amazon.awssdk.services.redshiftdata.model.SqlParameter.builder() ...
        .name(name).value(fieldHandle).build();
    list.add(sqlParam);
end
end

function fieldHandle = convertToField(value)
import software.amazon.awssdk.services.redshiftdata.model.Field
builder = Field.builder();
if isa(value, 'aws.redshiftdata.model.Field')
    fieldHandle = value.Handle;
elseif isstring(value) || ischar(value)
    fieldHandle = builder.stringValue(string(value)).build();
elseif isnumeric(value)
    if ~isscalar(value)
        error('aws:redshiftdata:executeStatement:UnsupportedParamType', ...
            'Numeric SQL parameters must be scalar values.');
    end
    if (isinteger(value) || value == fix(value))
        fieldHandle = builder.longValue(int64(value)).build();
    else
        fieldHandle = builder.doubleValue(double(value)).build();
    end
elseif islogical(value)
    fieldHandle = builder.booleanValue(value).build();
elseif isa(value, 'uint8')
    byteBuffer = java.nio.ByteBuffer.wrap(value);
    fieldHandle = builder.blobValue(byteBuffer).build();
elseif isempty(value)
    fieldHandle = builder.isNull(true).build();
else
    error('aws:redshiftdata:executeStatement:UnsupportedParamType', ...
        'Unsupported SQL parameter type: %s', class(value));
end
end
