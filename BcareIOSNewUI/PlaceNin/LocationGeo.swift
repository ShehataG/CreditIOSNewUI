//
//  LocationGeo.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 6/2/24.
//

import Foundation
import CoreLocation
import MapKit
import Combine
import SwiftUI

@MainActor final class LocationGeo: MainObservable,Sendable {
    @Published var userAddress = ""
    @Published var coordinate = CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868)
    @Published var mapId = 0
    @Published var locationError = false
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        Task {
            await checkLocation()
        }
        LocationSingleton.shared.delegate = self
        LocationSingleton.shared.startUpdatingLocation()
    }
    
    func getPhysicalAddress(coordinate:CLLocationCoordinate2D) {
        userAddress = ""
        let lang = isAr ? "ar_SA" : "en_US"
        let latlng = "\(coordinate.latitude),\(coordinate.longitude)"
        let parameters:[String : Any] =
        [
            "latlng":latlng,
            "key":google_key_ios_geocode,
            "language": lang
        ]
        Task {
            let (result,error) = await JSONPlaceholderService.googleGeocode.request(type: GoogleGeocodeItem.self,parameters: parameters)
            switch result {
            case .success(let result):
                if result.status == "OK" {
                    self.userAddress = result.results.first?.formattedAddress ?? ""
                }
                break
            case .failure(_):
                if let error = error {
                    print(error)
                }
                break
            }
        }
    }
    func checkLocation() async {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    switch self.locationManager.authorizationStatus {
                    case .restricted, .denied:
                        print("No access")
                        self.locationError = true
                        self.showError("LocationNoAccess".localized)
                    case .authorizedAlways, .authorizedWhenInUse:
                        print("Access")
                    case .notDetermined:
                        break
                    @unknown default:
                        break
                    }
                }
            } else {
                DispatchQueue.main.async {
                    print("Location services are not enabled")
                    self.locationError = true
                    self.showError("EnableLocationServices".localized)
                }
            }
        }
    }
}
 
extension LocationGeo: LocationServiceDelegate {
    func tracingLocation(currentLocation: CLLocation) {
        locationError = false
        let coor = currentLocation.coordinate
        self.coordinate = coor
        self.mapId += 1
        self.getPhysicalAddress(coordinate: coor)
    }
    func tracingLocationDidFailWithError(error: Error) {
        print(error)
    }
}
