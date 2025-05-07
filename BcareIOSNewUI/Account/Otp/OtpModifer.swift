//
//  OtpModifer.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct OtpModifer: ViewModifier {
    @Binding var pin : String
    let showError:Bool
    func body(content: Content) -> some View {
        VStack {
            content
                .font(Fonts.smallRegular())
                .frame(height: screenWidth * 0.25)
                .foregroundColor(appBlueColor)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .padding(.vertical,3)
                .padding(.horizontal,10)
                .colorScheme(.light)
                .modifier(LimitModifer(pin: $pin))
        }
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(showError ? Color.red : Color(hex:"#96ACB9")!, lineWidth: 1)
        )
    }
}
