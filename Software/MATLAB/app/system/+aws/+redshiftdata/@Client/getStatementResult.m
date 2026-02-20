function response = getStatementResult(obj, options)
% GETSTATEMENTRESULT Retrieve rows for a previously executed statement.
%
% Syntax
%   resp = rsData.getStatementResult(id=statementId);
%   resp = rsData.getStatementResult(id=statementId, nextToken=token);
%
% Name-Value Arguments
%   id        - (string, required) Statement identifier returned by `executeStatement`.
%   nextToken - (string) Pagination token from a previous call.
%
% Returns
%   response - aws.redshiftdata.model.GetStatementResultResponse containing metadata,
%              records, and pagination tokens.
%
% Example
%   gr = rs.getStatementResult(id=resp.id);
%   if gr.hasNextToken
%       grPage2 = rs.getStatementResult(id=resp.id, nextToken=gr.nextToken);
%   end

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
    options.id (1,1) string {mustBeTextScalar, mustBeNonempty}
    options.nextToken (1,1) string {mustBeTextScalar} = string.empty
end

write(obj.logObj, 'info', 'Retrieve SQL statement results from Redshift Data API');

builder = software.amazon.awssdk.services.redshiftdata.model.GetStatementResultRequest.builder();
builder.id(options.id);
if strlength(options.nextToken) > 0
    builder.nextToken(options.nextToken);
end

request = builder.build();
responseJ = obj.Handle.getStatementResult(request);
response = aws.redshiftdata.model.GetStatementResultResponse(responseJ);

end
