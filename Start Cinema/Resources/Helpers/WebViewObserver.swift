//
//  WebViewObserver.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 01.11.2023.
//

import Foundation
import WebKit

class WebViewObserver: NSObject {
    private weak var webView: WKWebView?
    
    init(webView: WKWebView) {
        self.webView = webView
        super.init()
        self.webView?.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
    }
    
    deinit {
        self.webView?.removeObserver(self, forKeyPath: "loading")
    }
    
    @objc 
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading", let newValue = change?[.newKey] as? Bool, newValue == false {
            UIBlockingProgressHUD.dismiss()
        }
    }
}
