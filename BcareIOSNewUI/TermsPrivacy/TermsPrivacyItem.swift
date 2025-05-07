//
//  TermsPrivacyItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/27/24.
//

import Foundation
import SwiftUI
import WebKit

struct TermsPrivacyItem:Equatable,Hashable {
    let url:String
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: TermsPrivacyItem, rhs: TermsPrivacyItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

