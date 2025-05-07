//
//  BookingsClientItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//


import Foundation

struct BookingsClientItem: Codable,Hashable,Equatable {
    let bookingId: Int
    let status: String
    let fullMobile: String?
    let mobile: String
    let b2BReferenceID: String?
    let brand: String
    let countryCode, platNumber: String?
    let color, latitude, longitude: String
    let fullName, endTime: String?
    let date, model: String
    let email: String?
    let startTime: String

    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_Id"
        case status, fullMobile, mobile, b2BReferenceID, brand, countryCode, platNumber, color, latitude, longitude, fullName, endTime, date, model, email
        case startTime  = "start_Time"
    }
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: BookingsClientItem, rhs: BookingsClientItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
