//
//  OrderSentItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
// MARK: - Datum
struct OrderSentItem:Hashable,Equatable {
    let type: EzhelhaType
    let items: [OrderDatum]
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: OrderSentItem, rhs: OrderSentItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
