//
//  MainObservable.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 6/3/24.
//

import Foundation
import SwiftUI
import Combine
 
@MainActor
class MainObservable : NSObject,ObservableObject {
    @Published var toastShown = false
    @Published var toastContent = ""
    @Published var toastShownInfo = false
    @Published var toastContentInfo = ""
    func showError(_ message:String?) {
        DispatchQueue.main.async {
            if let des = message , !des.isEmpty {
                self.toastContent = des
                self.toastShown = true
            }
        }
    }
    func showInfo(_ message:String?) {
       DispatchQueue.main.async {
           if let des = message , !des.isEmpty {
               self.toastContentInfo = des
               self.toastShownInfo = true
           }
       }
    }
    func showNoNetwork() {
        toastContent = "NoInternet".localized
        toastShown = true
    }
}
