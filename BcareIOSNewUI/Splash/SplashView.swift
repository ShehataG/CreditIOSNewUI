//
//  SplashView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//


import Foundation
import SwiftUI

struct SplashView: View {
    //let html = try! String(contentsOf: Bundle.main.url(forResource: "MotionApp", withExtension: "html")!)
    var body: some View {
        ZStack {
//            WebView(fileName: html)
//                .frame(width: screenWidth,height: screenHeight)
//            Image("bcareback")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: screenWidth,height: screenHeight)
            Image("bcarelogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
        }
        .padding()
    }
}
