/*
* nodekit.io
*
* Copyright (c) 2016 OffGrid Networks. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import Foundation
import WebKit

extension NKJSContextFactory {
    
   public func createContextUIWebView(options: [String: AnyObject] = Dictionary<String, AnyObject>(), delegate cb: NKScriptContextDelegate) -> Int
    {
        let id = NKJSContextFactory.sequenceNumber
        log("+Starting NodeKit WebView-JavaScriptCore JavaScript Engine E\(id)")
        var item = Dictionary<String, AnyObject>()
        
        let webView:WebView = WebView(frame: CGRectZero)
        
        item["WebView"] = webView
        NKJSContextFactory._contexts[id] = item;
        
        let webPrefs : WebPreferences = WebPreferences.standardPreferences()
        webPrefs.javaEnabled = false
        webPrefs.plugInsEnabled = false
        webPrefs.javaScriptEnabled = true
        webPrefs.javaScriptCanOpenWindowsAutomatically = false
        webPrefs.loadsImagesAutomatically = true
        webPrefs.allowsAnimatedImages = true
        webPrefs.allowsAnimatedImageLooping = true
        webPrefs.shouldPrintBackgrounds = true
        webPrefs.userStyleSheetEnabled = false
        
    
        webView.applicationNameForUserAgent = "nodeKit"
        webView.drawsBackground = false
        webView.preferences = webPrefs
        
        webView.frameLoadDelegate =  NKWVWebViewDelegate(id: id, webView: webView, delegate: cb);
        
        webView.mainFrame.loadHTMLString("<HTML><HEAD><script>// nodekit</script></HEAD><BODY>NodeKit UIWebView: JavaScriptCore VM \(id)</BODY></HTML>", baseURL: NSURL(string: "nodekit: core"))
        return id;

    }
    
    class func useUIWebView(webView:WebView, options: [String: AnyObject] = Dictionary<String, AnyObject>(), delegate cb: NKScriptContextDelegate) -> Int
    {
        let id = NKJSContextFactory.sequenceNumber
        log("+Starting Renderer NodeKit WebView-JavaScriptCore JavaScript Engine E\(id)")
        var item = Dictionary<String, AnyObject>()
        item["WebView"] = webView
        NKJSContextFactory._contexts[id] = item;
        
        webView.frameLoadDelegate =  NKWVWebViewDelegate(id: id, webView: webView, delegate: cb);
        return id;
    }
}