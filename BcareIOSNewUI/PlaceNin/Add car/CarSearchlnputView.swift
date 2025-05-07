//
//  CarSearchlnputView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct CarSearchlnputView: View {
    let placeholder:String
    @Binding var value:String
    @FocusState private var focusedField: Field?
    let type:Field
    let topPadding:CGFloat
    let imgWid:CGFloat = isIpad ? 25 : 15
    var body: some View {
        HStack {
            Image("search")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imgWid,height: imgWid)
                .padding(.horizontal,5)
            VStack {
                TextField(placeholder.localized, text: $value)
                    .font(Fonts.smallRegular())
                    .frame(height: 46)
                    .foregroundColor(appBlueColor)
                    .multilineTextAlignment(.leading)
                    .focused($focusedField, equals: type)
                    .padding(.vertical,3)
                    .colorScheme(.light)
            }
            .background(Color.white)
        }
        .padding(.horizontal,10)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.lightGray.opacity(0.2), lineWidth: 1)
        )
        .padding(.top,topPadding)
    }
}
