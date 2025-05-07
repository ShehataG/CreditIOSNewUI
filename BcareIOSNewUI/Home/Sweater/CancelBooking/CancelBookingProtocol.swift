//
//  CancelBookingProtocol.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation

@MainActor
protocol CancelBookingProtocol {
    var submitLoadingCancel:Bool { get set } 
    func cancel(_ message:String)
    var showCancel:Bool { get set }
}
