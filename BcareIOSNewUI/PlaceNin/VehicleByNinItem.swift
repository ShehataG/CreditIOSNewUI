//
//  VehicleByNinItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 6/2/24.
//

import Foundation

struct VehicleByNinItem: Codable,Equatable {
    let carPlateNumberEn, carPlateNumberAr, makerEn:String
    let sequenceNumber: String?
    let modelEn: String
    let modelYear: Int
    let carPlateTextEn, carPlateTextAr, makerAr, modelAr: String
    
    func formatted() -> String  {
       return isAr ? modelAr + " " + modelYear.toString() + " " + makerAr : modelEn + " " + modelYear.toString() + " " + makerEn
    }
    var maker: String {
        return isAr ?  makerAr : makerEn
    }
    var plate: String {
        return isAr ?  carPlateTextAr + " " + carPlateNumberAr  : carPlateTextEn + " " + carPlateNumberEn
    }
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: VehicleByNinItem, rhs: VehicleByNinItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

//// MARK: - Welcome
//struct VehicleByNinItem: Codable {
//    let data: [VehicleByNinItemResult]
//    let totalCount: Int
//}
//
//// MARK: - Datum
//struct VehicleByNinItemResult: Codable,Equatable,Hashable {
//    let sequenceNumber: String
//    let customCardNumber: String?
//    let makerAr, makerEn, modelEn, modelAr: String
//    let modelYear: Int
//
//    enum CodingKeys: String, CodingKey {
//        case sequenceNumber = "SequenceNumber"
//        case customCardNumber = "CustomCardNumber"
//        case makerAr = "MakerAr"
//        case makerEn = "MakerEn"
//        case modelEn = "ModelEn"
//        case modelAr = "ModelAr"
//        case modelYear = "ModelYear"
//    }
//    func formatted() -> String  {
//       return isAr ? modelAr + " " + modelYear.toString() + " " + makerAr + " " + sequenceNumber 
//                  : modelEn + " " + modelYear.toString() + " " + makerEn + " " + sequenceNumber
//    }
//    var identifier: String {
//        return UUID().uuidString
//    }
//    public func hash(into hasher: inout Hasher) {
//        return hasher.combine(identifier)
//    }
//    public static func == (lhs: VehicleByNinItemResult, rhs: VehicleByNinItemResult) -> Bool {
//        return lhs.identifier == rhs.identifier
//    }
//}
