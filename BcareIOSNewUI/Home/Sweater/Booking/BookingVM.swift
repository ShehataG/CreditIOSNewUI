//
//  BookingVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

@MainActor
final class BookingVM : MainObservable {
    @Published var amount:AmountItem?
    @Published var search = ""
    @Published var time = ""
//    @Published var days:[AvailableDaysItem] = []
//    @Published var mainItems:[AvailableMainItem]?
    @Published var currentMainIndex = 0
    @Published var currentSubIndex:Int? = nil
    @Published var currentSlotIndex:Int? = nil
    @Published var submitLoadingAvailable = true
    @Published var submitLoadingCancel = true
    @Published var submitAmountLoadig = false
    
    override init() {
        super.init()
        Task {
            await getSweaterPrice()
        }
    }
    func getSweaterPrice() async {
        let parameters:[String:Any] = [
            "ServiceId":ServiceType.sweater.rawValue,
        ]
        Task {
            submitAmountLoadig = true
            let (result,error) = await JSONPlaceholderService.getServiceAmount.request(type: AmountItem.self,parameters: parameters)
            self.submitAmountLoadig = false
            switch result {
            case .success(let res):
                print(res)
                if res.success {
                    self.amount = res
                }
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
//    func availableDays(_ coordinate:CLLocationCoordinate2D) {
//        let parameters:[String:String] = [
////            "vehicle_Latitude": "30.0213609",
////            "vehicle_Longitude": "31.2268648",
//            "vehicle_Latitude": coordinate.latitude.toString(),
//            "vehicle_Longitude": coordinate.longitude.toString()
//        ]
//        if noNetwork() {
//            showNoNetwork()
//            return
//        }
//        Task {
//            submitLoadingAvailable = true
//            let (result,error) = await JSONPlaceholderService.getAvailableDaysSlots.request(type: [AvailableDaysItem].self,parameters: parameters)
//            self.submitLoadingAvailable = false
//            switch result {
//                case .success(let res):
//                    self.days = res
//                    self.start()
//                    break
//                case .failure(_):
//                    if let error = error {
//                        print(error)
//                        self.showError(error.description)
//                    }
//                break
//            }
//        }
//    }
//    func selectedTime() {
//        time = currentSubIndex == nil || currentSlotIndex == nil ? "ChooseTime".localized : mainItems![currentMainIndex].items[currentSubIndex!].slots[currentSlotIndex!].startTime
//    }
//    func start() {
//        let res = days.allSatisfy { $0.slots.isEmpty }
//        if days.isEmpty || res {
//            mainItems = []
//            return
//        }
//        var main = [AvailableMainItem]()
//        let first = days.first!
//        var title  = first.date.monthName
//        var tem:[AvailableDaysItem] = [first]
//        (1..<days.count).forEach {
//            let inner = days[$0].date.monthName
//            if inner == title {
//                tem.append(days[$0])
//            }
//            else {
//                main.append(AvailableMainItem(date: title, items: tem))
//                tem.removeAll()
//                tem.append(days[$0])
//                title = inner
//            }
//        }
//        main.append(AvailableMainItem(date: title, items: tem))
//        mainItems = main
//        selectedTime()
//    }
}
