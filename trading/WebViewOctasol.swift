//
//  WebViewOctasol.swift
//  trading
//
//  Created by Mayank Dev on 12/07/25.
//

import Foundation
import SwiftUI
import WebKit

struct WebViewOctasol: UIViewRepresentable {
    var url: String = ""
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else {
            return WKWebView()
        }
        let request = URLRequest(url: url)
        let webView = WKWebView()
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

