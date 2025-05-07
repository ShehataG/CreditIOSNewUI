//
//  PaymentStatusItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation

// MARK: - Welcome
struct PaymentStatusItem: Codable {
    let message: String
    let paymentStatusOutputModel: PaymentStatusOutputModel?
    let bookingDone, paymentAndBookingDone, paymentDone: Bool
}

// MARK: - PaymentStatusOutputModel
struct PaymentStatusOutputModel: Codable {
    let amount, currency: String?
    let errorCode: String?
    let success: Bool?
    let resultDescription: String?
    let responseData: String?
}
