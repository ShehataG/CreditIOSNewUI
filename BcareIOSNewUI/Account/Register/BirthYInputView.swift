//
//  BirthYInputView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct BirthYInputView: View {
    let placeholder:String
    @Binding var isOn:Bool
    @Binding var value:String
    @Binding var showYearPicker:Bool
    let errorMessage:String?
    @FocusState private var focusedField: Field?
    let type:Field
    let topPadding:CGFloat
    var body: some View {
        VStack(spacing:0) {
            HStack {
                VStack {
                    TextField(placeholder.localized, text: $value)
                        .font(Fonts.smallRegular())
                        .frame(height: 46)
                        .foregroundColor(appBlueColor)
                        .multilineTextAlignment(.leading)
                        .focused($focusedField, equals: type)
                        .padding(.vertical,3)
                        .padding(.horizontal,10)
                        .colorScheme(.light)
                        .disabled(true)
                }
                .background(Color.white)
                .onTapGesture {
                    showYearPicker = true
                }
                //            HStack {
                //                Toggle("",isOn:$isOn)
                //                    .toggleStyle(.switch)
                //                    .tint(appBlueColor)
                //                    .labelsHidden()
                //                GrayText(text:"Higri".localized)
                //                    .font(Fonts.smallLight())
                //                    .padding(.trailing,10)
                //            }
                Spacer()
                Text(verbatim: FontAwesome.arrowDownIcon)
                    .font(Fonts.fontAwesome15_20())
                    .foregroundColor(appBlueColor)
                    .padding(.horizontal,10)
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
