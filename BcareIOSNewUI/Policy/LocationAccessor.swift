//
//  LocationAccessor.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 6/2/24.
//

import Foundation
import CoreLocation
import MapKit
import Combine
import SwiftUI

@MainActor final class LocationAccessor: ObservableObject {
    var coordinate:CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    init() {
        LocationSingleton.shared.delegate = self
        LocationSingleton.shared.startUpdatingLocation()
    }
    func center() {
        if let coor = coordinate {
            region.center = coor
        }
    }
}

extension LocationAccessor: @preconcurrency LocationServiceDelegate {
   func tracingLocation(currentLocation: CLLocation) {
       self.coordinate = currentLocation.coordinate
       center()
   }
   func tracingLocationDidFailWithError(error: Error) {
       print(error)
   }
}
