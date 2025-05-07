//
//  SathaVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

@MainActor
final class SathaVM : MainObservable {
    @Published var submitServicesLoading = false
    @Published var selectedIndex = 0
    @Published var mapId = 0
    let data = [
        SathaItem(title: "InsideCity", subTitle: "PriceChanged", price: 80.00),
        SathaItem(title: "OutsideCity", subTitle: "PriceFixed", price: 200.00)
    ]
    override init() {
        super.init()
    }
}
