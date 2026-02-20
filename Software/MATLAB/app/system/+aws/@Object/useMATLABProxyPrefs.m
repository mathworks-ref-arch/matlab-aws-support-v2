function useMATLABProxyPrefs(obj, url)
% USEMATLABPROXYPREFS Populate proxy settings from MATLAB preferences.
%
% Syntax
%   obj.useMATLABProxyPrefs("https://athena.eu-west-1.amazonaws.com");
%
% Inputs
%   url - (string, optional) Endpoint used when querying the system proxy.
%
% Description
%   When `obj.ProxyConfiguration.host` is empty, this helper inspects the
%   MATLAB proxy preferences (and underlying system proxy on Windows)
%   to populate host/port/username/password. No changes are made when the
%   proxy is already configured.

% Copyright 2025 The MathWorks, Inc.

arguments
    obj (1,1) aws.Object
    url (1,1) string = ""
end

if strlength(obj.ProxyConfiguration.host) == 0
    % Ensure the Java proxy settings are set
    com.mathworks.mlwidgets.html.HTMLPrefs.setProxySettings; %#ok<JAPIMATHWORKS>
    % Obtain the proxy information for a given URL, OS may provide
    % different proxy for different URL expecting a common host for all
    % Athena endpoints is reasonable
    targetUrl = [];
    if strlength(url) > 0
        targetUrl = java.net.URL(char(url));
    end
    % This function goes to MATLAB's preference panel or if not set and on
    % Windows the system preferences
    javaProxy = com.mathworks.webproxy.WebproxyFactory.findProxyForURL(targetUrl); %#ok<JAPIMATHWORKS>

    if ~isempty(javaProxy)
        if strlength(char(javaProxy.address.toString)) > 0
            address = javaProxy.address;
            if isa(address,'java.net.InetSocketAddress') && ...
                    javaProxy.type == javaMethod('valueOf','java.net.Proxy$Type','HTTP')
                % A proxy host could be determined from MATLAB preferences or OS (Windows)
                obj.ProxyConfiguration.host = char(address.getHostName());
                obj.ProxyConfiguration.port = address.getPort();

                mwt = com.mathworks.net.transport.MWTransportClientPropertiesFactory.create(); %#ok<JAPIMATHWORKS>
                if strlength(char(mwt.getProxyHost())) > 0
                    obj.ProxyConfiguration.password = char(mwt.getProxyPassword());
                    obj.ProxyConfiguration.username = char(mwt.getProxyUser());
                end
            end
        end
    end
end
