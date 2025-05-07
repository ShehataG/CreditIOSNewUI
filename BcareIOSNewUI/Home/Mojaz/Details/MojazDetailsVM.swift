//
//  MojazDetailsVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class MojazDetailsVM : MainObservable {
    @Published var submitReportLoading = false
    @Published var submitPaymentStatus = false
    @Published var showPaymentPicker = false
    @Published var goToBookings = false
    @Published var serviceType = ServiceType.mojaz
    @Published var serviceSubType:Int?
    var item:MojazResult?

    override init() {
        super.init()
    }
}
 
extension MojazDetailsVM : PaymentManager {
    func checkPaymentStatus(_ resource:String,currentPayment:PaymentType) {
        guard let item = item else { return }
        let parameters:[String:Any] = [
            "referenceId": item.referenceID,
            "PaymentStatusRequest": [
                "ResourcePath":resource,
                "IsApplePay":currentPayment == PaymentType.apple,
                "UserId": userId ?? ""
            ]
        ]
        Task {
            showPaymentPicker = false
            submitPaymentStatus = true
            let (result,error) = await JSONPlaceholderService.setPaymentStatus.request(type: PaymentStatusItem.self,parameters: parameters)
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
