//
//  AllBookigsVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

@MainActor
final class AllBookigsVM : MainObservable {
    @Published var bookings:[BookingsClientItem]?
    @Published var submitLoadingBookings = false
    @Published var checkBookings = 0
    
    override init() {
        super.init()
    }
    func getBookingsPerClient() {
        if submitLoadingBookings {
            return
        }
        let parameters:[String:String] = [
            "Customer_CountryCode": "+966",
            "Customer_Phone": userPhone!,
            "per_page" : "10"
        ]
        if noNetwork() {
            showNoNetwork()
            return
        }
        Task {
            submitLoadingBookings = true
            let (result,error) = await JSONPlaceholderService.getBookingsPerClient.request(type: [BookingsClientItem].self,parameters: parameters)
            switch result {
            case .success(let res):
                print(res)
                self.bookings = res
                self.checkBookings += 1
                break
            case .failure(_):
                if let error = error {
                    print(error)
                    self.showError(error.description)
                }
                break
            }
            self.submitLoadingBookings = false
         }
    }
}
