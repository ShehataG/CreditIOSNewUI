//
//  TopRoundedText.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct TopRoundedText: View {
    let text:String
    let wid:CGFloat = isIpad ? 0.2 : 0.3
    var body: some View {
        Text(verbatim:text.localized)
            .font(Fonts.smallBold())
            .foregroundStyle(Color.white)
            .padding(.vertical,7)
            .frame(width: screenWidth * wid)
            .background(appGreenColor)
            .cornerRadius(15, corners: [.topLeft, .topRight])
    }
}
