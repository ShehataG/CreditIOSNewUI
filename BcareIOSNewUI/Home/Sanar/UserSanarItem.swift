//
//  UserSanarItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//


import Foundation

// MARK: - Welcome
struct UserSanarItem: Codable {
    let dateOfBirth, nationality,nationalityAr: String
    let maritalStatus: String
    let gender: String
    func getCurrentNationality() -> String {
        isAr ? nationalityAr : nationality
    }
}
