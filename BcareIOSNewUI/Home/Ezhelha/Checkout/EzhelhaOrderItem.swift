//
//  CheckoutList.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation

// MARK: - Welcome
struct EzhelhaOrderItem: Codable {
    let status: Bool
    let message: String?
    let data: EzhelhaData
}

// MARK: - DataClass
struct EzhelhaData: Codable {
    let order: EzhelhaOrder
}

// MARK: - Order
struct EzhelhaOrder: Codable {
    let id: Int
    let paymentStatus: String
    let paymentMethod, paymentSourceName: String?
    let status, type: String
    let date, time: String?
    let subtotal: String
    let vat: Int
    let totalAfterVat, paymentAmount: String
    let clientLocation: ClientLocation
    let clientLocationText: String
    let mainService: MainService
    let subService: SubService
    let userAddress: UserAddress
    let user: User
    let createdDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case paymentStatus = "payment_status"
        case paymentMethod = "payment_method"
        case paymentSourceName = "payment_source_name"
        case status, type, date, time, subtotal, vat
        case totalAfterVat = "total_after_vat"
        case paymentAmount = "payment_amount"
        case clientLocation = "client_location"
        case clientLocationText = "client_location_text"
        case mainService = "main_service"
        case subService = "sub_service"
        case userAddress = "user_address"
        case user
        case createdDate = "created_date"
    }
}

// MARK: - ClientLocation
struct ClientLocation: Codable {
    let coordinates: [Double]
}

// MARK: - MainService
struct MainService: Codable {
    let id: Int
    let title, description, starterPrice, image: String

    enum CodingKeys: String, CodingKey {
        case id, title, description
        case starterPrice = "starter_price"
        case image
    }
}

// MARK: - SubService
struct SubService: Codable {
    let id: Int
    let internalRef, title, description, price: String
    let oldPrice: Int
    let orderForOthers, schedulable, increasable: String

    enum CodingKeys: String, CodingKey {
        case id
        case internalRef = "internal_ref"
        case title, description, price
        case oldPrice = "old_price"
        case orderForOthers = "order_for_others"
        case schedulable, increasable
    }
}

// MARK: - User
struct User: Codable {
    let id, name: String
    let email: String?
    let isEmailVerified: Bool
    let phone: String
    let isPhoneVerified: Bool
    let dialcode, countryName, countryCode: String

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case isEmailVerified = "is_email_verified"
        case phone
        case isPhoneVerified = "is_phone_verified"
        case dialcode
        case countryName = "country_name"
        case countryCode = "country_code"
    }
}

// MARK: - UserAddress
struct UserAddress: Codable {
    let address: String
    let latitude, longitude: Double
}
