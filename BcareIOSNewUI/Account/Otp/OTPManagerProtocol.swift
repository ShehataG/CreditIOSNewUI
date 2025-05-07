//
//  OTPManager.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation

@MainActor
protocol OTPManager {
    var phone:String { get set }
    var showConfirmOTPLoader:Bool { get set }
    var showResendOTPLoader:Bool { get set }
    var counter:Int { get set }
    var shouldClose:Bool { get set }
    var errorMessage:String? { get set }
    var infoMessage:String? { get set }
    var showErrorMessage:Bool { get set }
    var showInfoMessage:Bool { get set }
    var showOTP:Bool { get set }
    func verify(_ otp:String)
    func resend()
}
