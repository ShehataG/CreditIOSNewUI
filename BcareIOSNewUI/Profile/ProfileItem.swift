//
//  ProfileItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/30/24.
//

import Foundation

// MARK: - Welcome
struct ProfileItem: Codable {
    let errorCode: Int
    let result: ProfileResult
    let errorDescription: String

    enum CodingKeys: String, CodingKey {
        case errorCode = "ErrorCode"
        case result = "Result"
        case errorDescription = "ErrorDescription"
    }
    
    // MARK: - Result
    struct ProfileResult: Codable {
        let userObj: ProfileUserObj
        let canUpdatePhoneNumber: Bool
        let promotionProgramName: String

        enum CodingKeys: String, CodingKey {
            case userObj = "UserObj"
            case canUpdatePhoneNumber = "CanUpdatePhoneNumber"
            case promotionProgramName = "PromotionProgramName"
        }
    }

    // MARK: - UserObj
    struct ProfileUserObj: Codable {
        let email: String
        let policiesCount: Int
        let fullNameAr, fullName, phoneNumber ,nationalId: String

        enum CodingKeys: String, CodingKey {
            case email = "Email"
            case policiesCount = "PoliciesCount"
            case fullNameAr = "FullNameAr"
            case fullName = "FullName"
            case phoneNumber = "PhoneNumber"
            case nationalId = "NationalId"
        }
    }
}

// MARK: - Welcome
struct ProfileOtpItem: Codable {
    let errorDescription: String?
    let errorCode: Int
    let result: Bool

    enum CodingKeys: String, CodingKey {
        case errorDescription = "ErrorDescription"
        case errorCode = "ErrorCode"
        case result = "Result"
    }
}
