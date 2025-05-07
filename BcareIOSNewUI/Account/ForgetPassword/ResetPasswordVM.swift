//
//  ResetPasswordVM.swift
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
final class ResetPasswordVM : MainObservable {
    
    @Published var generalError = false
    @Published var generalErrorText = ""
    
    @Published var passwordErrorText:String?
    @Published var confirmPasswordErrorText:String?
    @Published var verifyCodeErrorText:String?
    
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var verifyCode = "";
    
    @Published var hashed = "";
    @Published var submitLoading = false
    @Published var diableEmailPhone = false
    @Published var disableNationalId = false
    
    @Published var showConfirmOTPLoader = false
    @Published var showResendOTPLoader = false
    @Published var counter = 90
    @Published var shouldClose = false
    @Published var resetPasswordUserData:ForgetPasswordResultItem?
    
    @Published var endResetPassword = false
    @Published var resetByEmailOrMobile = ""
    
    @Published var goToHome = false
    
    override init() {
        super.init() 
    }
    func beginForgetPassword(_ sentData:ResetPasswordSentItem) {
        
        let trimmedPassword = password.trimmed().replacedArabicDigitsWithEnglish
        let trimmedConfirmPassword = confirmPassword.trimmed().replacedArabicDigitsWithEnglish
        
        if verifyCode == "" {
            verifyCodeErrorText = "VerifyCodeRequired".localized
        }
        else {
            verifyCodeErrorText = nil
        }
        
        if trimmedPassword == "" {
            passwordErrorText = "PasswordRequired".localized
        }
        else {
            if trimmedPassword.isValidPassword() {
                passwordErrorText = nil
            }
            else {
                passwordErrorText = "PasswordIncorrect".localized
            }
        }
        
        if trimmedConfirmPassword == "" {
            confirmPasswordErrorText = "ConfirmPasswordRequired".localized
        }
        else {
            if trimmedPassword == trimmedConfirmPassword {
                confirmPasswordErrorText = nil
            }
            else {
                confirmPasswordErrorText = "ConfirmPasswordNotEqual".localized
            }
        }
        
        let parameters:[String:Any] = [
            "uid": sentData.uid,
            "token": "",
            "newPassword": password,
            "confirmNewPassword": confirmPassword,
            "otp": verifyCode,
            "hashed": sentData.hashed,
        ]
        
        if passwordErrorText != nil || confirmPasswordErrorText != nil || confirmPasswordErrorText != nil {
            return
        }
        
        if noNetwork() {
            showNoNetwork()
            return
        }
        
        Task {
            
            submitLoading = true
            
            let (result,error) = await JSONPlaceholderService.verifyForgetPasswordOTP.request(type: ResetPasswordItem.self,parameters: parameters)
            self.submitLoading = false
            switch result {
            case .success(let res):
                if res.errorCode == 1 {
                    self.showError(res.errorDescription)
                    userPassword = self.password
                    self.goToHome = true
                } else if res.errorCode == 38 {
                    self.showError(res.errorDescription)
                    self.goToHome = true
                } else {
                    self.showError(res.errorDescription)
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
