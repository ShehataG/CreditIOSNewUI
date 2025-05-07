//
//  ServiceDiscountView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct ServiceDiscountView: View {
    var title:String
    var body: some View {
        HStack {
            Text(verbatim: title)
                .font(Fonts.tooSmallRegular())
                .foregroundColor(Color.white)
                .padding(.vertical,5)
                .padding(.leading,5)
                .padding(.trailing,10)
                .modifier(RoudingMod())
            Spacer()
        }
    }
}

struct RoudingMod: ViewModifier {
    func body(content: Content) -> some View {
        if isAr {
            content
                .background(Color.red)
                .cornerRadius(30, corners: [.topLeft, .bottomLeft])
        }
        else {
            content
                .background(Color.red)
                .cornerRadius(30, corners: [.topRight, .bottomRight])
        }
    }
}
