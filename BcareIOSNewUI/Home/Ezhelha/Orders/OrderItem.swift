//
//  CheckoutList.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
 
// MARK: - Welcome
struct OrderItem: Codable {
    let status: Bool
    let message: String?
    let data: [OrderDatum]
}

// MARK: - Datum
struct OrderDatum: Codable,Hashable,Equatable {
    let id: Int
    let code: String
    let paymentStatus: String
    let status: String
    let subtotal: String
    let vat: Double
    let totalAfterVat, paymentAmount: String
    let clientLocationText: String?
    let subService: OrderService
    let mainService: OrderService
    let user: OrderUser
    let createdDate: String

    enum CodingKeys: String, CodingKey {
        case id,code
        case paymentStatus = "payment_status"
        case status, subtotal, vat
        case totalAfterVat = "total_after_vat"
        case paymentAmount = "payment_amount"
        case clientLocationText = "client_location_text"
        case subService = "sub_service"
        case mainService = "main_service"
        case user
        case createdDate = "created_date"
    }
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: OrderDatum, rhs: OrderDatum) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
  
// MARK: - User
struct OrderUser: Codable {
    let id: String
    let name: String?
    let email: String?
    let phone: String
}
 
// MARK: - Service
struct OrderService: Codable {
    let id: Int
    let title, description: String
}
