//
//  PolicyFAView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct PolicyFAView: View {
    let title:String
    let icon:String
    let cardHeight:CGFloat = isIpad ? 80 : 60
    var body: some View {
        HStack {
            FAColoredText(text: icon)
                .padding(.horizontal,5)
            Text(verbatim: title.localized)
                .font(Fonts.tooSmallLight())
                .foregroundColor(appBlueColor)
            Spacer()
        }
        .frame(width: screenWidth * 0.3)
        .frame(height: cardHeight)
        .background(Rectangle().fill(Color.white).cornerRadius(10.0).shadow(radius: 3,x: -3,y: 3))
    }
}
