//
//  ServiceLocationView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct ServiceLocationView: View {
    let imgWid:CGFloat = isIpad ? 25.0 : 15.0
    var callBack:(()->())?
    init(callBack: (() -> ())? = nil) {
        self.callBack = callBack
    }
    var body: some View {
        VStack {
            HStack {
                Text(verbatim: "YourAddress".localized)
                    .font(Fonts.smallRegular())
                    .foregroundColor(Color.black)
                Spacer()
                Text(verbatim: FontAwesome.arrowDownIcon)
                    .font(Fonts.fontAwesome15_20())
                    .foregroundColor(appBlueColor)
            }
            ColoredText(text: "AddLocation".localized)
                .font(Fonts.smallRegular())
                .padding(.top,20)
                .onTapGesture {
                    callBack?()
                }
        }
        .padding(20)
        .modifier(BackgroundModifer()) 
        .padding(.top,10)
    }
}
