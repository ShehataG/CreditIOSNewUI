//
//  NetworkView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//


import Foundation
import SwiftUI

struct NetworkView: View {
    var callback:(() -> ())?
    var body: some View {
        VStack {
            ColoredText(text: "NoInternet".localized)
                .font(Fonts.mediumBold())
                .foregroundColor(Color.black)
            FA6Text(text: FontAwesome6.retryIcon,color: appOrangeColor)
                .onTapGesture {
                    if !noNetwork() {
                        callback?()
                    }
                }
                .padding(.top,3)
        }
        .padding(50)
        .background(Color.lightGrayCommon)
    }
}
