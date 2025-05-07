//
//  ProfileContactsView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct ProfileContactsView: View {
    let profileVM:ProfileVM
    let top:String
    let placeholder:String
    let disable:Bool
    @Binding var value:String
    @Binding var isEditing:Bool
    let type:Field
    let keyboardType:UIKeyboardType
    @FocusState private var focusedField: Field?
    @State var disableSave = true
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(verbatim: top.localized)
                    .font(Fonts.verySmallRegular())
                    .foregroundColor(Color.black)
                if isEditing {
                    TextField(placeholder.localized, text: $value)
                        .font(Fonts.tooSmallLight())
                        .foregroundColor(appBlueColor)
                        .keyboardType(keyboardType)
                        .focused($focusedField, equals: type)
                        .padding(.top,3)
                        .colorScheme(.light)
                }
                else {
                    Text(verbatim: value)
                        .font(Fonts.tooSmallLight())
                        .foregroundColor(appBlueColor)
                        .padding(.top,3)
                }
            }
            .padding(.leading,50)
            .padding(.vertical,20)
            Spacer()
            HStack {
                if isEditing {
                    if disable {
                        PureProgressView()
                            .padding(.horizontal,5)
                    }
                    let saveColor = disableSave ? Color.lightGrayMid : appOrangeColor
                    FAText(text: FontAwesome.saveIcon, color: saveColor)
                        .padding(.horizontal,5)
                        .disabled(disableSave)
                        .onTapGesture {
                            profileVM.sendOtpPhone(type: type)
                        }
                    FAText(text: FontAwesome.closeIcon, color: Color.lightGrayMid)
                        .onTapGesture {
                            isEditing.toggle()
                        }
                }
                else {
                    FAText(text: FontAwesome.editIcon, color: Color.lightGrayMid)
                        .onTapGesture {
                            isEditing.toggle()
                            focusedField = type
                        }
                }
            }
            .padding(.horizontal,20)
        }
        .disabled(disable)
        .frame(maxWidth: .infinity)
        .background(Rectangle().fill(Color.white).cornerRadius(10.0).shadow(radius: 3,x: -3,y: 3))
        .onChange(of: value, perform: { _ in
            if type == .email {
                disableSave = value == userEmail || !value.isValidEmail()
            }
            else  if type == .phone {
                disableSave = value == userPhone || !value.isValidPhone()
            }
        })
    }
}
