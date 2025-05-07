//
//  CaptchaItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

// MARK: - Welcome
struct CaptchaItem: Codable {
    let data: CaptchaDataItem
    let errors: String?
    let totalCount: Int
}
// MARK: - DataClass
struct CaptchaDataItem: Codable {
    let image, token: String
    let expiredInSeconds: Int
}
