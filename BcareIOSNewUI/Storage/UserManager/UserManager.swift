//
//  UserManager.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import WebKit

@MainActor
class UserManager {
    static func isLoggedIn() -> Bool {
        return userId != nil && faceDone
    }
    static func username() -> String? {
        return isAr ? displayNameAr : displayNameEn
    }
    static func usernameFull() -> String? {
        let value = isAr ? fullDisplayNameAr : fullDisplayNameEn
        return value ?? ""
    }
    static func usernameFirst() -> String? {
        let value = isAr ? fullDisplayNameAr : fullDisplayNameEn
        return value?.firstName() ?? ""
    }
    static func usernameLast() -> String? {
        let value = isAr ? fullDisplayNameAr : fullDisplayNameEn
        return value?.lastName() ?? ""
    }
    static func usernameFirstLast() -> String? {
        let value = isAr ? fullDisplayNameAr : fullDisplayNameEn
        return value?.firstLastName() ?? ""
    }
    static func sessionExpired() {
        userId = nil
        expiryDate = nil
        userAccessToken = nil
        tokenExpirationDate = nil
        canUpdateProfile = true
        policiesG.removeAll()
        if let service = servicesStatusItem , service.sanar {
            NotificationCenter.default.post(name: .sanarDisconnectNotification, object: nil)
        }
        NotificationCenter.default.post(name: .logoutAuthNotification, object: nil)
    }
    static func logout() {
        userId = nil
        expiryDate = nil
        userAccessToken = nil
        tokenExpirationDate = nil
        userPhone = nil
        displayNameAr = nil
        displayNameEn = nil
        isRenewel = nil
        isCorporate = nil
        isCorporateAdmin = nil
        userWareefExpiryDate = nil
        fullDisplayNameAr = nil
        fullDisplayNameEn = nil
        userBeginLoginItem = nil
        userSanarItem = nil
        canUpdateProfile = true
        policiesG.removeAll()
        if let service = servicesStatusItem , service.sanar {
            NotificationCenter.default.post(name: .sanarDisconnectNotification, object: nil)
        }
//        userEmail = nil
//        userPassword = nil
//        userNationalId = nil
//        userBirthYear = nil
//        userBirthMonth = nil
        DispatchQueue.main.async {
            WKWebView.clean()
        }
    }
}
