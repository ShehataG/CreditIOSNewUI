//
//  ProfileVM.swift
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
final class ProfileVM : MainObservable {
    @Published var image = ""
    @Published var name = ""
    @Published var email = ""
    @Published var nationalId = ""
    @Published var submitLoading = false
    @Published var makeLogout = false
    @Published var submitLoadingLogout = false
    @Published var canUpdatePhoneNumber = false
    @Published var promotionProgramName = ""
    @Published var policiesCount = 0
    @Published var updateType = 1
    @Published var emailEdited = ""
    @Published var phoneEdited = ""
    
    @Published var phone = ""
    @Published var showConfirmOTPLoader = false
    @Published var showResendOTPLoader = false
    @Published var counter = 90
    @Published var shouldClose = false
    @Published var errorMessage:String?
    @Published var infoMessage:String?
    @Published var showErrorMessage = false
    @Published var showInfoMessage = false
    @Published var showOTP = false

    @Published var isEditingPhone = false
    @Published var isEditingEmail = false
    @Published var disablePhone = false
    @Published var disableEmail = false
    
    @Published var submitLoadingRefresh = false
    @Published var canUpdatReflect = canUpdateProfile

    @Published var showLogoutAlert = false
    @Published var appVersion = ""

    @Published var current = 0
    @Published var currentPolicy = ""
    
    override init() {
        super.init()
        Task { @MainActor in
            counterBase = 90 
            await initDev()
        }
    }
    func initDev() async { 
        image = "profile"
        appVersion = "Version".localized  + " : " + (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)
        if canUpdatReflect {
            getInfo()
        }
        else {
            let savedPhone = userPhone ?? ""
            phone = savedPhone
            phoneEdited = savedPhone
            emailEdited = userEmail ?? ""
            processName()
        }
        updateCount()
    }
    func updateCount() {
        policiesCount = policiesG.count
        if policiesCount > 0 {
            currentPolicy = policiesG.first!.model() ?? ""
        }
    }
    func getInfo() {
        if noNetwork() {
            showNoNetwork()
            return
        }
        let parameters:[String:Any] = [
            "userId": userId ?? "",
            "profileTypeId": 0,
            "language": langText,
            "channel": "ios",
        ]
        Task {
            submitLoading = true
            let (result,error) = await JSONPlaceholderService.profileByType.request(type: ProfileItem.self,parameters:parameters)
            self.submitLoading = false
            switch result {
            case .success(let res):
                if res.errorCode == 1 {
                    let info = res.result.userObj
                    self.canUpdatePhoneNumber = res.result.canUpdatePhoneNumber
                    self.promotionProgramName = res.result.promotionProgramName
                    fullDisplayNameAr = info.fullNameAr
                    fullDisplayNameEn = info.fullName
                    self.processName()
                    userEmail = info.email
                    self.email = info.email
                    self.emailEdited = info.email
                    userPhone = info.phoneNumber
                    self.phone = info.phoneNumber
                    self.phoneEdited = info.phoneNumber
                    userNationalId = info.nationalId
                    self.nationalId = info.nationalId
                    self.canUpdatReflect = false
                    canUpdateProfile = false
                }
                break
            case .failure(_):
                if let error = error {
                    self.showError(error.description)
                }
                break
            }
        }
    }
    func processName() {
        self.name = UserManager.usernameFirstLast() ?? ""
    }
    func logout() {
        if noNetwork() {
            showNoNetwork()
            return
        }
        Task {
            submitLoadingLogout = true
            let (result,error) = await JSONPlaceholderService.logout.request(type: Bool.self)
            submitLoadingLogout = false
            switch result {
            case .success(let res):
                if res {
                    UserManager.logout()
                    self.makeLogout = true
                }
                break
            case .failure(_):
                if let error = error {
                    self.showError(error.description)
                }
                break
            }
        }
    }
    func sendOtpPhone(type:Field) {
        if noNetwork() {
            showNoNetwork()
            return
        }
        if type == .email {
            updateType = 1
            disableEmail = true
        }
        else {
            updateType = 2
            disablePhone = true
        }
        
        if noNetwork() {
            showNoNetwork()
            return
        }
        
        updateType = type == .email ? 1 : 2 // 1 for email and 2 for phone
        let parameters:[String:Any] = [
            "email": updateType == 1 ? emailEdited : email,
            "phoneNumber": updateType == 2 ? phoneEdited : phone,
            "lang": langText,
            "updateInfoTypeId": updateType
        ]
        Task {
            let (result,error) = await JSONPlaceholderService.sendOTP.request(type: ProfileOtpItem.self,parameters: parameters)
            self.disableEmail = false
            self.disablePhone = false
            switch result {
            case .success(let res):
                if res.errorCode != 1 {
                    self.showError(res.errorDescription)
                    if res.errorCode == 11 {
                        self.resetData()
                    }
                }
                else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        if res.result {
                            self.showOTP = true
                        }
                    }
                }
                break
            case .failure(_):
                if let error = error {
                    self.showError(error.description)
                }
                break
            }
        }
    }
    func resetData() {
        if updateType == 1 {
            isEditingEmail = false
            emailEdited = userEmail ?? ""
        }
        else {
            isEditingPhone = false
            phoneEdited = userPhone ?? ""
        }
    }
    func assignPhone()  {
        if updateType == 2 {
            phone = phoneEdited
            userPhone = phoneEdited
        }
    }
}

extension ProfileVM : OTPManager {
    
    func verify(_ otp:String) {
        if noNetwork() {
            showNoNetwork()
            return
        }
        let parameters:[String:Any] = [
            "email": updateType == 1 ? emailEdited : email,
            "phoneNumber": updateType == 2 ? phoneEdited : phone,
            "lang": langText,
            "updateInfoTypeId": updateType,
            "OTP": otp
        ]
        Task {
            showConfirmOTPLoader = true
            let (result,error) = await JSONPlaceholderService.updateUserProfileData.request(type: ProfileOtpItem.self,parameters: parameters)
            self.showConfirmOTPLoader = false
            switch result {
            case .success(let res):
                if res.errorCode != 1 {
                    self.errorMessage = res.errorDescription
                    self.showErrorMessage = true
                }
                else {
                    if res.result {
                        self.infoMessage = res.errorDescription
                        self.showInfoMessage = true
                        self.assignPhone()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.shouldClose = true
                        }
                    }
                }
                break
            case .failure(_):
                if let error = error {
                    self.errorMessage = error.description
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
            "nationalId": nationalId
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
