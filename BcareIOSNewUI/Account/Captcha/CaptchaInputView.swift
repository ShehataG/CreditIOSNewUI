//
//  CaptchaInputView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct CaptchaInputView: View {
    let placeholder:String
    @Binding var value:String
    @Binding var token:String
    @Binding var captchaExpired:Bool
    let errorMessage:String?
    @FocusState private var focusedField: Field?
    let type:Field
    let keyboardType:UIKeyboardType
    let topPadding:CGFloat
    @StateObject var captchaVM = CaptchaVM()
    let totalHeight:CGFloat = 52
    
    init(placeholder: String, value: Binding<String>, token: Binding<String>, captchaExpired: Binding<Bool>, errorMessage: String?, type: Field, keyboardType: UIKeyboardType, topPadding: CGFloat) {
        self.placeholder = placeholder
        self._value = value
        self._token = token
        self._captchaExpired = captchaExpired
        self.errorMessage = errorMessage
        self.type = type
        self.keyboardType = keyboardType
        self.topPadding = topPadding
    }
    var body: some View {
        VStack(spacing:0) {
            VStack {
                HStack {
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
                        .modifier(LimitModifer(pin: $value, limit: 4))
                    Spacer()
                    Button {
                    } label: {
                        FA6Text(text: FontAwesome6.syncIcon,color: captchaVM.captchaExpired ? Color.red : Color.black)
                            .onTapGesture {
                                captchaVM.getCaptcha()
                            }
                            .padding(.horizontal,10)
                    }
                    if captchaVM.submitLoadingCaptcha || captchaVM.image == "" {
                        LoadingView()
                            .frame(width:totalHeight*2,height: totalHeight)
                    }
                    else {
                        Image(base64String: captchaVM.image)!
                            .resizable()
                            .frame(width:totalHeight*2,height: totalHeight)
                            .pulseEffect(showAnimation: captchaVM.captchaExpired)
                    }
                }
                .frame(height: 52)
            }
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.lightGray.opacity(0.2), lineWidth: 1)
            )
            .padding(.top,topPadding)
            if captchaVM.captchaExpired {
                ErrorLocalizedView(text:"CaptchaExpired")
                    .padding(.top,3)
            }
            else {
                if let message = errorMessage {
                    ErrorLocalizedView(text:message)
                        .padding(.top,3)
                }
            }
        }
        .onChange(of: captchaVM.token, perform: { token in
            self.token = token
        })
        .onChange(of: captchaVM.captchaExpired, perform: { captchaExpired in
            self.captchaExpired = captchaExpired
        })
        .onReceive(.captchaNotification) { _ in
            captchaVM.getCaptcha()
        }
    }
}
