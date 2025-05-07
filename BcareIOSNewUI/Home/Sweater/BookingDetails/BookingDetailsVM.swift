//
//  BookingDetailsVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import OPPWAMobile

@MainActor
protocol PaymentManager {
    var serviceType:ServiceType { get set }
    var serviceSubType:Int? { get set }
    var showPaymentPicker:Bool { get set }
    func checkPaymentStatus(_ resource:String,currentPayment:PaymentType)
}

@MainActor
final class BookingDetailsVM : MainObservable {
    @Published var createBooking = false
    @Published var submitPaymentStatus = false
    @Published var showPaymentPicker = false
    @Published var goToBookings = false
    @Published var serviceType = ServiceType.sweater
    @Published var serviceSubType:Int?
    @Published var createBookingTapItem: CreateBookingTapItem?
    @Published var showPaymentPage = false
    var item:BookingDetailsSentItem?
    var timer:Timer?

    override init() {
        super.init()
    }
    
    func createBookingViaSweaterGateway() {
        guard let item = item else { return }
        let parameters:[String:Any] = [
            "date": item.date,
            "from_Time": item.time,
            "vehicle_Latitude": item.place.coordinate.latitude.toString(),
            "vehicle_Longitude": item.place.coordinate.longitude.toString(),
//            "vehicle_Latitude": "30.0213609",
//            "vehicle_Longitude": "31.2268648",
            "nin": userNationalId!,
            "sequnceNumber": item.place.car.sequenceNumber ?? "",
            "userId": userId!
        ]
        Task {
            createBooking = true
            let (result,error) = await JSONPlaceholderService.createBookingViaSweaterGateway.request(type: CreateBookingTapItem.self,parameters: parameters)
            switch result {
            case .success(let res):
                print(res)
                createBookingTapItem = res
                showPaymentPage = true
                startTimer()
                break
            case .failure(_):
                if let error = error {
                    print(error)
                    self.showError(error.description)
                }
                break
            }
            self.createBooking = false
         }
    }
    func startTimer() {
        stopTimer()
        self.timer = Timer.scheduledTimer(withTimeInterval: 3.0,repeats: true) { [weak self] t in
            Task {
                await self?.checkStatus()
            }
        }
    }
    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    func checkStatus() {
        let parameters:[String:Any] = [
            "transactionId": createBookingTapItem!.transactionID,
        ]
        Task {
            submitPaymentStatus = true
            let (result,error) = await JSONPlaceholderService.sweaterPaymentGatewayCallback.request(type: Bool.self,parameters: parameters)
            switch result {
            case .success(let res):
                print(res)
                if res {
                    stopTimer()
                    showPaymentPage = false
                    goToBookings = true
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

//extension BookingDetailsVM : PaymentManager {
//    func checkPaymentStatus(_ resource:String,currentPayment:PaymentType) {
//        guard let item = item else { return }
//        let parameters:[String:Any] = [
//            "BookingInputModel": [
//                "date": item.date,
//                "from_Time": item.time,
//                "vehicle_Latitude": item.place.coordinate.latitude.toString(),
//                "vehicle_Longitude": item.place.coordinate.longitude.toString(),
//                //                "vehicle_Latitude": "30.0213609",
//                //                "vehicle_Longitude": "31.2268648",
//                "nin": userNationalId!,
//                "sequnceNumber": item.place.car.sequenceNumber ?? "",
//                "userId": userId!,
//            ],
//            "PaymentStatusRequest": [
//                "ResourcePath":resource,
//                "IsApplePay":currentPayment == PaymentType.apple
//            ]
//        ]
//        Task {
//            showPaymentPicker = false
//            submitPaymentStatus = true
//            let (result,error) = await JSONPlaceholderService.createBookingWithPayment.request(type: PaymentStatusItem.self,parameters: parameters)
//            switch result {
//            case .success(let res):
//                print(res)
//                let success = res.paymentAndBookingDone
////                let data = try! JSONEncoder().encode(res.paymentStatusOutputModel)
////                self.appleError = data.toJsonStr()
//                if success {
//                    self.showInfo(res.message)
//                    self.goToBookings = true
//                }
//                else {
//                    self.showError(res.message)
//                }
//                break
//            case .failure(_):
//                if let error = error {
//                    print(error)
//                    self.showError(error.description)
//                }
//                break
//            }
//            self.submitPaymentStatus = false
//         }
//    }
//}
