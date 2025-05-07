//
//  ForgetPasswordVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import LocalAuthentication
import KeychainSwift

@MainActor
final class ForgetPasswordVM : MainObservable {
    
    @Published var generalErrorText:String?
    
    @Published var emailOrPhoneErrorText:String?
    @Published var ninErrorText:String?
      
    @Published var emailOrPhone = ""
    @Published var nationalId = ""
    @Published var phone = ""
    
    @Published var hashed = "";
    @Published var submitLoading = false
    @Published var diableEmailPhone = false
    @Published var disableNationalId = false
    
    @Published var showConfirmOTPLoader = false
    @Published var showResendOTPLoader = false
    @Published var counter = 90
    @Published var shouldClose = false
    @Published var resetPasswordUserData:ForgetPasswordResultItem?
    @Published var ninError = false
    
    @Published var endResetPassword = false
    @Published var resetByEmailOrMobile = ""
    @Published var goResetPassword = false

    @Published var resetPasswordItem:ResetPasswordSentItem?
    @Published var selectedOption: RadioButton = .email
    @Published var showOptionView = false

    @Published var captcha = ""
    @Published var captchaErrorText:String?
    @Published var captchaToken = ""
    @Published var captchaExpired = false
    
    override init() {
        super.init()
        Task { @MainActor in
            counterBase = 90
        }
    }
    func beginForgetPassword() {
        if resetPasswordUserData == nil {
            if emailOrPhone.count == 0 && nationalId.count == 0 {
                generalErrorText = "ForgetFillOption".localized
                return
            }
            else {
                generalErrorText = nil
            }
            var trimmedEmailOrPhone = ""
            var trimmedNationalId = ""
            if emailOrPhone.count > 0 {
                ninError = true
                trimmedEmailOrPhone = emailOrPhone.trimmed()
                if trimmedEmailOrPhone == "" {
                    emailOrPhoneErrorText = "EmailRequired".localized
                }
                if emailOrPhone.isNumber { // Phone
                    if trimmedEmailOrPhone.isValidPhone() {
                        emailOrPhoneErrorText = nil
                    }
                    else {
                        emailOrPhoneErrorText = "PhoneIncorrect".localized
                    }
                }
                else { // Email
                    if trimmedEmailOrPhone.isValidEmail() {
                        emailOrPhoneErrorText = nil
                    }
                    else {
                        emailOrPhoneErrorText = "EmailIncorrect".localized
                    }
                }
            }
            else {
                trimmedNationalId = nationalId
                if trimmedNationalId.isValidNational() {
                    ninError = false
                }
                else {
                    ninErrorText = "NinIncorrect".localized
                    ninError = true
                }
            }
            
            if emailOrPhoneErrorText != nil && ninError {
                return
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
            
            if (captchaErrorText != nil || captchaExpired) {
                return
            }
            
            if noNetwork() {
                showNoNetwork()
                return
            }
            
            let parameters:[String:Any] = [
                "mobileOrEmail": trimmedEmailOrPhone,
                "nationalId": trimmedNationalId,
                "isResetByNationalId": trimmedNationalId.count > 0,
                "isResetByEmailOrMobile": trimmedEmailOrPhone.count > 0,
                "hashed": hashed,
                "CaptchaInput": trimmedCaptcha,
                "CaptchaToken": captchaToken
            ]
            
            Task {
                submitLoading = true
                let (result,error) = await JSONPlaceholderService.beginForgetPassword.request(type: ForgetPasswordItem.self,parameters: parameters)
                self.submitLoading = false
                switch result {
                case .success(let res):
                    print(res)
                    self.hashed = res.result.hashed ?? ""
                    if res.errorCode == 1 {
                        self.showError(res.errorDescription)
                        self.resetPasswordUserData = res.result
                        self.showOptionView = true
                    }
                    else {
                        if res.errorCode == 52 {
                            self.showError(res.errorDescription)
                            self.endResetPassword = true
                        }
                        else if res.errorCode == 48 {
                            self.resetPasswordItem = ResetPasswordSentItem(uid: res.result.uid, hashed: self.hashed)
                            self.goResetPassword = true
                        } else {
                            self.showError(res.errorDescription)
                            self.reloadCaptcha()
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
        else {
            
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
            
            if (captchaErrorText != nil || captchaExpired) {
                return
            }
            
            if noNetwork() {
                showNoNetwork()
                return
            }
            
            let parameters:[String:Any] = [
                "isResetByEmail": selectedOption == .email,
                "isResetByMobile": selectedOption == .phone,
                "uid": resetPasswordUserData!.uid,
                "hashed": hashed,
                "CaptchaInput": trimmedCaptcha,
                "CaptchaToken": captchaToken
            ]
            
            Task {
                submitLoading = true
                let (result,error) = await JSONPlaceholderService.endForgetPassword.request(type: ForgetPasswordItem.self,parameters: parameters)
                self.submitLoading = false
                switch result {
                case .success(let res):
                    print(res)
                    if res.errorCode == 1 {
                        self.showError(res.errorDescription)
                    }
                    else if res.errorCode == 48 {
                        self.resetPasswordItem = ResetPasswordSentItem(uid: res.result.uid, hashed: self.hashed)
                        self.goResetPassword = true
                    }
                    else if res.errorCode == 52 {
                        self.endResetPassword = true
                        self.showError(res.errorDescription)
                    }
                    else {
                        self.showError(res.errorDescription)
                        self.reloadCaptcha()
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
    func reloadCaptcha() {
        captcha = ""
        NotificationCenter.default.post(name: .captchaNotification, object: nil)
    }
}
