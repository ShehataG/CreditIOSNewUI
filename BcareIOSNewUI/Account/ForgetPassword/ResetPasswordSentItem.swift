//
//  TempUserItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation

struct ResetPasswordSentItem:Equatable,Hashable {
    let uid,hashed:String
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: ResetPasswordSentItem, rhs: ResetPasswordSentItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
 
