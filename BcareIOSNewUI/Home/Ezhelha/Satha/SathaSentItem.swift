//
//  SathaSentItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import CoreLocation

struct SathaSentItem:Equatable,Hashable {
    let sericeId:Int
    let coordinate:CLLocationCoordinate2D
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: SathaSentItem, rhs: SathaSentItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
 
