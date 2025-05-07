//
//  MojazInputView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct MojazInputView: View {
    let placeholder:String
    @Binding var value:String
    let showError:Bool
    let errorMessage:String
    @FocusState private var focusedField: Field?
    let type:Field
    let keyboardType:UIKeyboardType
    let topPadding:CGFloat
    init(placeholder: String, value: Binding<String>, showError: Bool, errorMessage: String, type: Field, keyboardType: UIKeyboardType, topPadding: CGFloat) {
        self.placeholder = placeholder
        self._value = value
        self.showError = showError
        self.errorMessage = errorMessage
        self.type = type
        self.keyboardType = keyboardType
        self.topPadding = topPadding
    }
    var body: some View {
        VStack {
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
            .cornerRadiusWithBorder(radius: 10, borderLineWidth: 1, borderColor: Color.lightGray)
            if showError {
                ErrorLocalizedView(text:errorMessage)
                    .padding(.top,3)
            }
        }
        .padding(.top,topPadding)
    }
}
