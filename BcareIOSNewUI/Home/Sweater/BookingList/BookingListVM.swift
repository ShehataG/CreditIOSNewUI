//
//  BookingListVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class BookingListVM : MainObservable {
    @Published var bookings:[AvailableDaysItem] = []
    @Published var submitLoadingCancel = false
    @Published var lastBookingId = 0
    @Published var showCancel = false
    @Published var goBack = false
    override init() {
        super.init()
    }
}
 
extension BookingListVM : CancelBookingProtocol {
    func cancel(_ message:String) {
        if noNetwork() {
            showNoNetwork()
            return
        }
        
        let parameters:[String:String] = [
            "Booking_id": lastBookingId.toString(),
            "Cancel_Reason": message
        ]
        Task {
            submitLoadingCancel = true
            let (result,error) = await JSONPlaceholderService.cancelBooking.request(type: CancelBookingItem.self,parameters: parameters)
            self.submitLoadingCancel = false
            switch result {
            case .success(let res):
                print(res)
                if res.success {
                    self.showCancel = false
                    self.showInfo(res.message)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.goBack = true
                    }
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
}
