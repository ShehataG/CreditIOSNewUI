//
//  LottieView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 6/2/24.
//

import Foundation
import SwiftUI
import Lottie
import WebKit
import SSSwiftUIGIFView

struct LottieView: UIViewRepresentable {
    var lottieFile: String
    var loopMode: LottieLoopMode = .playOnce
    var animationView = LottieAnimationView()
    @Binding var lottAnimatedDone: Bool
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        animationView.animation = LottieAnimation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        animationView.play { _ in
            lottAnimatedDone = true
        }
    }
}

struct LottieStaticView: UIViewRepresentable {
    var lottieFile: String
    var loopMode: LottieLoopMode = .playOnce
    var animationView = LottieAnimationView()
    func makeUIView(context: UIViewRepresentableContext<LottieStaticView>) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        animationView.animation = LottieAnimation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieStaticView>) {
        animationView.play()
    }
}

struct LottieLoadingView: View {
    var body: some View {
        VStack {
            Spacer()
//            GifImageView(file: "Logo")
            SwiftUIGIFPlayerView(gifName: "Logo")
                .frame(width: 50,height: 50)
                .cornerRadius(25)
            Spacer()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.white.opacity(0.8))
    }
}

//struct GifImageView: UIViewRepresentable {
//    var file: String
//    var animationView = WKWebView()
//    func makeUIView(context: UIViewRepresentableContext<GifImageView>) -> UIView {
//        let view = UIView()
//        view.backgroundColor = .clear
//        let url = Bundle.main.url(forResource: file, withExtension: "gif")!
//        let data = try! Data(contentsOf: url)
//        animationView.load(data,mimeType: "image/gif",characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(animationView)
//        NSLayoutConstraint.activate([
//            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
//        ])
//        return view
//    }
//
//    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<GifImageView>) {
//    }
//}

//struct GifImageView: UIViewRepresentable {
//    var file: String
//    func makeUIView(context: Context) -> WKWebView {
//        let webview = WKWebView()
//        let url = Bundle.main.url(forResource: file, withExtension: "gif")!
//        webview.backgroundColor = UIColor(appBlueColor)
//        let data = try! Data(contentsOf: url)
//        webview.load(data,mimeType: "image/gif",characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
//        return webview
//    }
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        uiView.reload()
//    }
//}
