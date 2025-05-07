//
//  TempUserItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation

struct TempUserItem:Equatable,Hashable {
    let email,password,nin,phone:String
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: TempUserItem, rhs: TempUserItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
