//
//  Browser.swift
//  Hologarden
//
//  Created by Casey Pollock on 5/26/21.
//

import Foundation
import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    var url : String = "www.nearfuture.marketing"
    
    func makeUIView(context: Context) -> WKWebView {
        guard let urlFromString = URL(string: url) else {
            return WKWebView()
        }
            let request = URLRequest(url: urlFromString)
            let wkWebView = WKWebView()
            wkWebView.load(request)
            return wkWebView
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<WebView>) {
        
    }
    
}
