//
//  TextInputView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct SecureInputView: View {
    let placeholder:String
    @Binding var value:String
    let errorMessage:String?
    @FocusState private var focusedField: Field?
    let type:Field
    let keyboardType:UIKeyboardType
    let topPadding:CGFloat
    @State var hidePin = true
    var body: some View {
        VStack {
            HStack {
                if hidePin {
                    SecureField(placeholder.localized, text: $value)
                        .font(Fonts.smallRegular())
                        .frame(height: 46)
                        .foregroundColor(appBlueColor)
                        .multilineTextAlignment(.leading)
                        .keyboardType(keyboardType)
                        .focused($focusedField, equals: type)
                        .padding(.vertical,3)
                        .padding(.horizontal,10)
                        .colorScheme(.light)
                    Spacer()
                    FAText(text: FontAwesome.eyeHiddenIcon, color: Color.black)  
                        .padding(.horizontal,10)
                        .onTapGesture {
                            hidePin.toggle()
                        }
                }
                else {
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
                    Spacer()
                    FAText(text: FontAwesome.eyeShownIcon, color: Color.black)
                        .padding(.horizontal,10)
                        .onTapGesture {
                            hidePin.toggle()
                        }
                }
            }
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
        }
    }
}
