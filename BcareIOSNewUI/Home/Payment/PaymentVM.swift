//
//  PaymentVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import OPPWAMobile

enum PaymentType:Int, Equatable, Codable {
    case none = 0 ,apple,other
}

enum ServiceType:Int, Equatable, Codable {
    case sweater = 3 ,ezhalha = 5,mojaz = 6
}

@MainActor
final class PaymentVM : MainObservable {
    @Published var submitLoadingCreate = false
//    @Published var goToBookings = false
    @Published var submitCheckoutId = false
    @Published var submitPaymentStatus = false
    @Published var currentPayment = PaymentType.none
    @Published var canceled = false
    @Published var showPaymentPicker = false
//    @Published var appleError:String?
    @Published var merchantTransactionId:String?
    var paymentManager:PaymentManager?

    var checkoutProvider: OPPCheckoutProvider?
    var transaction: OPPTransaction?
    let appleMerchantId = "merchant.bcareLive2021.id"
    let appleCountryCode = "SA"
    let appleCurrency = "SAR"

    var contact: PKContact? = nil
    var shippingMethod: PKShippingMethod? = nil
    var summaryItems = [PKPaymentSummaryItem]()
    var serviceType = ServiceType.sweater

    override init() {
        super.init()
//        print("OPPAnalyticsData",OPPAnalyticsData.getMSDKVersion())
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: OperationQueue.main) { [weak self] notification in
            Task { @MainActor in
                self?.process()
            }
        }
    }
    func process() {
        self.checkoutProvider?.dismissCheckout(animated: true)
    }
    func startPayment(_ paymentType:PaymentType){
        if submitCheckoutId {
            return
        }
        currentPayment = paymentType
        getCheckoutId()
    }
    func getCheckoutId() {
        if noNetwork() {
            showNoNetwork()
            return
        }
        let parameters:[String:Any] = [
            "ServiceId": paymentManager!.serviceType.rawValue,
            "SubServiceId": paymentManager?.serviceSubType ?? 0,
            "IsApplePay":currentPayment == PaymentType.apple,
            "UserId": userId ?? ""
        ]
        Task {
            submitCheckoutId = true
            let (result,error) = await JSONPlaceholderService.checkoutWithApplePay.request(type: PaymentItem.self,parameters: parameters)
            self.submitCheckoutId = false
            switch result {
            case .success(let res):
                print(res)
                if self.currentPayment == PaymentType.other {
                    self.merchantTransactionId = res.merchantTransactionId
                    self.presentCheckoutUI(res.checkoutId)
                }
                else if self.currentPayment == PaymentType.apple {
                    self.useApplePayPayment(res.checkoutId)
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
    func presentCheckoutUI(_ checkoutID:String) {
        // Present Checkout UI
        let provider = OPPPaymentProvider(mode: Config.getMode())
        let checkoutSettings = configureCheckoutSettings()
        checkoutProvider = OPPCheckoutProvider(paymentProvider: provider, checkoutID: checkoutID, settings: checkoutSettings)
//        checkoutProvider?.delegate = self
        checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { [weak self] (transaction, error) in
            guard let strong = self else { return }
            guard let transaction = transaction else {
//                print("TransactionError:- ",error)
                strong.showError(error?.localizedDescription)
                return
            }
            strong.transaction = transaction
//            print("ProcessTransactionErrorMada:- ",error)
//            print("ProcessTransactionErrorType:- ",transaction.type.rawValue)
            if transaction.type == .synchronous {
//                print("ProcessTransactionErrorType:- ","synchronous")
                if let _ = transaction.resourcePath {
                    strong.createBookingWithPayment()
                }
            } else if transaction.type == .asynchronous {
//                print("ProcessTransactionErrorType:- ","asynchronous")
                NotificationCenter.default.addObserver(strong, selector: #selector(strong.didReceiveAsynchronousPaymentCallback), name: .hyperpayNotification, object: nil)
            }
            else {
//                print("ProcessTransactionError:- ",error)
//                print("TransactionError:- ","InvalidTransaction")
                strong.showError("InvalidTransaction".localized)
            }
        }, cancelHandler: { [weak self] in
            guard let strong = self else { return }
            strong.paymentCanceled()
         })
    }
    func useApplePayPayment(_ checkoutID:String) {
        let provider = OPPPaymentProvider(mode: .live)
        let checkoutSettings = configureCheckoutSettings()
        let paymentRequest = OPPPaymentProvider.paymentRequest(withMerchantIdentifier: appleMerchantId, countryCode: appleCountryCode)
        paymentRequest.supportedNetworks = Config.appleNetworks
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.currencyCode = appleCurrency
        checkoutSettings.applePayPaymentRequest = paymentRequest
        checkoutProvider = OPPCheckoutProvider(paymentProvider: provider, checkoutID: checkoutID, settings: checkoutSettings)
//        checkoutProvider?.delegate = self
        checkoutProvider?.presentCheckout(withPaymentBrand: "APPLEPAY",
           loadingHandler: { (inProgress) in
            // Executed whenever SDK sends request to the server or receives the answer.
            // You can start or stop loading animation based on inProgress parameter.
        }, completionHandler: { [weak self] (transaction, error) in
            guard let strong = self else { return }
            guard let transaction = transaction else {
//                print("TransactionError:- ",error)
                strong.showError(error?.localizedDescription)
                return
            }
            strong.transaction = transaction
            if error != nil {
                // See code attribute (OPPErrorCode) and NSLocalizedDescription to identify the reason of failure.
//                print("ProcessTransactionError:- ",error)
            } else {
                if transaction.redirectURL != nil {
                    // Shopper was redirected to the issuer web page.
                    // Request payment status when shopper returns to the app using transaction.resourcePath or just checkout id.
                } else if let _ = transaction.resourcePath {
                    // Request payment status for the synchronous transaction from your server using transactionPath.resourcePath or just checkout id.
                    strong.createBookingWithPayment()
                }
                else {
//                    print("TransactionError:- ","InvalidTransaction")
                    strong.showError("InvalidTransaction".localized)
                }
            }
        }, cancelHandler: { [weak self] in
            // Executed if the shopper closes the payment page prematurely.
            guard let strong = self else { return }
            strong.paymentCanceled()
        })
    }
    func paymentCanceled() {
        //self.showError("PaymentCanceled".localized)
        self.canceled = true
    }
    func createBookingWithPayment() {
        guard let transaction = transaction else { return }
        if noNetwork() {
            showNoNetwork()
            return
        }
        let resource = transaction.resourcePath!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)!
        paymentManager?.checkPaymentStatus(resource, currentPayment: currentPayment)
    }
    func configureCheckoutSettings() -> OPPCheckoutSettings {
        let checkoutSettings = OPPCheckoutSettings()
        let brands = currentPayment == PaymentType.apple ? Config.applepayBrands : Config.checkoutPaymentBrands
        checkoutSettings.paymentBrands = brands
        checkoutSettings.shopperResultURL = Config.shopperResultURL
        checkoutSettings.theme.navigationBarBackgroundColor = Config.mainColor
        checkoutSettings.theme.confirmationButtonColor = Config.mainColor
        checkoutSettings.theme.accentColor = Config.mainColor
        checkoutSettings.theme.cellHighlightedBackgroundColor = Config.mainColor
        checkoutSettings.theme.sectionBackgroundColor = Config.mainColor //.withAlphaComponent(0.05)
        let threeDS2Config = OPPThreeDSConfig()
        threeDS2Config.appBundleID = Bundle.main.bundleIdentifier!
        checkoutSettings.threeDSConfig = threeDS2Config
        let afterpayDict = [ "inlineFlow" : ["'AFTERPAY_PACIFIC'"]]
        let jsConfig = [ "onReady" :  "function(){$(\"button.wpwl-button-brand\").hide();setTimeout(function() { wpwl.executePayment(\"wpwl-container-virtualAccount-AFTERPAY_PACIFIC\"); }, 1500);}" ]
        let afterpayConfig = OPPWpwlOptions.initWithConfiguration(afterpayDict, jsFunctions: jsConfig)
        checkoutSettings.wpwlOptions["AFTERPAY_PACIFIC"] = afterpayConfig
        checkoutSettings.language = langText
        return checkoutSettings
    }
    @objc func didReceiveAsynchronousPaymentCallback() {
        NotificationCenter.default.removeObserver(self, name: .hyperpayNotification, object: nil)
        self.checkoutProvider?.dismissCheckout(animated: true) {
            DispatchQueue.main.async {
               self.createBookingWithPayment()
            }
        }
    }
}

//extension PaymentVM: OPPCheckoutProviderDelegate {
//    func checkoutProvider(_ checkoutProvider: OPPCheckoutProvider, applePayDidSelectShippingContact contact: PKContact, handler completion: @escaping (OPPApplePayRequestShippingContactUpdate) -> Void) {
//        // You may want to provide different shipping methods based on shipping information
//        let shippingMethods = self.shippingMethods(contact: contact)
//        // You may want to change amount of transaction (e.g. by adding tax) based on shipping information
//        self.contact = contact
//        updateSummaryItems()
//        let update = OPPApplePayRequestShippingContactUpdate(errors: nil, paymentSummaryItems: self.summaryItems, shippingMethods: shippingMethods)
//        completion(update)
//    }
//    func checkoutProvider(_ checkoutProvider: OPPCheckoutProvider, applePayDidSelect shippingMethod: PKShippingMethod, handler completion: @escaping (OPPApplePayRequestShippingMethodUpdate) -> Void) {
//        // You may want to change amount of transaction based on shipping method cost
//        self.shippingMethod = shippingMethod
//        updateSummaryItems()
//        let update = OPPApplePayRequestShippingMethodUpdate(paymentSummaryItems: self.summaryItems)
//        completion(update)
//    }
//    func checkoutProvider(_ checkoutProvider: OPPCheckoutProvider, applePayDidAuthorizePayment payment: PKPayment, handler completion: @escaping (OPPApplePayRequestAuthorizationResult) -> Void) {
//        var result: OPPApplePayRequestAuthorizationResult
//        // You may want to validate shipping/billing info
//        if isValidBillingContact(contact: payment.billingContact) {
//            // Return success to continue the payment
//            result = OPPApplePayRequestAuthorizationResult(status: .success, errors: nil)
//        } else {
//            var errors: [Error] = []
//            if #available(iOS 11.0, *) {
//                // Since iOS 11 you can pass list of errors in billing/shipping info
//                let error = PKPaymentRequest.paymentBillingAddressInvalidError(withKey: CNPostalAddressCountryKey, localizedDescription: "Some country error mesage")
//                errors = [error]
//            }
//            result = OPPApplePayRequestAuthorizationResult(status: .failure, errors: errors)
//        }
//
//        completion(result)
//    }
//    func isValidBillingContact(contact:PKContact?) -> Bool {
//        return true
//    }
//    func updateSummaryItems() {
//    }
//    func shippingMethods(contact:PKContact?) -> [PKShippingMethod] {
//        return []
//    }
//}
