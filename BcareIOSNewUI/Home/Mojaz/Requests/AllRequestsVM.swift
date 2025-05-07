//
//  AllRequestsVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class AllRequestsVM : MainObservable {
    @Published var bookings:[MojazResult]?
    @Published var submitLoadingRecords = false
    @Published var checkBookings = 0
    
    override init() {
        super.init()
    }
    func mojazCompleteInfosByNationalId() {
        if submitLoadingRecords {
            return
        }
        let parameters:[String:String] = [
            "nationalId": userNationalId!
        ]
        if noNetwork() {
            showNoNetwork()
            return
        }
        
        Task {
            submitLoadingRecords = true
            let (result,error) = await JSONPlaceholderService.mojazCompleteInfosByNationalId.request(type:MojazRecordsItem.self,parameters: parameters)
            switch result {
                case .success(let res):
                    print(res)
                    if res.errorDetails.isSuccess , let value = res.result {
                        bookings = value
                    }
                    self.checkBookings += 1
                    break
                case .failure(_):
                    if let error = error {
                        print(error)
                        self.showError(error.description)
                    }
                    break
            }
            self.submitLoadingRecords = false
         }
    }
}
