//
//  RoundedLoaderHBu.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct RoundedLoaderHBu: View {
    let item:String
    let textColor:Color
    let backEnableColor:Color
    let backDisableColor:Color
    let vPadding:CGFloat
    let disabled:Bool
    let font:Font
    let showLoader:Bool
    init(item: String, textColor: Color, backEnableColor: Color, backDisableColor: Color, font: Font = Fonts.mediumRegular(), vPadding: CGFloat, disabled: Bool = false,showLoader:Bool = false) {
        self.item = item
        self.textColor = textColor
        self.backEnableColor = backEnableColor
        self.backDisableColor = backDisableColor
        self.font = font
        self.vPadding = vPadding
        self.disabled = disabled
        self.showLoader = showLoader
    }
    var body: some View {
        HStack {
            if showLoader {
                PureProgressView(color: Color.white)
                    .padding(.horizontal,5)
            }
            Text(verbatim: item.localized)
                .font(font)
                .foregroundColor(textColor)
                .padding(.vertical,vPadding)
        }
        .frame(maxWidth: .infinity)
        .background(showLoader ? backDisableColor : backEnableColor)
        .cornerRadius(10)
    }
}
