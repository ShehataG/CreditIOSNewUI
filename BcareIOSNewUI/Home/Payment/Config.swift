//
//  Config.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import UIKit
import OPPWAMobile

@MainActor
class Config: NSObject {
    // MARK: - The default amount and currency that are used for all payments
    static var amount: Double = 1.0
    static let currency: String = "SAR"
    static let paymentType: String = "PA"
    
    // MARK: - The payment brands for Ready-to-use UI
    static var checkoutPaymentBrands = ["VISA", "MASTER","AMEX","MADA"]
    static var applepayBrands = ["APPLEPAY"]

    // MARK: - The default payment brand for Payment Button
    static let paymentButtonBrand = "VISA"
    static let appleNetworks:[PKPaymentNetwork] = [PKPaymentNetwork.mada,PKPaymentNetwork.amex,PKPaymentNetwork.masterCard,PKPaymentNetwork.visa]
    // MARK: - The card parameters for SDK & Your Own UI form
    static let cardBrand = "VISA"
    static let cardHolder = "JOHN DOE"
    static let cardNumber = "4200000000000042"
    static let cardExpiryMonth = "07"
    static let cardExpiryYear = "2030"
    static let cardCVV = "123"
    
    // MARK: - Other constants
    static let urlScheme = "com.bcare.app"
    static let mainColor: UIColor = UIColor(red: 10.0/255.0, green: 134.0/255.0, blue: 201.0/255.0, alpha: 1.0)
    
    // MARK: - Custom controllers
    static var customControllersEnabled = false
    static let shopperResultURL = Config.urlScheme + "://payment"

    static var providerMode = getMode()
    static func getMode() -> OPPProviderMode {
        #if DEBUG
           return .test
        #else
          return .live
        #endif
    }
}
