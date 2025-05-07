//
//  CheckoutList.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine
import MapKit

struct CheckoutList: View {
    let title:String
    let price:Double
    let color:Color
    let font:Font
    init(title: String, price: Double, color: Color = .black, font: Font = Fonts.verySmallLight()) {
        self.title = title
        self.price = price
        self.color = color
        self.font = font
    }
    var body: some View {
        HStack {
            Text(verbatim:title)
                .font(Fonts.smallLight())
                .foregroundColor(Color.black)
                .padding(.horizontal,10)
            Spacer() 
            RiyalView(price: price.decimals(2), color: color, font: font)

        }
    }
}
