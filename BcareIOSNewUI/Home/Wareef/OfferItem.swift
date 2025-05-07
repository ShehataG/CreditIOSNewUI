//
//  OfferItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation

// MARK: - Welcome
struct OfferItem: Codable {
   let errorDescription: String?
   let errorCode: Int
   let result: OfferSubItem
   enum CodingKeys: String, CodingKey {
       case errorDescription = "ErrorDescription"
       case errorCode = "ErrorCode"
       case result = "Result"
   }
}

// MARK: - Datum
struct OfferSubItem: Codable {
    let hasActivePolicy: Bool
    let expiryDate, hashed: String?
    enum CodingKeys: String, CodingKey {
       case hasActivePolicy = "HasActivePolicy"
       case expiryDate = "ExpiryDate"
       case hashed
    }
}
