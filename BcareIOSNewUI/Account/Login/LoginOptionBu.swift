//
//  LoginOptionBu.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct LoginOptionBu: View {
    let item:String
    let width:CGFloat
    let vPadding:CGFloat
    let selected:Bool
    init(item: String, width: CGFloat = 0.0, vPadding: CGFloat,selected:Bool) {
        self.item = item
        self.width = width
        self.vPadding = vPadding
        self.selected = selected
    }
    var body: some View {
        if selected {
            Text(verbatim: item.localized)
                .font(Fonts.smallRegular())
                .foregroundColor(.white)
                .padding(.vertical,vPadding)
                .frame(width: screenWidth * width)
                .background(appBlueColor)
                .cornerRadius(10)
        }
        else {
            Text(verbatim: item.localized)
                .font(Fonts.smallRegular())
                .foregroundColor(appBlueColor)
                .padding(.vertical,vPadding)
                .frame(width: screenWidth * width)
                .background(Color.white)
                .cornerRadius(10)
        }
    }
}
