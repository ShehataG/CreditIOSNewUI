//
//  WareefItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import LocalAuthentication
import KeychainSwift

// MARK: - Welcome
struct WareefItem: Codable {
    let data: [WareefDatumItem]
    let totalCount: Int
}

// MARK: - Datum
struct WareefDatumItem: Codable {
    let id: Int
    let nameAr, nameEn, icon: String
    let isDeleted: Bool
    let createdby, createdDateTime: String
    let modifiedDate, modifiedBy: String?
    var name:String {
        isAr ? nameAr : nameEn
    }
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case nameAr = "NameAr"
        case nameEn = "NameEn"
        case icon = "Icon"
        case isDeleted = "IsDeleted"
        case createdby = "Createdby"
        case createdDateTime = "CreatedDateTime"
        case modifiedDate = "ModifiedDate"
        case modifiedBy = "ModifiedBy"
    }
}
