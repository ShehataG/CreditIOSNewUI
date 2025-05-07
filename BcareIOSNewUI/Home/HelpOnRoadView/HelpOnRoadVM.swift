//
//  LoginVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import MapKit

@MainActor
final class HelpOnRoadVM : MainObservable {
    @Published var remainingRequests = 5
    @Published var serviceType = "اطارات".localized
    @Published var selectedCancelIndex = 0
    @Published var submitLoadingRequest = false
    @Published var submitLoadingCancel = false
    @Published var cancel = ""
    @Published var cancelError = false
    @Published var cancelErrorText = ""
    override init() {
        super.init()
    }
    func cancelRequest() {
        var reason = ""
        if selectedCancelIndex == 3 {
            let trimmedCancel = cancel
            if trimmedCancel == "" {
                cancelErrorText = "CancelReasonRequired".localized
                cancelError = true
            }
            else if trimmedCancel.count < 10 {
                cancelErrorText = "CancelReasonIncorrect".localized
                cancelError = true
            }
            else {
                cancelError = false
            }
        }
        else {
            reason = "Exists"
        }
        
        if cancelError {
            return
        }
        
        if noNetwork() {
            showNoNetwork()
            return
        }
        
        let parameters:[String:String] = [
            "Request_id": "20287",
            "Cancel_Reason": reason
        ]
        Task {
            submitLoadingCancel = true
            let (result,error) = await JSONPlaceholderService.cancelBooking.request(type: AvailableDaysItem.self,parameters: parameters)
            self.submitLoadingCancel = false
            switch result {
            case .success(let res):
                print(res)
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
