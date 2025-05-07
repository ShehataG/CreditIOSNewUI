//
//  MojazItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation

// MARK: - Welcome
struct MojazItem: Codable {
    let result: MojazResult?
    let errorDetails: MojazErrorDetails
}

// MARK: - ErrorDetails
struct MojazErrorDetails: Codable {
    let errorCode: Int
    let timestamp, referenceID: String
    let errorTitle: String?
    let isSuccess: Bool
    let errorDescription: String?

    enum CodingKeys: String, CodingKey {
        case errorCode, timestamp
        case referenceID = "referenceId"
        case errorTitle, isSuccess, errorDescription
    }
}

// MARK: - Result
struct MojazResult: Codable,Equatable,Hashable {
    let amount: Double
    let phone: String
    let createdDate: String?
    let vehicle: MojazVehicleDetails
    let referenceID: String

    enum CodingKeys: String, CodingKey {
        case amount, phone,createdDate, vehicle
        case referenceID = "referenceId"
    }
    
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: MojazResult, rhs: MojazResult) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

// MARK: - Vehicle
struct MojazVehicleDetails: Codable,Equatable,Hashable {
    let makeAr,makeEn, makeCode, plateTextAr, modelAr,modelEn: String
    let modelCode, chassisNumber: String
    let carPlate: CarPlate
    let plateNumber: Int
    let sequenceNumber: String
    let modelYear: Int
    
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: MojazVehicleDetails, rhs: MojazVehicleDetails) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func make()->String {
        return isAr ? makeAr : makeEn
    }
    func model()->String {
        return isAr ? modelAr : modelEn
    }
}

// MARK: - CarPlate
struct CarPlate: Codable {
    let carPlateTextEn, plateText3, carPlateNumberEn, plateText2: String
    let carPlateNumberAr, plateText1, carPlateTextAr: String

    enum CodingKeys: String, CodingKey {
        case carPlateTextEn = "CarPlateTextEn"
        case plateText3 = "PlateText3"
        case carPlateNumberEn = "CarPlateNumberEn"
        case plateText2 = "PlateText2"
        case carPlateNumberAr = "CarPlateNumberAr"
        case plateText1 = "PlateText1"
        case carPlateTextAr = "CarPlateTextAr"
    }
}
