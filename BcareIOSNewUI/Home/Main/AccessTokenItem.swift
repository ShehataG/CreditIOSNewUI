//
//  AccessTokenItem.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 28/05/2024.
//

import Foundation

// MARK: - Welcome
struct AccessTokenItem: Codable {
    let errorCode: Int
    let result: AccessTokenItemResult
    enum CodingKeys: String, CodingKey {
        case errorCode = "ErrorCode"
        case result = "Result"
    }
    // MARK: - Result
    struct AccessTokenItemResult: Codable {
        let tokenExpirationDate, accessToken: String
        enum CodingKeys: String, CodingKey {
            case tokenExpirationDate
            case accessToken = "access_token"
        }
    }
}
