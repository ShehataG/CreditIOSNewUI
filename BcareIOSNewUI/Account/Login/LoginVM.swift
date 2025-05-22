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

@MainActor
final class LoginVM : MainObservable {
    @Published var showIdError = false
    @Published var showDobError = false
    @Published var facePassSuccess = false
    @Published var facePassError = ""
    
    @Published var emailErrorText:String?
    @Published var phoneErrorText:String?
    @Published var ninErrorText:String?
    @Published var passErrorText:String?
    
    @Published var birthYearErrorText:String?
    @Published var birthMonthErrorText:String?
    @Published var birthMonthIndex = 1

    @Published var email = ""
    @Published var password = ""
    @Published var phone = ""
    @Published var nationalId = ""
    
    @Published var birthYear = "";
    @Published var birthMonth = "";
    @Published var nameEn = "";
    @Published var nameAr = "";
    @Published var hashed = "";
    
    @Published var isYakeenChecked = false
    @Published var submitLoading = false
    @Published var showPhone = false
    @Published var showNationalAndPhone = false
    @Published var showBirthYearMonth = false
    @Published var showBirthYearMonthNational = true
    @Published var getBirthDate = false
    
    @Published var showConfirmOTPLoader = false
    @Published var showResendOTPLoader = false
    @Published var counter = 90
    @Published var shouldClose = false
    @Published var errorMessage:String?
    @Published var infoMessage:String?
    @Published var showErrorMessage = false
    @Published var showInfoMessage = false
    @Published var nationalIdSelected = true
    @Published var showOTP = false

    @Published var captcha = ""
    @Published var captchaErrorText:String?
    @Published var captchaToken = ""
    @Published var captchaExpired = false
    @Published var termsDone = false
    @Published var termsRed = false


    override init() {
        super.init()
        Task { @MainActor in
            counterBase = 90
            await initDev()
        }
    }
    func initDev() async {
        #if DEBUG
            nationalId = "2558397770"
            birthYear = "1991"
            birthMonth = "GMonthList1".localized
            birthMonthIndex = 1
        #endif
    }
    func startFace() async {
        if nationalIdSelected {
            if let nationalId = userNationalId , let birthYear = userBirthYear ,
               let birthMonth = userBirthMonth , let birthMonthIndex = userBirthMonthIndex {
               let success = await FaceDetector.checkFacePass()
                facePassSuccess = success
                if success {
                    self.nationalId = nationalId
                    self.birthYear = birthYear
                    self.birthMonth = birthMonth
                    self.birthMonthIndex = birthMonthIndex
                    self.beginLoginNationalId()
                }
            }
        }
        else {
            if let mail = userEmail , let pass = userPassword {
                let success = await FaceDetector.checkFacePass()
                facePassSuccess = success
                if success {
                    self.email = mail
                    self.password = pass
                    self.beginLoginEmail()
                }
            }
        }
    }
    func beginLoginEmail() {
        
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
        
        let trimmedPassword = password.trimmed().replacedArabicDigitsWithEnglish
        if trimmedPassword == "" {
            passErrorText = "PasswordRequired".localized
        }
        else {
            passErrorText = nil
        }
        
        var trimmedPhone = ""
        var trimmedNationalId = ""
        
        if showNationalAndPhone {
            trimmedPhone = phone.replacedArabicDigitsWithEnglish
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
            trimmedNationalId = nationalId.trimmed().replacedArabicDigitsWithEnglish
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
        
        if !termsDone {
            termsRed = true
        }
        
        if emailErrorText != nil || passErrorText != nil || (showNationalAndPhone && (ninErrorText != nil || phoneErrorText != nil)) || (showBirthYearMonth && (birthYearErrorText != nil || birthMonthErrorText != nil)) || (captchaErrorText != nil || captchaExpired) || termsRed {
            return
        }
        
        if noNetwork() {
            showNoNetwork()
            return
        }
        
        let parameters:[String:Any] = [
            "UserName": trimmedEmail.encrypted,
            "PWD": trimmedPassword.encrypted,
            "phone": trimmedPhone,
            "nationalId": trimmedNationalId,
            "birthYear": trimmedBYear,
            "birthMonth": birthMonthIndex.toString(),
            "fnen": nameEn,
            "fnar": nameAr,
            "hashed": hashed,
            "isYakeenChecked": isYakeenChecked,
            "CaptchaInput": trimmedCaptcha,
            "CaptchaToken": captchaToken
        ]
        Task {
            submitLoading = true
            if !isYakeenChecked {
                 let (result,error) = await JSONPlaceholderService.beginLogin.request(type: BeginLoginItem.self,parameters: parameters)
                 self.submitLoading = false
                 switch result {
                case .success(let res):
                    print(res)
                    self.processName(res)
                    if res.errorCode != 1 {
                        if res.result.phoneNumberConfirmed == false {
                            self.showNationalAndPhone = true
                            self.isYakeenChecked = true;
                        }
                        if res.result.phoneVerification == true {
                            self.phone = res.result.phone ?? res.result.phoneNumber ?? ""
                            userPhone = self.phone
                            userNationalId = res.result.nationalId
                            self.showInfo(res.errorDescription)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.showOTP = true
                            }
                        }
                        self.handleCases(res)
                    }
                    else {
                        tokenExpirationDate = res.result.tokenExpirationDate
                        expiryDate = Date()
                        self.submitLoading = true
                        userEmail = self.email
                        userPassword = self.password
                        userId = res.result.userId
                        userPhone = res.result.phone ?? res.result.phoneNumber ?? ""
                        displayNameAr = res.result.displayNameAr
                        displayNameEn = res.result.displayNameEn
                        userAccessToken = res.result.accessToken
                        isRenewel = nil
                        isCorporate = res.result.isCorporateUser ?? false
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
                if !getBirthDate {
                    let (result,error) = await JSONPlaceholderService.verifyYakeenMobile.request(type: BeginLoginItem.self,parameters: parameters)
                     self.submitLoading = false
                     switch result {
                    case .success(let res):
                         print(res)
                         self.processName(res)
                         self.isYakeenChecked = res.result.isYakeenChecked ?? false
                         if res.errorCode != 1 {
                             self.hashed = res.result.hashed ?? ""
                             self.submitLoading = false
                             self.showError(res.errorDescription)
                             if res.result.getBirthDate == true {
                                 self.showNationalAndPhone = false
                                 self.showBirthYearMonth = true
                                 userNationalId = res.result.nationalId
//                                 self.nameEn = res.result.fnen ?? ""
//                                 self.nameAr = res.result.fnar ?? ""
                                 self.getBirthDate = true
                             }
                             self.handleCases(res)
                         }
                         if res.result.phoneVerification == true {
                             self.phone = res.result.phone ?? res.result.phoneNumber ?? ""
                             userPhone = self.phone
                             DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                 self.showOTP = true
                             }
//                             self.nameEn = res.result.fnen ?? ""
//                             self.nameAr = res.result.fnar ?? ""
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
                    let (result,error) = await JSONPlaceholderService.endLogin.request(type: BeginLoginItem.self,parameters: parameters)
                    self.submitLoading = false
                    switch result {
                    case .success(let res):
                        print(res)
                        self.processName(res)
                        if res.errorCode != 1 {
                            self.showError(res.errorDescription)
                        }
                        if res.result.phoneVerification == true {
                            self.phone = res.result.phone ?? res.result.phoneNumber ?? ""
                            userPhone = self.phone
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
    }
    func beginLoginNationalId() {

        var trimmedNationalId = ""
        trimmedNationalId = nationalId.trimmed().replacedArabicDigitsWithEnglish
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
        
//        var trimmedBYear = ""
//        var trimmedBMonth = ""
//        
//        if showBirthYearMonthNational {
//            trimmedBYear = birthYear
//            if trimmedBYear == "" {
//                birthYearErrorText = "BirthYearRequired".localized
//            }
//            else {
//                birthYearErrorText = nil
//            }
//            trimmedBMonth = birthMonth
//            if trimmedBMonth == "" {
//                birthMonthErrorText = "BirthMonthRequired".localized
//            }
//            else {
//                birthMonthErrorText = nil
//            }
//        }
//        
//        var trimmedPhone = ""
//        if showPhone {
//            trimmedPhone = phone.replacedArabicDigitsWithEnglish
//            if trimmedPhone == "" {
//                phoneErrorText = "PhoneRequired".localized
//            }
//            else {
//                if trimmedPhone.isValidPhone() {
//                    phoneErrorText = nil
//                }
//                else {
//                    phoneErrorText = "PhoneIncorrect".localized
//                }
//            }
//        }
       
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
        
        if !termsDone {
            termsRed = true
        }
        
        if ninErrorText != nil || passErrorText != nil || (captchaErrorText != nil || captchaExpired) || termsRed {
            return
        }
         
        if noNetwork() {
            showNoNetwork()
            return
        }
        
        let deviceModel = appUUIDValue()
        let deviceType = UIDevice.modelName
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        
        let parameters:[String:Any] = [
            "clientId": trimmedNationalId,
            "password": trimmedPassword,
            "productType": "0",
            "channel": "ios",
            "firebasetoken": FIREBASE_TOKEN ?? "",
            "version": version,
            "deviceModel": deviceModel,
            "deviceType": deviceType,
            "deviceId": "deviceId",
            "CaptchaInput": trimmedCaptcha,
            "CaptchaToken": captchaToken
        ]
     
        userNationalId = trimmedNationalId
        submitLoading = true
        Task {
            if !isYakeenChecked {
                let (result,error) = await JSONPlaceholderService.beginLogin.request(type: BeginLoginItem.self,parameters: parameters)
                 self.submitLoading = false
                 switch result {
                case .success(let res):
                    print(res)
                    self.processName(res)
                    if res.errorCode != 1 {
                        if res.result.phoneNumberConfirmed == false {
                            self.showPhone = true
                            self.isYakeenChecked = true;
                        }
                        if res.result.phoneVerification == true {
                            self.phone = res.result.phone ?? res.result.phoneNumber ?? ""
                            userPhone = self.phone
//                            userNationalId = res.result.nationalId
                            self.showInfo(res.errorDescription)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.showOTP = true
                            }
                        }
                        self.handleCases(res)
                    }
                    else {
                        tokenExpirationDate = res.result.tokenExpirationDate
                        expiryDate = Date()
                        self.submitLoading = true
                        userEmail = self.email
                        userPassword = self.password
                        userNationalId = trimmedNationalId
//                        userBirthYear = trimmedBYear
//                        userBirthMonth = trimmedBMonth
//                        userBirthMonthIndex = self.birthMonthIndex
                        userId = res.result.userId
                        userPhone = res.result.phone ?? res.result.phoneNumber ?? ""
                        displayNameAr = res.result.displayNameAr
                        displayNameEn = res.result.displayNameEn
                        userAccessToken = res.result.accessToken
                        isRenewel = nil
                        isCorporate = res.result.isCorporateUser ?? false
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
                if !getBirthDate {
                    let (result,error) = await JSONPlaceholderService.verifyYakeenMobile.request(type: BeginLoginItem.self,parameters: parameters)
                    self.submitLoading = false
                    switch result {
                    case .success(let res):
                        print(res)
                        self.processName(res)
                        self.isYakeenChecked = res.result.isYakeenChecked ?? false
                        if res.errorCode != 1 {
                            self.hashed = res.result.hashed ?? ""
                            self.showError(res.errorDescription)
                            if res.result.getBirthDate == true {
                                self.showNationalAndPhone = false
                                self.showBirthYearMonthNational = true
                                self.getBirthDate = true
                            }
                            self.handleCases(res)
                        }
                        if res.result.phoneVerification == true {
                            self.phone = res.result.phone ?? res.result.phoneNumber ?? ""
                            userPhone = self.phone
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
                else {
                    let (result,error) = await JSONPlaceholderService.endLogin.request(type: BeginLoginItem.self,parameters: parameters)
                    self.submitLoading = false
                    switch result {
                    case .success(let res):
                        print(res)
                        self.processName(res)
                        if res.errorCode != 1 {
                            self.showError(res.errorDescription)
                        }
                        if res.result.phoneVerification == true {
                            self.phone = res.result.phone ?? res.result.phoneNumber ?? ""
                            userPhone = self.phone
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
    }
    func handleCases(_ res:BeginLoginItem) {
        if res.errorCode != 48 { // In no error case don't reload captcha
           reloadCaptcha()
        }
//        if res.errorCode == 54 { // Wrong captcha code
//           showError(res.errorDescription)
//        }
//        else
//        if res.errorCode == 58 { // No associated account
//           showError(res.errorDescription)
//        }
        if res.errorCode == 60 {
           showError("AccountBlocked".localized)
        }
        else if res.errorCode == 38 { // Invalid data error
           showError("InvalidData".localized)
        }
        else
        if ![20,21,5].contains(res.errorCode) {
            showError(res.errorDescription)
        }
    }
    func processName(_ res:BeginLoginItem) {
        guard let nE = res.result.fnen , let nA = res.result.fnar else { return }
        nameEn = nE
        nameAr = nA
        fullDisplayNameEn = nE
        fullDisplayNameAr = nA
    }
    func reloadCaptcha() {
        captcha = ""
        NotificationCenter.default.post(name: .captchaNotification, object: nil)
    }
    func showTerms() {
        termsRed = false
        showInfo("AgreeToQueryLong".localized)
    }
    func appUUIDValue() -> String {
        let key = "AppUUIDKey"
        let keychain = KeychainSwift()
        if let value = keychain.get(key) {
            return value
        }
        else {
            let deviceId = UIDevice.current.identifierForVendor!.uuidString
            keychain.set(deviceId, forKey: key)
            return deviceId
        }
    }
}

extension LoginVM : OTPManager {
    func verify(_ otp: String) {
        if noNetwork() {
            showNoNetwork()
            return
        }
        let parameters:[String:Any] = [
            "UserName": email.encrypted,
            "PWD": password.encrypted,
            "PhoneNo": phone,
            "nationalId": nationalId,
            "OTP": otp,
            "birthYear": birthYear,
            "birthMonth": birthMonthIndex.toString(),
            "fnen": nameEn,
            "fnar": nameAr,
            "isYakeenChecked": isYakeenChecked,
            "isloginByNationalId":nationalIdSelected,
            "CaptchaInput": captcha,
            "CaptchaToken": captchaToken,
            "Channel":"ios"
        ]
        print(parameters)
        Task {
            showConfirmOTPLoader = true
            let (result,error) = await JSONPlaceholderService.verifyLoginOTP.request(type: BeginLoginItem.self,parameters: parameters)
            self.showConfirmOTPLoader = false
            switch result {
            case .success(let res):
                 print(res)
                if res.errorCode != 1 {
                    if res.errorCode == 60 {
                        self.errorMessage = "AccountBlocked".localized
                        self.showErrorMessage = true
                    }
                    else {
                        if let content = res.errorDescription , !content.isEmpty {
                            self.errorMessage = content
                            self.showErrorMessage = true
                        }
                    }
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
                    userBeginLoginItem = res
                    faceDone = true
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
            "isloginByNationalId":nationalIdSelected
        ]
        Task {
            showResendOTPLoader = true
            let (result,error) = await JSONPlaceholderService.resendOTP.request(type: LoginResendOTPItem.self,parameters: parameters)
             self.showResendOTPLoader = false
             switch result {
            case .success(let res):
                print(res)
                if res.errorCode != 1 {
                    if res.errorCode == 60 {
                        self.errorMessage = "AccountBlocked".localized
                        self.showErrorMessage = true
                    }
                    else {
                        if !res.errorDescription.isEmpty {
                            self.errorMessage = res.errorDescription
                            self.showErrorMessage = true
                        }
                    }
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
