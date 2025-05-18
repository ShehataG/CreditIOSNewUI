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
    let wid:CGFloat = isIpad ? 0.2 : 0.3
    var body: some View {
        Text(verbatim:text.localized)
            .font(Fonts.smallRegular())
            .foregroundStyle(Color.white)
            .padding(.vertical,5)
            .padding(.horizontal,10)
            .background(appBlueColor)
            .clipShape(Capsule())
    }
}
