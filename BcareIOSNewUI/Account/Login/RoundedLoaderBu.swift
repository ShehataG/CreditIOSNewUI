//
//  RoundedLoaderBu.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct RoundedLoaderBu: View {
    let item:String
    let textColor:Color
    let backEnableColor:Color
    let backDisableColor:Color
    let width:CGFloat
    let vPadding:CGFloat
    let disabled:Bool
    let font:Font
    let showLoader:Bool
    init(item: String, textColor: Color, backEnableColor: Color, backDisableColor: Color, font: Font = Fonts.mediumRegular(), width: CGFloat = 0.0, vPadding: CGFloat, disabled: Bool = false,showLoader:Bool = false) {
        self.item = item
        self.textColor = textColor
        self.backEnableColor = backEnableColor
        self.backDisableColor = backDisableColor
        self.font = font
        self.width = width
        self.vPadding = vPadding
        self.disabled = disabled
        self.showLoader = showLoader
    }
    var body: some View {
        if width == 0.0 {
            if showLoader {
                HStack {
                    PureProgressView(color: Color.white)
                        .padding(.horizontal,5)
                    Text(verbatim: item.localized)
                        .font(font)
                        .foregroundColor(textColor)
                        .padding(.vertical,vPadding)
                }
                .padding(.horizontal,15)
                .background(backDisableColor)
                .cornerRadius(10)
                .disabled(true)
            }
            else {
                HStack {
                    Text(verbatim: item.localized)
                        .font(font)
                        .foregroundColor(textColor)
                        .padding(.vertical,vPadding)
                        .padding(.horizontal,15)
                }
                .background(disabled ? backDisableColor : backEnableColor)
                .cornerRadius(10)
                .disabled(disabled)
            }
        }
        else {
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
            .frame(width: screenWidth * width)
            .background(showLoader ? backDisableColor : backEnableColor)
            .cornerRadius(10)
        }
    }
}
