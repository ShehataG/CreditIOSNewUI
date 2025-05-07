//
//  CancelBookingVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import LocalAuthentication
import KeychainSwift

@MainActor
final class CancelBookingVM : MainObservable {
    @Published var selectedCancelIndex = 0
    @Published var cancel = ""
    @Published var cancelError = false
    @Published var cancelErrorText = ""
    let reasons = (1...4).map { "CancelReason\($0)" }
    override init() {
        super.init()
    }
    func proceedCancel(_ delegate:CancelBookingProtocol) {
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
                reason = trimmedCancel
                cancelError = false
            }
        }
        else {
            reason = reasons[selectedCancelIndex]
        }
        
        if cancelError {
            return
        }
        delegate.cancel(reason)
    }
}
