//
//  RegisterView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine
 
struct RegisterView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var registerVM = RegisterVM()
    @FocusState private var captchaIsFocused: Bool
    @State var showMonthPicker = false
    @State var showYearPicker = false
    @State var isOn = false

    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.3)
            ScrollView(showsIndicators: false) {
                BackButton()
                CreditMainLogo()
                VStack(spacing:0) {
                    HeaderView(text: "Register")
                    NafazView()
                    TextInputView(placeholder: "EmailAddress", value: $registerVM.email, errorMessage: registerVM.emailErrorText, type: .email, keyboardType: .emailAddress, topPadding: 0)
                        .disabled(registerVM.disableAll)
                    TextInputView(placeholder: "NationalIqama", value: $registerVM.nationalId, errorMessage: registerVM.ninErrorText, type: .nationalId, keyboardType: .numberPad, topPadding: 20)
                        .modifier(LimitModifer(pin: $registerVM.nationalId, limit: 10))
                        .disabled(registerVM.disableAll)
                    TextInputView(placeholder: "PhoneNumberX", value: $registerVM.phone, errorMessage: registerVM.phoneErrorText, type: .phone, keyboardType: .numberPad, topPadding: 20)
                        .modifier(LimitModifer(pin: $registerVM.phone, limit: 10))
                        .disabled(registerVM.disableAll)
                    SecureInputView(placeholder: "Password", value: $registerVM.password, errorMessage: registerVM.passErrorText, type: .password, keyboardType: .default, topPadding: 20)
                        .disabled(registerVM.disableAll)
                    SecureInputView(placeholder: "ConfirmPassword", value: $registerVM.confirmPassword, errorMessage: registerVM.confirmPassErrorText, type: .password, keyboardType: .default, topPadding: 20)
                        .disabled(registerVM.disableAll)
                    if registerVM.showBirthYearMonth {
                        HStack {
                            BirthYInputView(placeholder: "BirthYear", isOn: $isOn, value: $registerVM.birthYear, showYearPicker: $showYearPicker, errorMessage: registerVM.birthYearErrorText, type: .birthYear,topPadding: 20)
                            BirthMInputView(placeholder: "BirthMonth", value: $registerVM.birthMonth, showMonthPicker: $showMonthPicker, errorMessage: registerVM.birthMonthErrorText, type: .birthMonth,topPadding: 20)
                        }
                    }
                    CaptchaInputView(placeholder: "CaptchaCode", value: $registerVM.captcha, token: $registerVM.captchaToken,captchaExpired: $registerVM.captchaExpired, errorMessage: registerVM.captchaErrorText, type: .captcha, keyboardType: UIKeyboardType.numberPad,topPadding: 20)
                        .focused($captchaIsFocused)
                    TermsPrivacyText(width: screenWidth - 40)
                    .padding(.vertical,15)
                    RoundedLoaderBu(item: "AddAccountOnly", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor , width: 0.8,vPadding: 15,showLoader:registerVM.submitLoading)
                        .onTapGesture {
                            registerVM.beginRegister()
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
        .toast(isPresenting: $registerVM.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: registerVM.toastContent)
        }
        .toast(isPresenting: $registerVM.toastShownInfo) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: registerVM.toastContentInfo)
        }
        .fullScreenCover(isPresented: $showYearPicker,onDismiss: {
            showYearPicker = false
         }) {
             YearPicker(isHigri: isOn, sentYear:$registerVM.birthYear)
                 .modifier(PresentationBackgroundModifier())
        }
        .fullScreenCover(isPresented: $showMonthPicker,onDismiss: {
             showMonthPicker = false
         }) {
             BirthMonthPicker(isHigri: isOn, birthMonth:$registerVM.birthMonth, birthMonthIdex: $registerVM.birthMonthIndex)
                 .modifier(PresentationBackgroundModifier())
        }
        .fullScreenCover(isPresented: $registerVM.showOTP,onDismiss: {
         }) {
             OtpView(oTPManager: registerVM)
                 .modifier(PresentationBackgroundModifier())
        }
        .onChange(of: registerVM.captcha, perform: { newValue in
             if newValue.count == 4 {
                 captchaIsFocused = false
             }
        })
        .onChange(of: registerVM.nationalId, perform: { newValue in
             if newValue != "" {
                 isOn = newValue.hasPrefix("1")
             }
        })
        .onChange(of: isOn, perform: { _ in
            registerVM.birthYear = ""
            registerVM.birthMonth = ""
        })
        .onChange(of: registerVM.shouldClose, perform: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              coordinator.goToRoot()
            }
        })
    }
}
