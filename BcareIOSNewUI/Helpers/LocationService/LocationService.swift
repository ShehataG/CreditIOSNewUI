//
//  LocationService .swift
//  Mprayer
//
//  Created by Mac on 12/27/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
 
import CoreLocation

@MainActor
protocol LocationServiceDelegate {
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: Error)
}
 
class LocationSingleton: NSObject, @preconcurrency CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?
    var delegate: LocationServiceDelegate?
    @MainActor
    static let shared:LocationSingleton = {
        let instance = LocationSingleton()
        return instance
    }()
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        
        guard let locationManagers = self.locationManager else {
            return
        }
        
        let authorizationStatus: CLAuthorizationStatus

        if #available(iOS 14, *) {
            authorizationStatus = locationManagers.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if authorizationStatus == .notDetermined {
            locationManagers.requestAlwaysAuthorization()
            locationManagers.requestWhenInUseAuthorization()
        }
        locationManagers.desiredAccuracy = kCLLocationAccuracyBest
        locationManagers.pausesLocationUpdatesAutomatically = false
        locationManagers.distanceFilter = 0.1
        locationManagers.delegate = self
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
        
    @MainActor func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        manager.stopUpdatingLocation()
        self.lastLocation = location
        updateLocation(currentLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager?.requestAlwaysAuthorization() 
            break
        case .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
            NotificationCenter.default.post(name: .locationNotification, object:nil)
            break
        case .authorizedAlways:
            locationManager?.startUpdatingLocation()
            NotificationCenter.default.post(name: .locationNotification, object:nil)
            break
        case .restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            print("restrictedrestrictedrestrictedrestricted")
            NotificationCenter.default.post(name: .locationNotification, object:nil)
            break
        case .denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            NotificationCenter.default.post(name: .locationNotification, object:nil)
            //  print("denieddenieddenieddenieddenieddenieddenied")
            break
 
        default:
            break
        }
    }
    
    // Private function
    @MainActor private func updateLocation(currentLocation: CLLocation) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.tracingLocation(currentLocation: currentLocation)
    }
    
    @MainActor private func updateLocationDidFailWithError(error: NSError) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.tracingLocationDidFailWithError(error: error)
    }
    
    func startUpdatingLocation() {
        print("Starting Location Updates")
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }
    
    func startMonitoringSignificantLocationChanges() {
        self.locationManager?.startMonitoringSignificantLocationChanges()
    }
    
    // #MARK:   get the alarm time from date and time
}
