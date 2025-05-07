//
//  ChangePhoneVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import LocalAuthentication
import KeychainSwift

final class ChangePhoneVM : ObservableObject {
    @Published var currentType = 0
    @Published var showIdError = false
    @Published var showDobError = false
    @Published var facePassSuccess = false
    @Published var facePassError = ""
    @Published var toastShown = false
    @Published var toastContent = ""
    @Published var showOTP = false
    
    @Published var emailError = false
    @Published var emailErrorText = ""
    @Published var phoneError = false
    @Published var phoneErrorText = ""
    @Published var ninError = false
    @Published var ninErrorText = ""
    @Published var passError = false
    @Published var passErrorText = ""
    
    @Published var birthYearError = false
    @Published var birthYearErrorText = ""
    @Published var birthMonthError = false
    @Published var birthMonthErrorText = ""
    
    @Published var email = "shehata.g@neomtech.com";
    @Published var password = "@BcareAsd2514345";
    @Published var phone = "" // "0553837475";
    @Published var nationalId = "" // 2558397770";
    
    @Published var birthYear = "";
    @Published var birthMonth = "";
    @Published var nameEn = "";
    @Published var nameAr = "";
    @Published var hashed = "";
    @Published var isYakeenChecked = false
    @Published var submitLoading = false
    @Published var showNationalAndPhone = false
    @Published var showBirthYearMonth = false
    @Published var getBirthDate = false
    
    init() {
        //        if let _ = UserManager.getUsername() {
        //            UserManager.clear()
        //        }
        //        else {
        //            UserManager.setValue(name: "Shehata Gamal", dob: "1991",phone: "0553763452",email: "shehata.g@neomtech.com")
        //        }
        //beginRegister(email: "hjsdnsdnmsdnmsd@yahoo.com", password: "@jjfdjkdf3562n", mobile: "0511111111", nationalId: "2511111110", birthYear: "1999", birthMonth: "1")
    }
    func checkFacePass() {
        let context = LAContext()
        var error: NSError?
        var policy: LAPolicy?
        // Depending the iOS version we'll need to choose the policy we are able to use
        if #available(iOS 9.0, *) {
            // iOS 9+ users with Biometric and Passcode verification
            policy = .deviceOwnerAuthenticationWithBiometrics
        } else {
            // iOS 8+ users with Biometric and Custom (Fallback button) verification
            context.localizedFallbackTitle = ""
            policy = .deviceOwnerAuthentication
        }
        if context.canEvaluatePolicy(policy!, error: &error) {
            context.evaluatePolicy(policy!, localizedReason: "Please Add your touch Id / Passcode", reply: { [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self?.facePassSuccess = true
                    } else {
                        self?.facePassSuccess = false
                        self?.facePassError =  "You could not be verified; please try again."
                    }
                }
            })
        } else {
            self.facePassSuccess = false
            self.facePassError =  "Your device is not configured for biometric authentication."
        }
    }
    
    func beginLogin() {
        
        let trimmedEmail = email.trimmed()
        if trimmedEmail == "" {
            emailErrorText = "EmailRequired".localized
            emailError = true
        }
        else {
            if email.isValidEmail() {
                emailError = false
            }
            else {
                emailErrorText = "EmailIncorrect".localized
                emailError = true
            }
        }
        
        let trimmedPassword = password.trimmed().replacedArabicDigitsWithEnglish
        if trimmedPassword == "" {
            passErrorText = "PasswordRequired".localized
            passError = true
        }
        else {
            passError = false
        }
        
        var trimmedPhone = ""
        var trimmedNationalId = ""
        
        if showNationalAndPhone {
            trimmedPhone = phone.replacedArabicDigitsWithEnglish
            if trimmedPhone == "" {
                phoneErrorText = "PhoneRequired".localized
                phoneError = true
            }
            else {
                if trimmedPhone.isValidPhone() {
                    phoneError = false
                }
                else {
                    phoneErrorText = "PhoneIncorrect".localized
                    phoneError = true
                }
            }
            trimmedNationalId = nationalId.trimmed().replacedArabicDigitsWithEnglish
            if trimmedNationalId == "" {
                ninErrorText = "NinRequired".localized
                ninError = true
            }
            else {
                if trimmedNationalId.isValidNational() {
                    ninError = false
                }
                else {
                    ninErrorText = "NinIncorrect".localized
                    ninError = true
                }
            }
        }
        
        var trimmedBYear = ""
        var trimmedBMonth = ""
        
        if showBirthYearMonth {
            trimmedBYear = birthYear
            if trimmedBYear == "" {
                birthYearErrorText = "BirthYearRequired".localized
                birthYearError = true
            }
            else {
                birthYearError = false
            }
            trimmedBMonth = birthMonth
            if trimmedBMonth == "" {
                birthMonthErrorText = "BirthMonthRequired".localized
                birthMonthError = true
            }
            else {
                birthMonthError = false
            }
        }
       
        if emailError || passError || (showNationalAndPhone && (ninError || phoneError)) || (showBirthYearMonth && (birthYearError || birthMonthError)) {
            return
        }
        
        let parameters:[String:Any] = [
            "UserName": trimmedEmail.encrypted,
            "PWD": trimmedPassword.encrypted,
            "phone": trimmedPhone,
            "nationalId": trimmedNationalId,
            "birthYear": trimmedBYear,
            "birthMonth": trimmedBMonth,
            "fnen": nameEn,
            "fnar": nameAr,
            "hashed": hashed,
            "isYakeenChecked": isYakeenChecked
        ];
        
        if noNetwork() {
            return
        }
        
        submitLoading = true
        
        if (isYakeenChecked == false) {
            JSONPlaceholderService.beginLogin.request(type: BeginLoginItem.self,parameters: parameters) { [weak self] result,error in
                guard let strong = self else { return }
                DispatchQueue.main.async {
                    strong.submitLoading = false
                }
                switch result {
                case .success(let res):
                    DispatchQueue.main.async {
                        print(res)
                        if res.errorCode != 1 {
                            if res.result.phoneNumberConfirmed == false {
                                strong.showNationalAndPhone = true
                                strong.isYakeenChecked = true;
                            }
                            if res.result.phoneVerification == true {
                                strong.phone = res.result.phone ?? res.result.phoneNumber ?? ""
                                strong.showOTP = true
                                strong.nameEn = res.result.fnen ?? ""
                                strong.nameAr = res.result.fnar ?? ""
                            }
                            //strong.showError(res.errorDescription)
                        }
                        else {
                            tokenExpiryDate = res.result.tokenExpirationDate
                            expiryDate = Date()
                            strong.submitLoading = true
                            userEmail = strong.email
                            userId = res.result.userId
                            userPhone = res.result.phone ?? res.result.phoneNumber ?? ""
                            displayNameAr = res.result.displayNameAr
                            displayNameEn = res.result.displayNameEn
                            userAccessToken = res.result.accessToken ?? ""
                            isRenewel = nil
                            isCorporate = res.result.isCorporateUser ?? false
                        }
                    }
                    break
                case .failure(_):
                    if let error = error {
                        print(error)
                        strong.showError(error.description)
                    }
                    break
                }
            }
        }
        else {
            if getBirthDate == false {
                JSONPlaceholderService.verifyYakeenMobile.request(type: BeginLoginItem.self,parameters: parameters) { [weak self] result,error in
                    guard let strong = self else { return }
                    DispatchQueue.main.async {
                        strong.submitLoading = false
                    }
                    switch result {
                    case .success(let res):
                        print(res)
                        DispatchQueue.main.async {
                            strong.isYakeenChecked = res.result.isYakeenChecked;
                            if (res.errorCode != 1) {
                              strong.hashed = res.result.hashed ?? ""
                              strong.submitLoading = false
                              if res.result.getBirthDate == true {
                                  strong.showNationalAndPhone = false
                                  strong.showBirthYearMonth = true
                                  strong.nameEn = res.result.fnen ?? ""
                                  strong.nameAr = res.result.fnar ?? ""
                                  strong.getBirthDate = true
                              }
                            }
                            if res.result.phoneVerification == true {
                                strong.phone = res.result.phone ?? res.result.phoneNumber ?? ""
                                strong.showOTP = true
                                strong.nameEn = res.result.fnen ?? ""
                                strong.nameAr = res.result.fnar ?? ""
                            }
                            //strong.showError(res.errorDescription)
                        }
                        break
                      case .failure(_):
                        if let error = error {
                            print(error)
                            strong.showError(error.description)
                        }
                        break
                    }
                }
            }
            else {
                JSONPlaceholderService.endLogin.request(type: BeginLoginItem.self,parameters: parameters) { [weak self] result,error in
                    guard let strong = self else { return }
                    DispatchQueue.main.async {
                        strong.submitLoading = false
                    }
                    switch result {
                    case .success(let res):
                        print(res)
                        DispatchQueue.main.async {
                            strong.nameEn = res.result.fnen ?? ""
                            strong.nameAr = res.result.fnar ?? ""
                            strong.submitLoading = false
                            if res.result.phoneVerification == true {
                                strong.phone = res.result.phone ?? res.result.phoneNumber ?? ""
                                strong.showOTP = true
                            }
                        }
                        break
                    case .failure(_):
                        if let error = error {
                            print(error)
                            strong.showError(error.description)
                        }
                        break
                    }
                }
            }
        }
    }
    func showError(_ message:String?) {
        DispatchQueue.main.async {
            if let des = message {
                self.toastContent = des
                self.toastShown = true
            }
        }
    }
}
