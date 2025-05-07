//
//  CarModelnputView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct CarModelnputView: View {
    let placeholder:String
    @Binding var value:String
    @Binding var showModelPicker:Bool
    let errorMessage:String?
    @FocusState private var focusedField: Field?
    let type:Field
    let topPadding:CGFloat
    let imgWid:CGFloat = isIpad ? 35 : 25
    var body: some View {
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
                showModelPicker = true
            }
            Spacer()
            HStack {
                Image("arrowDown")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imgWid,height: imgWid)
                    .padding(.trailing,10)
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
                .padding(.top,3)
        }
    }
}
