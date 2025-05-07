//
//  SathaList.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct SathaList: View {
    let item:SathaItem
    let color = Color(hex: "9B9B9B")!
    var body: some View {
        VStack(spacing:15) {
            Text(verbatim: item.title.localized)
                .font(Fonts.smallRegular())
                .foregroundColor(.black)
            HStack(spacing:6) {
                Spacer()
                Text(verbatim: "StartsFrom".localized)
                        .font(Fonts.smallRegular())
                        .foregroundColor(color) 
                RiyalView(price: item.price.toString(), color: appBlueColor, font: Fonts.verySmallSemiBold())
                Spacer()
             }
            Text(verbatim: item.subTitle.localized)
                .font(Fonts.smallRegular())
                .foregroundColor(color)
                .multilineTextAlignment(.center)
        }
        .padding(20)
        .modifier(BackgroundModifer())
        .padding(.top,10)
    }
}
