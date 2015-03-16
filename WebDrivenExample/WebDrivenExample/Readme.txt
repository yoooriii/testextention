https://github.com/robbiehanson/CocoaHTTPServer
https://github.com/chrisballinger/ProxyKit

HTTP - Tutorial
http://www.tutorialspoint.com/http/index.htm

CFDictionaryRef systemProxyDict = CFNetworkCopySystemProxySettings();
CFReadStreamSetProperty(m_resultRef, kCFStreamPropertyHTTPProxy, systemProxyDict);
