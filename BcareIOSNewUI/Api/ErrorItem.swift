//
//  ErrorItem.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 27/05/2024.
//

import Foundation
 
struct ErrorItem: Decodable {
    var description: String
    var code: Int
    enum CodingKeys: String, CodingKey {
        case description = "ErrorDescription"
        case code = "ErrorCode"
    }
}

struct AuthenticatedItem: Codable {
    var errors: String?
    var data,totalCount: Int
}
