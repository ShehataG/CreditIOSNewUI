//
//  TitleSubItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 6/2/24.
//

import Foundation
import SwiftUI

struct DownloadPolicyItem: Codable {
    let errorDescription: String
    let errorCode: Int
    let result: String

    enum CodingKeys: String, CodingKey {
        case errorDescription = "ErrorDescription"
        case errorCode = "ErrorCode"
        case result = "Result"
    }
}
