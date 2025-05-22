//
//  LoginView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct LoginView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State var isOn = false
    @State var showYearPicker = false
    @State var showMonthPicker = false
    let faceSize:CGFloat = isIpad ? 65 : 45
    @StateObject var loginVM = LoginVM()
    @FocusState private var captchaIsFocused: Bool
    let imgWid:CGFloat = isIpad ? 35.0 : 25.0

    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.3)
            ScrollView(showsIndicators: false) {
                BackButton()
                CreditMainLogo()
                VStack(spacing:0) {
                    //                    HStack {
                    //                        LoginOptionBu(item: "NationalIqama", width: 0.4, vPadding: 15,selected: loginVM.nationalIdSelected)
                    //                            .onTapGesture {
                    //                                loginVM.nationalIdSelected = true
                    //                                loginVM.isYakeenChecked = false
                    //                            }
                    //                        Spacer()
                    //                        LoginOptionBu(item: "EmailAddress", width: 0.4, vPadding: 15,selected: !loginVM.nationalIdSelected)
                    //                            .onTapGesture {
                    //                                loginVM.nationalIdSelected = false
                    //                                loginVM.isYakeenChecked = false
                    //                            }
                    //                    }
                    //                    .padding(5)
                    //                    .background(Color.white)
                    //                    .cornerRadius(5)
                    HeaderView(text: "Login")
                    if loginVM.nationalIdSelected {
                        TextInputView(placeholder: "NationalIqama", value: $loginVM.nationalId, errorMessage: loginVM.ninErrorText, type: .nationalId, keyboardType: .numberPad, topPadding: 0)
                            .modifier(LimitModifer(pin: $loginVM.nationalId, limit: 10))
                        SecureInputView(placeholder: "Password", value: $loginVM.password, errorMessage: loginVM.passErrorText, type: .password, keyboardType: .default, topPadding: 20)
//                        if loginVM.showBirthYearMonthNational {
//                            HStack {
//                                BirthYInputView(placeholder: "BirthYear", isOn: $isOn, value: $loginVM.birthYear, showYearPicker: $showYearPicker, errorMessage: loginVM.birthYearErrorText, type: .birthYear,topPadding: 20)
//                                BirthMInputView(placeholder: "BirthMonth", value: $loginVM.birthMonth, showMonthPicker: $showMonthPicker, errorMessage: loginVM.birthMonthErrorText, type: .birthMonth,topPadding: 20)
//                            }
//                        }
//                        if loginVM.showPhone {
//                            TextInputView(placeholder: "PhoneNumberX", value: $loginVM.phone, errorMessage: loginVM.phoneErrorText, type: .phone, keyboardType: .numberPad, topPadding: 20)
//                                .modifier(LimitModifer(pin: $loginVM.phone, limit: 10))
//                        }
                    }
                    else {
                        TextInputView(placeholder: "EmailAddress", value: $loginVM.email, errorMessage: loginVM.emailErrorText, type: .email, keyboardType: .emailAddress, topPadding: 0)
                        SecureInputView(placeholder: "Password", value: $loginVM.password, errorMessage: loginVM.passErrorText, type: .password, keyboardType: .default, topPadding: 20)
                        if loginVM.showNationalAndPhone {
                            TextInputView(placeholder: "PhoneNumberX", value: $loginVM.phone, errorMessage: loginVM.phoneErrorText, type: .phone, keyboardType: .numberPad, topPadding: 20)
                            TextInputView(placeholder: "NationalIqama", value: $loginVM.nationalId, errorMessage: loginVM.ninErrorText, type: .nationalId, keyboardType: .numberPad, topPadding: 20)
                                .modifier(LimitModifer(pin: $loginVM.nationalId, limit: 10))
                        }
                        if loginVM.showBirthYearMonth {
                            HStack {
                                BirthYInputView(placeholder: "BirthYear", isOn: $isOn, value: $loginVM.birthYear, showYearPicker: $showYearPicker, errorMessage: loginVM.birthYearErrorText, type: .birthYear,topPadding: 20)
                                BirthMInputView(placeholder: "BirthMonth", value: $loginVM.birthMonth, showMonthPicker: $showMonthPicker, errorMessage: loginVM.birthMonthErrorText, type: .birthMonth,topPadding: 20)
                            }
                        }
                    }
                    CaptchaInputView(placeholder: "CaptchaCode", value: $loginVM.captcha, token: $loginVM.captchaToken,captchaExpired: $loginVM.captchaExpired, errorMessage: loginVM.captchaErrorText, type: .captcha, keyboardType: UIKeyboardType.numberPad,topPadding: 20)
                          .focused($captchaIsFocused)
                    
//                    HStack(alignment:.center,spacing:10) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 5)
//                                .fill(loginVM.termsDone ? appOrangeColor : Color.white)
//                                .border(loginVM.termsRed ? Color.red : appBlueColor,width: loginVM.termsDone ? 0 : 1)
//                                .frame(width:imgWid, height:imgWid)
//                            if loginVM.termsDone {
//                                FAText(text: FontAwesome.correctIcon,color: Color.white,font: Fonts.fontAwesome20_30())
//                            }
//                        }
//                        .padding(.leading,5)
//                        .onTapGesture {
//                            loginVM.termsDone.toggle()
//                            if loginVM.termsDone {
//                                loginVM.showTerms()
//                            }
//                        }
//                        Text(verbatim:"AgreeToQuery".localized)
//                            .font(Fonts.tooSmallLight())
//                            .foregroundColor(appBlueColor.opacity(0.5))
//                        Spacer()
//                        //                        Text(verbatim:"TermsConditions".localized)
//                        //                            .font(Fonts.tooSmallMedium())
//                        //                            .foregroundColor(appBlueColor)
//                        //                            .onTapGesture {
//                        //                                coordinator.push(TermsPrivacyItem(url: termsConditionsLink))
//                        //                            }
//                        //                        Text(verbatim:"And".localized)
//                        //                            .font(Fonts.tooSmallMedium())
//                        //                            .foregroundColor(appBlueColor.opacity(0.5))
//                        //                            .padding(.horizontal,2)
//                        //                            .onTapGesture {
//                        //                            }
//                        //                        Text(verbatim:"PrivacyPolicy".localized)
//                        //                            .font(Fonts.tooSmallMedium())
//                        //                            .foregroundColor(appBlueColor)
//                        //                            .onTapGesture {
//                        //                                coordinator.push(TermsPrivacyItem(url: privacyPolicyLink))
//                        //                            }
//                    }
//                    .padding(.vertical,20)
                    RoundedLoaderBu(item: "Continue", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor , width: 0.8,vPadding: 15,showLoader:loginVM.submitLoading)
                        .padding(.top,20)
                        .onTapGesture {
//                            if loginVM.nationalIdSelected {
                                loginVM.beginLoginNationalId()
//                            }
//                            else {
//                                loginVM.beginLoginEmail()
//                            }
                        }
                    //                    GrayText(text:"ForgotPassword".localized)
                    //                        .font(Fonts.smallLight())
                    //                        .padding(.vertical,15)
                    //                        .onTapGesture {
                    //                            coordinator.push(Destination.forgetPasswordPage)
                    //                        }
                    ColoredText(text:"LoginOrJoin".localized)
                        .font(Fonts.mediumLight())
                        .padding(.vertical,15)
                        .onTapGesture {
                            coordinator.push(Destination.registerPage)
                        }
                }
                .padding(20)
                .padding(.vertical,10)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
            }
            //.scrollIndicators(.never)
            VStack {
                Spacer()
                Image("face")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:faceSize,height:faceSize)
                    .padding(.bottom,30)
                    .onTapGesture {
                        Task {
                            await loginVM.startFace()
                        }
                    }
            }
        }
        .background(Color.lightGrayMore)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
        .toast(isPresenting: $loginVM.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: loginVM.toastContent)
        }
        .toast(isPresenting: $loginVM.toastShownInfo) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: loginVM.toastContentInfo)
        }
        .fullScreenCover(isPresented: $showYearPicker,onDismiss: {
            showYearPicker = false
         }) {
             YearPicker(isHigri: isOn, sentYear:$loginVM.birthYear)
                 .modifier(PresentationBackgroundModifier())
        }
        .fullScreenCover(isPresented: $showMonthPicker,onDismiss: {
             showMonthPicker = false
          }) {
              BirthMonthPicker(isHigri: isOn, birthMonth:$loginVM.birthMonth, birthMonthIdex: $loginVM.birthMonthIndex)
                  .modifier(PresentationBackgroundModifier())
        }
        .onChange(of: loginVM.nationalId, perform: { newValue in
            if newValue != "" {
                isOn = newValue.hasPrefix("1")
            }
        })
        .onChange(of: isOn, perform: { _ in
             loginVM.birthYear = ""
             loginVM.birthMonth = ""
        })
        .onChange(of: loginVM.captcha, perform: { newValue in
            if newValue.count == 4 {
                captchaIsFocused = false
            }
        })
        .onChange(of: loginVM.facePassSuccess, perform: { _ in
        }) 
        .fullScreenCover(isPresented: $loginVM.showOTP,onDismiss: {
        }) {
            OtpView(oTPManager: loginVM)
                .modifier(PresentationBackgroundModifier())
        }
        .onChange(of: loginVM.shouldClose, perform: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
               coordinator.goToRoot()
            }
        })
    }
}
