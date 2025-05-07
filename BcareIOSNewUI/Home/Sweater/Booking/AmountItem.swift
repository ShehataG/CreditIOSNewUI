//
//  AmountItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//
 
import Foundation
 
struct AmountItem: Codable {
    let success: Bool
    let amount,vat,amountWithVat: Double
}
