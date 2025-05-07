//
//  CheckoutView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine
import MapKit

struct CheckoutView: View {
    @EnvironmentObject var coordinator: Coordinator
    let item:BatteryTireSentItem
    let imgSize:CGFloat = isIpad ? 65 : 45
    @StateObject var checkoutVM = CheckoutVM()
    @FocusState private var focusedField: Field?
//    @State private var showMoyasser = false
    @State private var showConfirmRequest = false
    var body: some View {
        ZStack(alignment:.top) {
            VStack(spacing:0) {
                if checkoutVM.goToBookings {
                    PaymentSuccessView(showBookings: true) {
                        coordinator.resetToPage(Destination.ezhelhaBookingsPage)
                    }
                }
                else {
                    ZStack(alignment: .top) {
                        BackPlaceholderView(factor: 0.5)
                        VStack {
                            HeaderWithBackView(text: "TheService".localized.linesToSpaces)
                            VStack(spacing:0)  {
                                VStack(spacing:0)  {
                                    VStack {
                                        HStack {
                                            Text(verbatim:"NotesToHelper".localized)
                                                .font(Fonts.smallRegular())
                                                .foregroundColor(Color.black)
                                            Spacer()
                                        }
                                        VStack {
                                            TextField("WriteHere".localized, text: $checkoutVM.notes)
                                                .font(Fonts.smallRegular())
                                                .frame(height: 46)
                                                .foregroundColor(appBlueColor)
                                                .multilineTextAlignment(.leading)
                                                .focused($focusedField, equals: Field.notes)
                                                .padding(.vertical,3)
                                                .padding(.horizontal,10)
                                                .colorScheme(.light)
                                        }
                                        .background(Color.lightGrayMid)
                                        .cornerRadius(10)
                                        .padding(.vertical,10)
                                    }
                                    .padding(.vertical,10)
                                    .padding(.horizontal,20)
                                    .modifier(BackgroundModifer())
                                    .padding(.top,10)
                                    //                                HStack {
                                    //                                    TextField("DiscountCode".localized, text: $checkoutVM.notes)
                                    //                                        .font(Fonts.smallRegular())
                                    //                                        .frame(height: 46)
                                    //                                        .foregroundColor(appBlueColor)
                                    //                                        .multilineTextAlignment(.leading)
                                    //                                        .focused($focusedField, equals: Field.discount)
                                    //                                        .padding(.vertical,3)
                                    //                                        .padding(.horizontal,10)
                                    //                                        .colorScheme(.light)
                                    //                                    Spacer()
                                    //                                    ColoredText(text:"Apply".localized)
                                    //                                        .font(Fonts.smallRegular())
                                    //                                        .onTapGesture {
                                    //                                        }
                                    //                                }
                                    //                                .padding(.vertical,10)
                                    //                                .padding(.horizontal,20)
                                    //                                .modifier(BackgroundModifer())
                                    //                                .padding(.top,10)
                                    let price = Double(item.service.price)!
                                    let withVat = price.withAddedVat()
                                    VStack(spacing: 15) {
                                        HStack {
                                            Text(verbatim:"RequestSummary".localized)
                                                .font(Fonts.smallRegular())
                                                .foregroundColor(Color.black)
                                            Spacer()
                                        }
                                        .padding(.vertical,10)
                                        CheckoutList(title: "Total".localized, price: price)
                                        CheckoutList(title: "TaxesVat".localized, price: price.vatValue())
                                        CheckoutList(title: "Sum".localized, price: withVat,color: appBlueColor,font: Fonts.verySmallRegular())
                                    }
                                    .padding(.top,10)
                                    Spacer()
                                    RoundedLoaderHBu(item: "PayNow", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor,vPadding: 15,showLoader:checkoutVM.submitPaymentStatus)
                                        .padding(.vertical,20)
                                        .onTapGesture {
                                            showConfirmRequest = true
                                            //                                          showMoyasser = true
                                        }
                                    if checkoutVM.submitPaymentStatus {
                                        PaymentDontCloseView()
                                    }
                                    else {
                                        CancelTextView()
                                    }
                                }
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .padding(20)
                            .padding(.vertical,10)
                            .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
                        }
                    }
                }
            } 
        }
        .background(Color.lightGrayMore)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
        .fullScreenCover(isPresented: $checkoutVM.showPaymentPicker,onDismiss: {
            checkoutVM.showPaymentPicker = false
        }) {
            PaymentView(paymentManager:checkoutVM)
                .modifier(PresentationBackgroundModifier())
        }
//        .fullScreenCover(isPresented: $showMoyasser,onDismiss: {
//            showMoyasser = false
//        }) {
//            MoyasarCCView(price: item.service.price)
//        }
        .toast(isPresenting: $checkoutVM.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: checkoutVM.toastContent)
        }
        .toast(isPresenting: $checkoutVM.toastShownInfo) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: checkoutVM.toastContentInfo)
        } 
        .alert("ConfirmRequest".localized, isPresented: $showConfirmRequest) {
            Button("Ok".localized, role: .destructive) {
                if !checkoutVM.submitPaymentStatus {
                    let price = Double(item.service.price)!
                    let withVat = price.withAddedVat()
                    Config.amount = withVat
                    checkoutVM.serviceSubType = item.service.id
                    checkoutVM.showPaymentPicker = true
                }
            }
            Button("Cancel".localized, role: .cancel) {
            }
        } message: {
            Text(verbatim: "RequestCantCacelled".localized)
        }
        .onFirstAppear {
            checkoutVM.item = item
        }
    }
}
