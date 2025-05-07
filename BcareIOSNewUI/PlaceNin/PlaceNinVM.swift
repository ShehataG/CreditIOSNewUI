//
//  PlaceNinVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import MapKit
import CoreLocation

@MainActor
final class PlaceNinVM : MainObservable {
    @Published var vehicles: [VehicleByNinItem] = []
    @Published var current = 0
    @Published var currentVehicle = ""
    @Published var submitLoading = false
    @Published var termsDone = false
    @Published var submitLoadingAvailable = false
    @Published var mainItems:[AvailableMainItem]?
    @Published var days:[AvailableDaysItem] = []
    @Published var goToSlots = 0

    override init() {
        super.init()
    }
    func getOwnerVehicles() {
        guard let nin = userNationalId else { return  }
        if noNetwork() {
            showNoNetwork()
            return
        }
        let parameters:[String : Any] = [
            "nin": nin
        ]
        Task {
            submitLoading = true
            let (result,_) = await JSONPlaceholderService.getOwnerVehicles.request(type: [VehicleByNinItem].self,parameters: parameters)
            self.submitLoading = false
            switch result {
            case .success(let result):
                print(result)
                if result.isEmpty {
                    self.setNoCars()
                }
                else {
                    self.vehicles = result
                    self.selectItem()
                }
                break
            case .failure(_):
//                if let error = error {
//                    print(error)
//                    setNoCars()
//                }
                break
            }
        }
    }
    func setNoCars() {
        DispatchQueue.main.async  {
            self.showError("YouHaveNoCars".localized)
            self.currentVehicle = "NoCars".localized
        }
    }
    func selectItem(_ index:Int = 0) {
        current = index
        let item = vehicles[index]
        currentVehicle = item.formatted()
    }
    func availableDays(_ coordinate:CLLocationCoordinate2D) {
        let parameters:[String:String] = [
//            "vehicle_Latitude": "30.0213609",
//            "vehicle_Longitude": "31.2268648",
            "vehicle_Latitude": coordinate.latitude.toString(),
            "vehicle_Longitude": coordinate.longitude.toString()
        ]
        if noNetwork() {
            showNoNetwork()
            return
        }
        Task {
            submitLoadingAvailable = true
            let (result,error) = await JSONPlaceholderService.getAvailableDaysSlots.request(type: [AvailableDaysItem].self,parameters: parameters)
            self.submitLoadingAvailable = false
            switch result {
                case .success(let res):
                    self.days = res
                    self.start()
                    break
                case .failure(_):
                    if let error = error {
                        print(error)
                        self.showError(error.description)
                    }
                break
            }
        }
    }
    func start() {
        let res = days.allSatisfy { $0.slots.isEmpty }
        if days.isEmpty || res {
            mainItems = []
            showInfo("NoBikersHere".localized)
            return
        }
        var main = [AvailableMainItem]()
        let first = days.first!
        var title  = first.date.monthName
        var tem:[AvailableDaysItem] = [first]
        (1..<days.count).forEach {
            let inner = days[$0].date.monthName
            if inner == title {
                tem.append(days[$0])
            }
            else {
                main.append(AvailableMainItem(date: title, items: tem))
                tem.removeAll()
                tem.append(days[$0])
                title = inner
            }
        }
        main.append(AvailableMainItem(date: title, items: tem))
        mainItems = main
        goToSlots += 1
    }
}
