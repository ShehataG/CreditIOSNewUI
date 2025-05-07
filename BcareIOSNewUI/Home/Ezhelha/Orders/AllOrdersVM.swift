//
//  AllOrdersVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

@MainActor
final class AllOrdersVM : MainObservable {
    @Published var orders:[OrderDatum]?
    @Published var submitLoadingOrders = false
    @Published var checkOrders = 0
    @Published var currentItem:EzhelhaType? 
    @Published var disableAddBooking = true
    let possibleCurrent = ["Accepted","مقبول","Pending","في انتظار الموافقة"]

    override init() {
        super.init()
    }
    func getOrders(_ sent:EzhelhaType? = nil) {
        if submitLoadingOrders {
            return
        }
        let parameters:[String:String] = [
            "phoneNumber": userPhone!
        ]
        if noNetwork() {
            showNoNetwork()
            return
        }
        currentItem = sent
        Task {
            submitLoadingOrders = true
            let (result,error) = await JSONPlaceholderService.orders.request(type: OrderItem.self,parameters: parameters)
            switch result {
            case .success(let res):
                print(res)
                self.orders = res.data
                self.checkOrderStatus()
                self.checkOrders += 1
                print(res)
                break
            case .failure(_):
                if let error = error {
                    print(error)
                    self.showError(error.description)
                }
                break
            }
            self.submitLoadingOrders = false
        }
    }
    func checkOrderStatus() {
        disableAddBooking = !canOrder()
    }
    func canOrder() -> Bool {
        if let orders = orders {
            return orders.count { possibleCurrent.contains($0.status) } == 0
        }
        return true
    }
    func showCurrentOrder() {
        toastContent = "OngoingOrder".localized
        toastShown = true
    }
}
