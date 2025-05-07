//
//  ResetPasswordView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct ResetPasswordView: View {
    let item:ResetPasswordSentItem
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var resetPasswordVM = ResetPasswordVM()
    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.3)
            ScrollView(showsIndicators: false) {
                BackButton()
                HeaderView(text: "NewPasswordEntry") 
                VStack(spacing:0) {
                    if resetPasswordVM.generalError {
                        ErrorLocalizedView(text:resetPasswordVM.generalErrorText)
                            .padding(.vertical,10)
                    }
                    TextInputView(placeholder: "VerificationCode", value: $resetPasswordVM.verifyCode, errorMessage: resetPasswordVM.verifyCodeErrorText, type: .verifyCode, keyboardType: .numberPad, topPadding: 0)
                        .disabled(resetPasswordVM.diableEmailPhone)
                    SecureInputView(placeholder: "NewPassword", value: $resetPasswordVM.password, errorMessage: resetPasswordVM.passwordErrorText, type: .password, keyboardType: .default, topPadding: 20)
                        .disabled(resetPasswordVM.diableEmailPhone)
                    SecureInputView(placeholder: "NewPasswordConfirmation", value: $resetPasswordVM.confirmPassword, errorMessage: resetPasswordVM.confirmPasswordErrorText, type: .confirmPassword, keyboardType: .default, topPadding: 20)
                        .disabled(resetPasswordVM.diableEmailPhone)
                    RoundedLoaderBu(item: "Confirm", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor , width: 0.8,vPadding: 15,showLoader:resetPasswordVM.submitLoading)
                        .padding(.top,20)
                        .onTapGesture {
                            resetPasswordVM.beginForgetPassword(item)
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
        .toast(isPresenting: $resetPasswordVM.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: resetPasswordVM.toastContent)
        }
        .onChange(of: resetPasswordVM.goToHome, perform: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                coordinator.pop(2)
            }
        })
    }
}
