//
//  BeginLoginItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation

// MARK: - Welcome
struct BeginLoginItem: Codable {
    let errorCode: Int
    let errorDescription: String?
    let result: BeginLoginResultItem
    enum CodingKeys: String, CodingKey {
        case errorCode = "ErrorCode"
        case errorDescription = "ErrorDescription"
        case result = "Result"
    }
    // MARK: - Result
    struct BeginLoginResultItem: Codable {
        let displayNameAr,displayNameEn:String?
        let phoneNumberConfirmed: Bool?
        let getBirthDate, rememberMe: Bool
        let tokenExpirationDate: String?
        let phoneVerification, isCorporateUser,isCorporateAdmin: Bool?
        let fnar,fnen: String?
        let isYakeenChecked: Bool?
        let accessToken:String?
        let accessTokenGwt:String?
        let userId:String?
        let nationalId:String?
        let tokenExpiryDate:Int?
        let hashed:String?
        let phone:String?
        let phoneNumber:String?
        enum CodingKeys: String, CodingKey {
            case displayNameAr, displayNameEn, getBirthDate
            case rememberMe = "RememberMe"
            case fnar, tokenExpirationDate
            case phoneNumberConfirmed = "PhoneNumberConfirmed"
            case phoneVerification
            case isCorporateUser = "IsCorporateUser"
            case isCorporateAdmin = "IsCorporateAdmin"
            case fnen, isYakeenChecked
            case accessToken = "AccessToken"
            case accessTokenGwt = "AccessTokenGwt"
            case userId = "UserId"
            case nationalId = "nationalID"
            case tokenExpiryDate = "TokenExpiryDate"
            case hashed
            case phone = "PhoneNo"
            case phoneNumber
        }
    }
}
