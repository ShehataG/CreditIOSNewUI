//
//  PaymentView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import OPPWAMobile

struct PaymentView: View {
    @EnvironmentObject var coordinator: Coordinator
//    @Environment(\.presentationMode) var presentationMode
    @StateObject var paymentVM = PaymentVM()
    let imgWid:CGFloat = isIpad ? 40.0 : 30.0
    @State var paymentManager:PaymentManager
    var body: some View {
        ZStack {
            PlaceholderView()
            VStack {
                Spacer()
                VStack {
                    ZStack {
                        Text(verbatim:"ChoosePaymentMethod".localized)
                            .font(Fonts.smallRegular())
                            .foregroundColor(Color.white)
                        HStack {
                            Text(verbatim:"Cancel".localized)
                                .font(Fonts.verySmallRegular())
                                .foregroundColor(Color.white)
                                .onTapGesture {
                                    paymentManager.showPaymentPicker = false
                                }
                            Spacer()
                        }
                        .padding(.horizontal,20)
                    }
                    .padding(.vertical,15)
                    .background(appBlueColor)
                    VStack {
                        PaymentList(title: "CreditDebitCards", images: ["visamada","mada","amex"], showLoader: paymentVM.currentPayment == PaymentType.other && paymentVM.submitCheckoutId)
                            .onTapGesture {
                                paymentVM.startPayment(PaymentType.other)
                            }
                        if OPPPaymentProvider.deviceSupportsApplePay() {
                            PaymentList(title: "Applepay", images: ["applepay"], showLoader: paymentVM.currentPayment == PaymentType.apple && paymentVM.submitCheckoutId)
                                .onTapGesture {
                                    paymentVM.startPayment(PaymentType.apple)
                                }
                        }
                    }
                    .padding(20)
                }
                .padding(.bottom,40)
                .background(Color.white)
            }
            .colorScheme(.light)
            .edgesIgnoringSafeArea(.bottom)
            .environment(\.layoutDirection, coordinator.layoutDirection)
            .toast(isPresenting: $paymentVM.toastShown) {
                AlertToast(displayMode: .hud, type: .error(Color.red), title: paymentVM.toastContent)
            }
            .toast(isPresenting: $paymentVM.toastShownInfo) {
                AlertToast(displayMode: .hud, type: .complete(Color.green), title: paymentVM.toastContentInfo)
            } 
            .onFirstAppear {
                paymentVM.paymentManager = paymentManager
            }
        }
    }
}
