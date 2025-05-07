//
//  ForgetPasswordView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct ForgetPasswordView: View {
    @EnvironmentObject var coordinator: Coordinator
    @FocusState private var focusedField: Field?
    @StateObject var forgetPasswordVM = ForgetPasswordVM()
    @FocusState private var captchaIsFocused: Bool

    var body: some View {
        ZStack(alignment: .top) {
           BackPlaceholderView(factor: 0.3)
            ScrollView(showsIndicators: false) {
                BackButton()
                HeaderView(text: "ResetPassword") 
                VStack(spacing:0) {
                    if forgetPasswordVM.showOptionView {
                        HStack {
                            Text(verbatim: "ChooseEmailOrPhone".localized)
                                .font(Fonts.mediumLight())
                                .foregroundColor(.black)
                                .padding(.bottom,30)
                            Spacer()
                        }
                        RadioView(items: [forgetPasswordVM.resetPasswordUserData?.email ?? "",forgetPasswordVM.resetPasswordUserData?.phone ?? ""], selected: $forgetPasswordVM.selectedOption)
                            .padding(.bottom,30)
                    }
                    else {
                        if let message = forgetPasswordVM.generalErrorText {
                            ErrorLocalizedCenterView(text:message)
                                .padding(.top,10)
                                .padding(.bottom,20)
                        }
                        TextInputView(placeholder: "EnterEmailPhone", value: $forgetPasswordVM.emailOrPhone, errorMessage: forgetPasswordVM.emailOrPhoneErrorText, type: .email, keyboardType: .emailAddress, topPadding: 0)
                            .disabled(forgetPasswordVM.diableEmailPhone)
                        GrayText(text:"ORDashed".localized)
                            .font(Fonts.smallLight())
                        TextInputView(placeholder: "InsuredNational", value: $forgetPasswordVM.nationalId, errorMessage: forgetPasswordVM.ninErrorText, type: .nationalId, keyboardType: .numberPad, topPadding: 20)
                            .disabled(forgetPasswordVM.disableNationalId)
                    }
                    CaptchaInputView(placeholder: "CaptchaCode", value: $forgetPasswordVM.captcha, token: $forgetPasswordVM.captchaToken,captchaExpired: $forgetPasswordVM.captchaExpired, errorMessage: forgetPasswordVM.captchaErrorText, type: .captcha, keyboardType: UIKeyboardType.numberPad,topPadding: 20)
                        .focused($captchaIsFocused)
                    
                    RoundedLoaderBu(item: "SendLink", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor , width: 0.8,vPadding: 15,showLoader:forgetPasswordVM.submitLoading)
                        .padding(.top,20)
                        .onTapGesture {
                            forgetPasswordVM.beginForgetPassword()
                        }
                }
                .padding(20)
                .padding(.vertical,10)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
            }
            //.scrollIndicators(.never)
        }
        .background(Color.lightGrayMore)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
        .toast(isPresenting: $forgetPasswordVM.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: forgetPasswordVM.toastContent)
        }
        .onChange(of: forgetPasswordVM.captcha, perform: { newValue in
            if newValue.count == 4 {
                captchaIsFocused = false
            }
        })
        .onChange(of: forgetPasswordVM.emailOrPhone, perform: { _ in
            forgetPasswordVM.nationalId = ""
        })
        .onChange(of: forgetPasswordVM.nationalId, perform: { _ in
            forgetPasswordVM.emailOrPhone = ""
        })
        .onChange(of: forgetPasswordVM.goResetPassword, perform: { _ in
            if let item = forgetPasswordVM.resetPasswordItem {
                coordinator.push(item)
            }
        })
        .onChange(of: forgetPasswordVM.endResetPassword, perform: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                coordinator.pop()
            }
        })
    }
}
