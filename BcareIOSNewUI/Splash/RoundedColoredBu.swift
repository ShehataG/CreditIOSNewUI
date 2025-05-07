//
//  RoundedColoredBu.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct RoundedColoredBu: View {
    let item:String
    let width:CGFloat
    let color:Color
    init(item: String, width: CGFloat, color: Color = appBlueColor) {
        self.item = item
        self.width = width
        self.color = color
    }
    var body: some View {
        Text(item.localized)
            .font(Fonts.mediumRegular())
            .foregroundColor(Color.white)
            .padding(.vertical,10)
            .frame(width: screenWidth * width)
            .background(color)
            .cornerRadius(10)
    }
}
