//
//  PoliciesItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 11/13/24.
//

import Foundation

struct PoliciesItem: Codable {
    let errorDescription: String?
    let errorCode: Int
    let result: [PoliciesResult]
}

// MARK: - Result
struct PoliciesResult: Codable,Equatable,Hashable {
    let policyNo: String
    let nameEn, nameAr: String?
    let policyExpiryDate, nationalID, insuranceCompanyNameEn, insuranceCompanyNameAr: String
    let insuranceCompanyKey: String
    let productTypeAr, productTypeEn: String
    let productID: Int
    let memberShipId:String
    let policyFileId: String?
    let gender:String
    let categoryClass:String?
    let deductiblePercentage:String?
    let employeeCompanyName:String?
    let vehicleModelNameAr,vehicleModelNameEn,vehiclePlateAr,vehiclePlateEn:String?
    let externalId:String?
    let referenceId:String?
    let policyExpiryDateInDays:Int
    let najmStatusAr:String?
    let najmStatusEn:String?
    
    enum CodingKeys: String, CodingKey {
        case nameEn, nameAr, insuranceCompanyNameEn, productTypeEn
        case nationalID = "nationalId"
        case policyExpiryDate, insuranceCompanyNameAr, insuranceCompanyKey, productTypeAr
        case productID = "productId"
        case policyNo,memberShipId,policyFileId,gender,categoryClass,deductiblePercentage,employeeCompanyName
        case vehicleModelNameAr,vehicleModelNameEn,vehiclePlateAr,vehiclePlateEn,externalId,referenceId,policyExpiryDateInDays,najmStatusAr,
             najmStatusEn
    }
    init(policyExpiryDate: String?, nationalID: String?, productID: Int) {
        self.policyNo = ""
        self.nameEn = ""
        self.nameAr = ""
        self.policyExpiryDate = policyExpiryDate ?? ""
        self.nationalID = nationalID ?? ""
        self.insuranceCompanyNameEn = ""
        self.insuranceCompanyNameAr = ""
        self.insuranceCompanyKey = ""
        self.productTypeAr = ""
        self.productTypeEn = ""
        self.productID = productID
        self.memberShipId = ""
        self.policyFileId = ""
        self.gender = ""
        self.categoryClass = ""
        self.deductiblePercentage = ""
        self.employeeCompanyName = "" 
        self.vehicleModelNameAr = ""
        self.vehicleModelNameEn = ""
        self.vehiclePlateAr = ""
        self.vehiclePlateEn = ""
        self.externalId = ""
        self.referenceId = ""
        self.policyExpiryDateInDays = 0
        self.najmStatusAr = ""
        self.najmStatusEn = ""
    }
    func name()->String? {
        isAr ? nameAr : nameEn
    }
    func productType()->String {
        isAr ? productTypeAr : productTypeEn
    }
    func model()->String? {
        isAr ? vehicleModelNameAr : vehicleModelNameEn
    }
    func plate()->String? {
        isAr ? vehiclePlateAr : vehiclePlateEn
    }
    func najmStatus()->String? {
        return isAr ? najmStatusAr : najmStatusEn
    }
    func closeToExpiration()->Bool {
        let period = productID == 1 ? 44 : 30
        return policyExpiryDateInDays <= period
    }
    func diffDays()->Int {
        return policyExpiryDateInDays > 0 ? policyExpiryDateInDays : 0
    }
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
            guard let label = label else { return nil }
            return (label, value)
        }).compactMap { $0 })
        return dict
    }
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: PoliciesResult, rhs: PoliciesResult) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
