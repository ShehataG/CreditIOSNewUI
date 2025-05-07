//
//  BookingDetailsSentItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//
 
import Foundation

struct BookingDetailsSentItem:Equatable,Hashable {
    let place:CarLocationItem
    let time:String
    let date:String
    let amount:AmountItem
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: BookingDetailsSentItem, rhs: BookingDetailsSentItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
