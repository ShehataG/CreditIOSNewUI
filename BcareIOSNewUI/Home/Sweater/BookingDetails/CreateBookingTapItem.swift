//
//  CreateBookingItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//
 
import Foundation
 
// MARK: - Welcome
struct CreateBookingTapItem: Codable {
    let success: Bool
    let code: Int
    let message: String
    let bookingID: Int
    let date, timeSlot: String?
    let transactionID: String
    let paymentLink: String

    enum CodingKeys: String, CodingKey {
        case success, code, message
        case bookingID = "bookingId"
        case date, timeSlot
        case transactionID = "transactionId"
        case paymentLink
    }
}
