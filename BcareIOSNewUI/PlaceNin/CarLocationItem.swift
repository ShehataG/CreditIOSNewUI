//
//  CarLocationItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import CoreLocation

struct CarLocationItem:Equatable,Hashable {
    let car:VehicleByNinItem
    var mainItems:[AvailableMainItem]
    let coordinate:CLLocationCoordinate2D
    let location:String
    let serviceType:CarServiceType
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: CarLocationItem, rhs: CarLocationItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
