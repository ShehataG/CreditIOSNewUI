//
//  TextInputView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct TextInputView: View {
    let placeholder:String
    @Binding var value:String
    let errorMessage:String?
    @FocusState private var focusedField: Field?
    let type:Field
    let keyboardType:UIKeyboardType
    let topPadding:CGFloat
    init(placeholder: String, value: Binding<String>, errorMessage:String?, type: Field, keyboardType: UIKeyboardType, topPadding: CGFloat) {
        self.placeholder = placeholder
        self._value = value
        self.errorMessage = errorMessage
        self.type = type
        self.keyboardType = keyboardType
        self.topPadding = topPadding
    }
    var body: some View {
        VStack(spacing:0) {
            VStack {
                TextField(placeholder.localized, text: $value)
                    .font(Fonts.smallRegular())
                    .frame(height: 46)
                    .foregroundColor(appBlueColor)
                    .multilineTextAlignment(.leading)
                    .keyboardType(keyboardType)
                    .focused($focusedField, equals: type)
                    .padding(.vertical,3)
                    .padding(.horizontal,10)
                    .colorScheme(.light)
            }
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.lightGray.opacity(0.2), lineWidth: 1)
            )
            .padding(.top,topPadding)
            if let message = errorMessage {
                ErrorLocalizedView(text:message)
                    .padding(.top,3)
            }
        }
    }
}
