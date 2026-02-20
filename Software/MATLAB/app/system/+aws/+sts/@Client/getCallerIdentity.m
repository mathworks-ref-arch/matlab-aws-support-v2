function response = getCallerIdentity(obj)
% GETCALLERIDENTITY Retrieve ARN, user ID, and account for the current caller.
%
% Syntax
%   resp = sts.getCallerIdentity();
%
% Returns
%   response - aws.sts.model.GetCallerIdentityResponse containing ARN, account,
%              and user ID.
%
% Example
%   sts = aws.sts.Client();
%   resp = sts.getCallerIdentity();
%   fprintf("Caller: %s\n", resp.arn);

% Copyright 2025 The MathWorks, Inc.

arguments
    obj
end

import software.amazon.awssdk.services.sts.model.GetCallerIdentityRequest;

request = GetCallerIdentityRequest.builder().build();
responseJ = obj.Handle.getCallerIdentity(request);

response = aws.sts.model.GetCallerIdentityResponse(responseJ);

end

