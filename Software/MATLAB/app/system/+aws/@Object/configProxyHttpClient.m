function httpClientBuilder = configProxyHttpClient(obj)
% CONFIGPROXYHTTPCLIENT Build an Apache HTTP client with AWS proxy settings.
%
% Syntax
%   builder = obj.configProxyHttpClient();
%
% Returns
%   httpClientBuilder - (software.amazon.awssdk.http.apache.ApacheHttpClient$Builder)
%                       Builder configured with proxy settings. Empty when
%                       no proxy is configured.
%
% Notes
%   - Uses `obj.ProxyConfiguration` (host, port, username, password).
%   - Caller is responsible for invoking `build()` on the returned builder.

% Copyright 2025 The MathWorks, Inc.

arguments
    obj (1,1) aws.Object
end

if strlength(obj.ProxyConfiguration.host) > 0
    % Only use the true option for now, false retained for further work
    useSystemDefault = true;
    proxyConfig = configureProxy(obj.ProxyConfiguration, useSystemDefault);

    httpClientBuilder = createHttpClientWithProxy(proxyConfig);
else

    httpClientBuilder = [];
end
end

function proxyConfig = configureProxy(proxyConfigData, useSystemDefault)
% Helper function to configure proxy properties

if useSystemDefault
    java.lang.System.setProperty("http.proxyHost", proxyConfigData.host);
    java.lang.System.setProperty("http.proxyPort", num2str(proxyConfigData.port));

    if strlength(proxyConfigData.username) > 0
        java.lang.System.setProperty("http.proxyUser", proxyConfigData.username);
        java.lang.System.setProperty("http.proxyPassword", proxyConfigData.password);
    end

    proxyConfig = software.amazon.awssdk.http.apache.ProxyConfiguration.builder().build();
else
    % For Future Use
    proxyURI = java.net.URI([proxyConfigData.host, ':', num2str(proxyConfigData.port)]);
    proxyConfigBuilder = software.amazon.awssdk.http.apache.ProxyConfiguration.builder();

    if strlength(proxyConfigData.username) > 0
        proxyConfigBuilder.username(proxyConfigData.username);
        proxyConfigBuilder.password(proxyConfigData.password);
    end

    proxyConfigBuilder.useSystemPropertyValues(java.lang.Boolean(false));
    proxyConfigBuilder.nonProxyHosts(java.util.Collections.emptySet);
    proxyConfig = proxyConfigBuilder.endpoint(proxyURI).build();
end
end

function httpClientBuilder = createHttpClientWithProxy(proxyConfig)
% Helper function to create an HTTP client with a given proxy configuration
httpClientBuilder = software.amazon.awssdk.http.apache.ApacheHttpClient.builder();
httpClientBuilder.proxyConfiguration(proxyConfig);
end
