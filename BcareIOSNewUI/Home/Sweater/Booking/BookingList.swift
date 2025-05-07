//
//  BookingList.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct BookingList: View {
    let title:String
    let titleColor:Color
    let price:Double
    init(title: String, titleColor: Color = Color.black, price: Double) {
        self.title = title
        self.titleColor = titleColor
        self.price = price
    }
    var body: some View {
        HStack {
            GrayText(text: title.localized)
                .font(Fonts.smallLight())
            Spacer()
            RiyalView(price: price.decimals(2), color: titleColor, font: Fonts.smallBold())
                .padding(.top,5)
        }
        .padding(.vertical,5)
        .frame(maxWidth: .infinity)
    }
}

struct BookingNonList: View {
    let title:String
    let desc:String
    var body: some View {
        HStack {
            GrayText(text: title.localized)
                .font(Fonts.smallLight())
            Spacer()
            Text(verbatim: desc.localized)
                .font(Fonts.verySmallBold())
                .foregroundColor(Color.black)
                .padding(.top,5)
        }
        .padding(.vertical,5)
        .frame(maxWidth: .infinity)
    }
}
