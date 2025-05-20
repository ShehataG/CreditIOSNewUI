//
//  RoundedColoredText.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SVGKit

struct RoundedColoredText: View {
    let text:String
    let color:Color
    init(text: String, color: Color = appBlueColor) {
        self.text = text
        self.color = color
    }
    let wid:CGFloat = isIpad ? 0.1 : 0.2
    var body: some View {
        Text(verbatim:text.localized)
            .font(Fonts.smallRegular())
            .foregroundStyle(Color.white)
            .padding(.vertical,7)
            .padding(.horizontal,15)
            .frame(minWidth: screenWidth * wid)
            .background(color)
            .clipShape(Capsule())
    }
}
