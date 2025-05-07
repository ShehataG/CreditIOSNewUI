//
//  TempUserItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation 

// MARK: - Welcome
struct ResetPasswordItem: Codable {
    let errorDescription: String?
    let errorCode: Int
    let result: ResetPasswordResultItem

    enum CodingKeys: String, CodingKey {
        case errorDescription = "ErrorDescription"
        case errorCode = "ErrorCode"
        case result = "Result"
    }
    
    // MARK: - Result
    struct ResetPasswordResultItem: Codable {
        let nationalIDExist: Bool
        let uid: String?
        let email, phone, hashed: String?

        enum CodingKeys: String, CodingKey {
            case nationalIDExist = "nationalIdExist"
            case uid, email, phone, hashed
        }
    }

}
