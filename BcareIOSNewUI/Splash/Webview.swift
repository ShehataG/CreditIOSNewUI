//
//  WebView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import UIKit
import WebKit

struct WebView: UIViewRepresentable {
    let fileName: String
    func makeUIView(context: Context) -> WKWebView  {
        let wkwebView = WKWebView()
        wkwebView.frame = UIScreen.main.bounds
        wkwebView.contentMode = .scaleAspectFit
        wkwebView.loadHTMLString(fileName, baseURL: nil)
        return wkwebView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
