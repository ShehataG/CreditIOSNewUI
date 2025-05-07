//
//  CheckoutVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

@MainActor
final class CheckoutVM : MainObservable {
    @Published var submitOrderLoading = false
    @State var notes = ""
    @State var discountCode = ""
    @State var total:Double = 50.0
    @State var sum:Double = 57.5
    
    @Published var submitPaymentStatus = false
    @Published var showPaymentPicker = false
    @Published var goToBookings = false
    @Published var serviceType = ServiceType.ezhalha
    @Published var serviceSubType:Int?
    var item:BatteryTireSentItem?
    
    override init() {
        super.init()
    }
}

extension CheckoutVM : PaymentManager {
    func checkPaymentStatus(_ resource:String,currentPayment:PaymentType) {
        guard let item = item else { return }
        let parameters:[String:Any] = [
            "ServiceId":item.service.id.toString(),
            "PhoneNumber":userPhone!,
            "LocationLatitude":item.coordinate.latitude.toString(),
            "LocationLongitude":item.coordinate.longitude.toString(),
            "Notes":notes,
            "PaymentStatusRequest": [
                "ResourcePath":resource,
                "IsApplePay":currentPayment == PaymentType.apple,
                "userId": userId!,
            ]
        ]
        Task {
            showPaymentPicker = false
            submitPaymentStatus = true
            let (result,error) = await JSONPlaceholderService.createOrder.request(type: PaymentStatusItem.self,parameters: parameters)
            switch result {
            case .success(let res):
                print(res)
                let success = res.paymentAndBookingDone
//                let data = try! JSONEncoder().encode(res.paymentStatusOutputModel)
//                self.appleError = data.toJsonStr()
                if success {
                    self.showInfo(res.message)
                    self.goToBookings = true
                }
                else {
                    self.showError(res.message)
                }
                break
            case .failure(_):
                if let error = error {
                    print(error)
                    self.showError(error.description)
                }
                break
            }
            self.submitPaymentStatus = false
         }
    }
}
