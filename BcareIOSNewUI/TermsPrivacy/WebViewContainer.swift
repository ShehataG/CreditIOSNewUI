//
//  WebViewContainer.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/27/24.
//

import Foundation
import SwiftUI
import AdjustWebBridge
@preconcurrency import WebKit

struct WebViewContainer: UIViewRepresentable {
    @ObservedObject var webViewModel: WebViewModel
    var downloadUrl:Binding<URL?>
    let webView = WKWebView()
    var adjustBridge = AdjustBridge()

    func makeCoordinator() -> WebViewContainer.Coordinator {
        Coordinator(self, webViewModel, downloadUrl: downloadUrl)
    }

    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.webViewModel.url) else {
            return WKWebView()
        }
        let request = URLRequest(url: url)
        adjustBridge.loadWKWebViewBridge(webView)
        webView.backgroundColor = .clear
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.load(request)
        
        // Fix white space when keyboard shows
        NotificationCenter.default.removeObserver(self.webView, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self.webView, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self.webView, name: UIResponder.keyboardWillHideNotification, object: nil)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if webViewModel.shouldGoBack {
            uiView.goBack()
            webViewModel.shouldGoBack = false
        }
    }
}

struct MimeType {
    var type:String
    var fileExtension:String
}

@MainActor
class WebViewModel: MainObservable {
    @Published var isLoading: Bool = false
    @Published var canGoBack: Bool = false
//    @Published var canGoForw: Bool = false
    @Published var shouldGoBack: Bool = false
    @Published var title: String = ""
    var url: String
    init(url: String) {
        self.url = url
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let webiew = object as? WKWebView {
//            if keyPath == #keyPath(webiew.canGoBack) {
//                canGoBack = webiew.canGoBack
//            }
//            else if keyPath == #keyPath(WKWebView.canGoForward) {
//                canGoForw = webiew.canGoForward
//            }
        }
    }
}

extension WebViewContainer {
    class Coordinator: NSObject, WKNavigationDelegate,WKUIDelegate,WKDownloadDelegate,Sendable {
        
        @ObservedObject private var webViewModel: WebViewModel
        var downloadUrl:Binding<URL?>
        private let parent: WebViewContainer
        private var fileDestinationURL: URL?
        private let mimeTypes = [MimeType(type: "ms-excel", fileExtension: "xls"),
                                 MimeType(type: "pdf", fileExtension: "pdf")]
        init(_ parent: WebViewContainer, _ webViewModel: WebViewModel,downloadUrl:Binding<URL?>) {
            self.parent = parent
            self.webViewModel = webViewModel
            self.downloadUrl = downloadUrl
            parent.webView.addObserver(webViewModel, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
//            parent.webView.addObserver(webViewModel, forKeyPath: #keyPath(WKWebView.canGoForward), options: .new, context: nil)
        }
        deinit {
//            parent.webView.removeObserver(webViewModel, forKeyPath: #keyPath(WKWebView.canGoBack))
//            parent.webView.removeObserver(webViewModel, forKeyPath: #keyPath(WKWebView.canGoForward))
        }
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            webViewModel.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webViewModel.isLoading = false
            webViewModel.title = webView.title ?? ""
//            webViewModel.canGoBack = webView.canGoBack
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            webViewModel.isLoading = false
        }
         
//        func webView(
//            _ webView: WKWebView,
//            decidePolicyFor navigationAction: WKNavigationAction
//        ) async -> WKNavigationActionPolicy {
//            if let urlStr = navigationAction.request.url?.absoluteString {
//                print("Tracked" , urlStr)
//            }
//            return WKNavigationActionPolicy.allow
//        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
                    if let urlStr = navigationAction.request.url?.absoluteString {
                        print("Tracked" , urlStr)
                    }
                   decisionHandler(.allow)
              }
        
        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationResponse: WKNavigationResponse
        ) async -> WKNavigationResponsePolicy {
            if let mimeType = navigationResponse.response.mimeType {
                if isMimeTypeConfigured(mimeType) {
                    if let url = navigationResponse.response.url {
                        print("dndsjjhdshjdsjhddjhs ",url)
                        if #available(iOS 14.5, *) {
                            return WKNavigationResponsePolicy.download
                        } else {
                            var fileName = getDefaultFileName(forMimeType: mimeType)
                            if let name = getFileNameFromResponse(navigationResponse.response) {
                                fileName = name
                            }
                            downloadData(fromURL: url, fileName: fileName) { success, destinationURL in
                                if success, let destinationURL = destinationURL {
                                    Task {
                                        await self.downloadUrl.wrappedValue = destinationURL
                                    }
                                }
                            }
                            return WKNavigationResponsePolicy.cancel
                        }
                    }
                }
            }
            return WKNavigationResponsePolicy.allow
        }
        
        @available(iOS 14.5, *)
        func webView(_ webView: WKWebView, navigationResponse: WKNavigationResponse, didBecome download: WKDownload) {
            print("navigationresponse didbecome download")
            download.delegate = self
        }
         
        private func downloadData(fromURL url:URL,
                                  fileName:String,
                                  completion:@escaping @Sendable (Bool, URL?) -> Void) {
            parent.webView.configuration.websiteDataStore.httpCookieStore.getAllCookies() { cookies in
                let session = URLSession.shared
                session.configuration.httpCookieStorage?.setCookies(cookies, for: url, mainDocumentURL: nil)
                let task = session.downloadTask(with: url) { localURL, urlResponse, error in
                    Task {
                        if let localURL = localURL {
                            let destinationURL = await self.moveDownloadedFile(url: localURL, fileName: fileName)
                            completion(true, destinationURL)
                        }
                        else {
                            completion(false, nil)
                        }
                    }
                }
                task.resume()
            }
        }
        
        private func getDefaultFileName(forMimeType mimeType:String) -> String {
            for record in self.mimeTypes {
                if mimeType.contains(record.type) {
                    return "default." + record.fileExtension
                }
            }
            return "default"
        }
        
        private func getFileNameFromResponse(_ response:URLResponse) -> String? {
            if let httpResponse = response as? HTTPURLResponse {
                let headers = httpResponse.allHeaderFields
                if let disposition = headers["Content-Disposition"] as? String {
                    let components = disposition.components(separatedBy: " ")
                    if components.count > 1 {
                        let innerComponents = components[1].components(separatedBy: "=")
                        if innerComponents.count > 1 {
                            if innerComponents[0].contains("filename") {
                                return innerComponents[1]
                            }
                        }
                    }
                }
            }
            return nil
        }
        
        private func isMimeTypeConfigured(_ mimeType:String) -> Bool {
            for record in self.mimeTypes {
                if mimeType.contains(record.type) {
                    return true
                }
            }
            return false
        }
        
        private func moveDownloadedFile(url:URL, fileName:String) async -> URL {
            let tempDir = NSTemporaryDirectory()
            let destinationPath = tempDir + fileName
            let destinationURL = URL(fileURLWithPath: destinationPath)
            try? FileManager.default.removeItem(at: destinationURL)
            try? FileManager.default.moveItem(at: url, to: destinationURL)
            return destinationURL
        }
        
        @available(iOS 14.5, *)
        func download(_ download: WKDownload, decideDestinationUsing response: URLResponse, suggestedFilename: String, completionHandler: @escaping @MainActor @Sendable (URL?) -> Void) {
            let tempDirectory = FileManager.default.temporaryDirectory
            let tempFolderName = UUID().uuidString
            let tempDirectoryPath = tempDirectory.appendingPathComponent(tempFolderName)
            do {
                try FileManager.default.createDirectory(at: tempDirectoryPath, withIntermediateDirectories: false)
            } catch {
                debugPrint(error)
            }
            let url = tempDirectoryPath.appendingPathComponent(suggestedFilename)
            fileDestinationURL = url
            completionHandler(url)
        }
        
        @available(iOS 14.5, *)
        func download(_ download: WKDownload, didFailWithError error: Error, resumeData: Data?) {
            print("download failed \(error)")
        }
        
        @available(iOS 14.5, *)
        func downloadDidFinish(_ download: WKDownload) {
            print("download finish")
            if let url = fileDestinationURL {
                self.downloadUrl.wrappedValue = url
            }
        }
        
        @available(iOS 14.5, *)
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
    }
}
