//
//  WareefOtherGridView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI
import WebKit

struct WareefOtherGridView: View {
    let item:WareefDatumItem
    let image:String
    let imgWid:CGFloat = isIpad ? 30 : 20
    let itemWidth = (screenWidth * 0.85 - 30) * 0.25
    var body: some View {
        VStack {
            Spacer()
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:imgWid,height:imgWid)
                .padding(.horizontal,7)
            Text(verbatim: item.name)
                .font(Fonts.verySmallLight())
                .foregroundColor(appBlueColor)
                .padding(.top,5)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(width: itemWidth,height: itemWidth)
        .modifier(BackgroundModifer())
    }
}
