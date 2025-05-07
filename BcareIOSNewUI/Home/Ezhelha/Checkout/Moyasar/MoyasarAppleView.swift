////
////  MoyasarAppleView.swift
////  BcareIOSNewUI
////
////  Created by Ahmed Mahmoud on 5/21/24.
////
//
//import Foundation
//import SwiftUI
//import Combine
//import MoyasarSdk
//
//struct MoyasarAppleView: View {
//    @EnvironmentObject var coordinator: Coordinator
//    @Environment(\.presentationMode) var presentationMode
//    let price:String
//    var body: some View {
//        VStack(spacing:0) {
//            BackButton(color: Color.black)
//            Spacer()
//            ApplePayButton(action: UIAction(handler: applePayPressed))
//                .frame(height: 50)
//                .cornerRadius(10)
//                .padding(.horizontal, 15)
//            Spacer()
//        }
//    }
//    func handlePaymentResult(_ payment: PaymentResult) {
//    }
//    func applePayPressed(action: UIAction) {
//        do {
//            let applePayHandler = try ApplePayPaymentHandler(paymentRequest: createPaymentRequest())
//            applePayHandler.present()
//        } catch {
//           
//        }
//    }
//    func createPaymentRequest() -> PaymentRequest {
//        let res = Double(price)! * 100
//        let withVat = Int(res.withAddedVat())
//        let paymentRequest = try! PaymentRequest(
//            apiKey: "pk_live_CmFxem25RynGD2RexTFWxLFNJpfUDAcUrFza9PJj",
//            amount: withVat, // Amount in the smallest currency unit For example: 10 SAR = 10 * 100 Halalas
//            currency: "SAR",
//            description: "Flat White",
//            metadata: ["order_id": MetadataValue.integerValue(214124)],
//            manual: false, //  authorize and capture payment automatically or capture it manually
//            saveCard: false,
//            allowedNetworks: [.mastercard, .visa, .mada] // // set your supported networks
//        )
//        return paymentRequest
//    }
//}
