//
//  HelpListView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import  SwiftUI

@MainActor
func openWhats(_ phoneNumber:String) {
    let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
    if UIApplication.shared.canOpenURL(appURL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        }
        else {
            UIApplication.shared.openURL(appURL)
        }
    }
}
