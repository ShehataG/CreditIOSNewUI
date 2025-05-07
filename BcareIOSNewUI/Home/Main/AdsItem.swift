//
//  AdsItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation

struct AdsItem:Equatable,Hashable {
    let name:String
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: AdsItem, rhs: AdsItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
