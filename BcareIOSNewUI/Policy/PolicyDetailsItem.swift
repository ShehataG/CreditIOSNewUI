//
//  PolicyDetailsItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 6/2/24.
//

import Foundation
import SwiftUI
 
struct PolicyDetailsSentItem: Equatable,Hashable {
    let item:PoliciesResult 
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: PolicyDetailsSentItem, rhs: PolicyDetailsSentItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

struct PolicyMainItem: Codable {
    let errorDescription: String?
    let errorCode: Int
    let result: PolicyResultItem
}

struct PolicyResultItem: Codable {
    let policyNo: String
    let nationalID, membershipNumber: String?
    let categoryClass, companyName, policyEffectiveDate, policyExpiryDate: String
    let insuranceCompanyNameEn, insuranceCompanyNameAr, insuranceCompanyKey:String
    let deductiblePercentage: String?
    let employeeIDNumber: String?

    enum CodingKeys: String, CodingKey {
        case policyNo
        case nationalID = "nationalId"
        case membershipNumber, categoryClass, companyName, policyEffectiveDate, policyExpiryDate, insuranceCompanyNameEn, insuranceCompanyNameAr, insuranceCompanyKey, deductiblePercentage
        case employeeIDNumber = "employeeIdNumber"
    }
}
