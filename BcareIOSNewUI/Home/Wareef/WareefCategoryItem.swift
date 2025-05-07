//
//  WareefCategoryItem.swift
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
struct WareefCategoryItem: Codable {
    let data: [WareefCategoryDatumItem]
    let totalCount: Int
}
// MARK: - Datum
struct WareefCategoryDatumItem : Codable {
    let id: Int
    let nameAr, nameEn, imageBytes: String
    let wareefCategoryID: Int
    let itemURl: String
    let itemDiscounts: [ItemDiscount]
    var name:String {
        isAr ? nameAr : nameEn
    }
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case nameAr = "NameAr"
        case nameEn = "NameEn"
        case imageBytes = "ImageBytes"
        case wareefCategoryID = "WareefCategoryId"
        case itemURl = "ItemURl"
        case itemDiscounts = "ItemDiscounts"
    }
}
// MARK: - ItemDiscount
struct ItemDiscount: Codable {
    let id: Int
    let descountValue: String
    let wareefID: Int
    let wDescountCode: String?
    let waeefDicscountItemsDetails: [WaeefDicscountItemsDetail]
    var isValidCode:Bool {
         wDescountCode != nil && wDescountCode != ""
    }
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case descountValue = "DescountValue"
        case wareefID = "WareefId"
        case wDescountCode = "WDescountCode"
        case waeefDicscountItemsDetails = "WaeefDicscountItemsDetails"
    }
}
// MARK: - WaeefDicscountItemsDetail
struct WaeefDicscountItemsDetail: Codable {
    let benefitDescriptionAr, benefitDescriptionEn: String?
    var benefitDescription:String? {
        isAr ? benefitDescriptionAr : benefitDescriptionEn
    }
    let descountID: Int

    enum CodingKeys: String, CodingKey {
        case benefitDescriptionAr = "BenefitDescriptionAr"
        case benefitDescriptionEn = "BenefitDescriptionEn"
        case descountID = "DescountId"
    }
}
