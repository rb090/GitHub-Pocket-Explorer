//
//  WebView.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 04.01.20.
//  Copyright © 2020 RB. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    let urlForWebview: URL
    let webviewNavigationDelegate: WKNavigationDelegate?

    func makeUIView(context: Context) -> WKWebView  {
        let webview = WKWebView()
        webview.navigationDelegate = webviewNavigationDelegate
        let urlRequest = URLRequest(url: urlForWebview)
        webview.load(urlRequest)
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
}

