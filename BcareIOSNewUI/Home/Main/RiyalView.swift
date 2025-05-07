//
//  RiyalView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SVGKit

struct RiyalView: View {
    let price:String
    let color:Color
    let font:Font
    let imgWid:CGFloat = isIpad ? 40 : 20
    init(price: String, color: Color, font: Font) {
        self.price = price
        self.color = color
        self.font = font
    }
    var body: some View {
        HStack  {
            if let img = SVGKImage(named:"riyal")?.uiImage {
                Image(uiImage: img)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width:imgWid,height:imgWid)
                    .foregroundColor(appOrangeColor)
            }
            Text(verbatim:price)
                .font(font)
                .foregroundColor(color)
        }
        .environment(\.layoutDirection,.leftToRight)
    }
}
