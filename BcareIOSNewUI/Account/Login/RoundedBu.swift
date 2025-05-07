//
//  RoundedBu.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct RoundedBu: View {
    let item:String
    let textColor:Color
    let backColor:Color
    let width:CGFloat
    let vPadding:CGFloat
    let disabled:Bool
    let font:Font
    init(item: String, textColor: Color, backColor: Color, font: Font = Fonts.mediumRegular(), width: CGFloat = 0.0, vPadding: CGFloat, disabled: Bool = false) {
        self.item = item
        self.textColor = textColor
        self.backColor = backColor
        self.font = font
        self.width = width
        self.vPadding = vPadding
        self.disabled = disabled
    }
    var body: some View {
        Text(verbatim: item.localized)
            .font(font)
            .foregroundColor(textColor)
            .padding(.vertical,vPadding)
            .frame(width: screenWidth * width)
            .background(disabled ? Color.lightGray : backColor)
            .cornerRadius(10)
            .disabled(disabled)
    }
}
