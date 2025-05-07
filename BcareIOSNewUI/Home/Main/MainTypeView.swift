//
//  MainTypeView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct MainTypeView: View {
    var item:MainTypeItem
    let imgSubWid:CGFloat = isIpad ? 50.0 : 35.0
    var body: some View {
        ZStack(alignment: .center) {
            Image(item.backImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Constants.hGridHeight, height: Constants.hGridHeight * 121 / 114)
            VStack {
            }
            .frame(width: Constants.hGridHeight, height: Constants.hGridHeight * 121 / 114)
            .background(Color.black.opacity(0.1))
            HStack {
                VStack(alignment:.leading,spacing:0) {
                    Text(verbatim: item.title.localized)
                        .font(Fonts.smallRegular())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Text(verbatim: item.desc.localized)
                        .font(Fonts.tooSmallRegular())
                        .foregroundColor(appOrangeColor)
                        .padding(.top,5)
                        .padding(.leading,3)
                }
                .padding(.horizontal,10)
                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(item.frontImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imgSubWid, height: imgSubWid)
                        .padding(.horizontal,10)
                        .padding(.bottom,5)
                }
            }
//            if let discount = item.discount {
//                VStack {
//                    ServiceDiscountView(title: discount)
//                    .padding(.top,10)
//                    Spacer()
//                }
//            }
        }
        .cornerRadius(15)
    }
}
