//
//  LoginVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import LocalAuthentication
import KeychainSwift
import AdjustSdk

@MainActor
final class RegisterVM : MainObservable {
    @Published var email = ""
    @Published var phone = ""
    @Published var nationalId = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var birthYear = ""
    @Published var birthMonth = ""
    
    @Published var emailErrorText:String?
    @Published var phoneErrorText:String?
    @Published var ninErrorText:String?
    @Published var passErrorText:String?
    @Published var confirmPassErrorText:String?
    @Published var facePassSuccess = false
    @Published var facePassError = ""
    @Published var submitLoading = false
    @Published var getBirthDate = false
    @Published var registerHashed = ""
    @Published var isYakeenChecked = false
    
    @Published var birthYearErrorText:String?
    @Published var birthMonthErrorText:String?
    @Published var birthMonthIndex = 1

    @Published var showBirthYearMonth = false
    @Published var nameEn = ""
    @Published var nameAr = ""
    
    @Published var disableAll = false
    
    @Published var showConfirmOTPLoader = false
    @Published var showResendOTPLoader = false
    @Published var counter = 90
    @Published var shouldClose = false
    @Published var errorMessage:String?
    @Published var infoMessage:String?
    @Published var showErrorMessage = false
    @Published var showInfoMessage = false
    @Published var showOTP = false

    @Published var captcha = ""
    @Published var captchaErrorText:String?
    @Published var captchaToken = ""
    @Published var captchaExpired = false
    
    override init() {
        super.init()
        Task { @MainActor in
            counterBase = 90
             await initDev()
        }
     }
    
    func initDev() async {
        #if DEBUG
//            email = "shehata.g@neomtech.com"
//            phone = "0553837475"
//            nationalId = "2558397770"
//            password = "@BcareAsd2514345"
//            birthYear = "1991"
//            birthMonth = "GMonthList1".localized
//            birthMonthIndex = 1
        #endif
    }
    func beginRegister() {
        let trimmedEmail = email.trimmed()
        if trimmedEmail == "" {
            emailErrorText = "EmailRequired".localized
        }
        else {
            if trimmedEmail.isValidEmail() {
                emailErrorText = nil
            }
            else {
                emailErrorText = "EmailIncorrect".localized
            }
        }
        let trimmedPhone = phone.replacedArabicDigitsWithEnglish
        if trimmedPhone == "" {
            phoneErrorText = "PhoneRequired".localized
        }
        else {
            if trimmedPhone.isValidPhone() {
                phoneErrorText = nil
            }
            else {
                phoneErrorText = "PhoneIncorrect".localized
            }
        }
        let trimmedNationalId = nationalId.trimmed().replacedArabicDigitsWithEnglish
        if trimmedNationalId == "" {
            ninErrorText = "NinRequired".localized
        }
        else {
            if trimmedNationalId.isValidNational() {
                ninErrorText = nil
            }
            else {
                ninErrorText = "NinIncorrect".localized
            }
        }
        
        let trimmedPassword = password.trimmed().replacedArabicDigitsWithEnglish
        if trimmedPassword == "" {
            passErrorText = "PasswordRequired".localized
        }
        else {
            if trimmedPassword.isValidPassword() {
                passErrorText = nil
            }
            else {
                passErrorText = "PasswordIncorrect".localized
            }
        }
        
        let trimmedCofirmPassword = confirmPassword.trimmed().replacedArabicDigitsWithEnglish
        if trimmedCofirmPassword == "" {
            confirmPassErrorText = "ConfirmPasswordRequired".localized
        }
        else {
            if trimmedPassword == trimmedCofirmPassword {
                confirmPassErrorText = nil
            }
            else {
                confirmPassErrorText = "ConfirmPasswordNotEqual".localized
            }
        }
          
        
        var trimmedBYear = ""
        var trimmedBMonth = ""
        
        if showBirthYearMonth {
            trimmedBYear = birthYear
            if trimmedBYear == "" {
                birthYearErrorText = "BirthYearRequired".localized
            }
            else {
                birthYearErrorText = nil
            }
            trimmedBMonth = birthMonth
            if trimmedBMonth == "" {
                birthMonthErrorText = "BirthMonthRequired".localized
            }
            else {
                birthMonthErrorText = nil
            }
        }
        
        let trimmedCaptcha = captcha
        if trimmedCaptcha == "" {
            captchaErrorText = "CaptchaRequired".localized
        }
        else if trimmedCaptcha.count != 4 {
            captchaErrorText = "CaptchaIncorrect".localized
        }
        else {
            captchaErrorText = nil
        }
        
        
        if emailErrorText != nil || phoneErrorText != nil || ninErrorText != nil || passErrorText != nil || (showBirthYearMonth && (birthYearErrorText != nil || birthMonthErrorText != nil)) || (captchaErrorText != nil || captchaExpired) {
            return
        }
        
        if noNetwork() {
            showNoNetwork()
            return
        }
        
        let parameters:[String:Any] =  [
            "email": trimmedEmail,
            "mobile": trimmedPhone,
            "nationalId": trimmedNationalId,
            "password": trimmedPassword,
            "birthYear": birthYear,
            "birthMonth": birthMonthIndex.toString(),
            "hashed": registerHashed,
            "CaptchaInput": trimmedCaptcha,
            "CaptchaToken": captchaToken
        ]
        Task {
            submitLoading = true
            if !getBirthDate {
                let (result,error) = await JSONPlaceholderService.beginRegister.request(type: BeginLoginItem.self,parameters: parameters)
                DispatchQueue.main.async {
                    self.submitLoading = false
                }
                switch result {
                case .success(let res):
                    print(res)
                    if res.errorCode != 1 {
                        self.registerHashed = res.result.hashed ?? ""
                        if res.result.phoneVerification == true {
                            //self.phone = res.result.phone ?? res.result.phoneNumber ?? ""
                            userPhone = self.phone
                            self.processName(res)
                            self.showInfo(res.errorDescription)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.showOTP = true
                            }
                        }
                        if res.result.getBirthDate == true {
                            self.disableAll = true
                            self.processName(res)
                            self.showBirthYearMonth = true
                            self.getBirthDate = true
                        }
                        self.handleCases(res)
                    }
                    break
                case .failure(_):
                    if let error = error {
                        print(error)
                        self.showError(error.description)
                    }
                    break
                }
            }
            else {
                let (result,error) = await JSONPlaceholderService.endRegister.request(type: BeginLoginItem.self,parameters: parameters)
                self.submitLoading = false
                switch result {
                case .success(let res):
                    print(res)
                    self.registerHashed = res.result.hashed ?? ""
                    if (res.errorCode != 1) {
                        self.showError(res.errorDescription)
                        self.handleCases(res)
                    }
                    if (res.result.phoneVerification == true) {
                        //self.phone = res.result.phone ?? res.result.phoneNumber ?? ""
                        userPhone = self.phone
                        self.processName(res)
                        self.showInfo(res.errorDescription)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.showOTP = true
                        }
                    }
                    break
                case .failure(_):
                    if let error = error {
                        print(error)
                        self.showError(error.description)
                    }
                    break
                }
            }
        }
    }
    func processName(_ res:BeginLoginItem)  {
        let nameE = res.result.fnen ?? ""
        let nameA = res.result.fnar ?? ""
        nameEn = nameE
        nameAr = nameA
        displayNameEn = nameE.firstName()
        displayNameAr = nameA.firstName()
    }
    func handleCases(_ res:BeginLoginItem) {
        if ![5,9,48].contains(res.errorCode) { // 54 is Wrong captcha code not in list
           showError(res.errorDescription)
        }

        if res.errorCode != 48 {
           reloadCaptcha()
        }
    }
    func reloadCaptcha() {
        captcha = ""
        NotificationCenter.default.post(name: .captchaNotification, object: nil)
    }
}


extension RegisterVM : OTPManager {
    func verify(_ otp:String) {
        if noNetwork() {
            showNoNetwork()
            return
        }
        let parameters:[String:Any] = [
            "email": email,
            "password": password,
            "mobile": phone,
            "nationalId": nationalId,
            "OTP": otp,
            "isRegister": true,
            "birthYear": birthYear,
            "birthMonth": birthMonthIndex.toString(),
            "fnen": nameEn,
            "fnar": nameAr,
            "hashed": registerHashed,
            "Channel":"ios"
        ]
        print(parameters)
        Task {
            showConfirmOTPLoader = true
            let (result,error) = await JSONPlaceholderService.verifyRegisterOTP.request(type: BeginLoginItem.self,parameters: parameters)
            self.showConfirmOTPLoader = false
            switch result {
            case .success(let res):
                print(res)
                if res.errorCode != 1 {
                    self.errorMessage = res.errorDescription
                    self.showErrorMessage = true
                }
                else {
                    tokenExpirationDate = res.result.tokenExpirationDate
                    expiryDate = Date()
                    userAccessToken = res.result.accessToken
                    userEmail = self.email
                    userPassword = self.password
                    userId = res.result.userId
                    if let nin = res.result.nationalId {
                        userNationalId = nin
                    }
                    displayNameAr = res.result.displayNameAr
                    displayNameEn = res.result.displayNameEn
                    isRenewel = nil
                    isCorporate = res.result.isCorporateUser ?? false
                    isCorporateAdmin = res.result.isCorporateAdmin ?? false
                    faceDone = true
                    Adjust.trackEvent(ADJEvent(eventToken: "x1ivs7"))
                    AppDelegate.shared.registerToken()
                    NotificationCenter.default.post(name: .reloadPoliciesNotification, object: nil)
                    if let service = servicesStatusItem , service.sanar {
                        NotificationCenter.default.post(name: .sanarConnectNotification, object: nil)
                    }
                    self.shouldClose = true
                }
                break
            case .failure(_):
                if let error = error {
                    print(error)
                    self.errorMessage = error.description
                    self.showErrorMessage = true
                }
                break
            }
        }
    }
    func resend() {
        if noNetwork() {
            showNoNetwork()
            return
        }
        let parameters:[String:Any] = [
            "email": email.encrypted,
            "phone": phone,
            "nationalId": nationalId,
            "language":langText,
            "isloginByNationalId": false
        ]
        Task {
            showResendOTPLoader = true
            let (result,error) = await JSONPlaceholderService.resendOTP.request(type: LoginResendOTPItem.self,parameters: parameters)
            self.showResendOTPLoader = false
            switch result {
            case .success(let res):
                print(res)
                if res.errorCode != 1 {
                    self.errorMessage = res.errorDescription
                    self.showErrorMessage = true
                }
                else  {
                    counterBase += 10
                    self.counter = counterBase
                }
                break
            case .failure(_):
                if let error = error {
                    print(error)
                    self.errorMessage = error.description
                    self.showErrorMessage = true
                }
                break
            }
        }
    }
}
