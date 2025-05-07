//
//  BookingDetailsView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine
import MapKit 

struct BookingDetailsView: View {
    let item:BookingDetailsSentItem
    @EnvironmentObject var coordinator: Coordinator
    @State var selected = 0
    let imgWidth:CGFloat = isIpad ? 30.0 : 20.0
    @StateObject var bookingDetailsVM = BookingDetailsVM()
    @State var downloadUrl:URL?
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                if bookingDetailsVM.goToBookings {
                    PaymentSuccessView(showBookings: true) {
                        coordinator.resetToPage(Destination.sweaterBookingsPage)
                    }
                }
//                else if bookingDetailsVM.bookingOutputModel != nil {
//                    WebViewContainer(webViewModel: WebViewModel(url: bookingDetailsVM.bookingOutputModel!.paymentLink), downloadUrl: $downloadUrl)
//                     .frame(maxWidth: .infinity,maxHeight: .infinity)
//                }
                else {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            //                if let merchantTransactionId = bookingDetailsVM.merchantTransactionId {
                            //                    Text(verbatim:merchantTransactionId)
                            //                        .font(Fonts.smallRegular())
                            //                        .foregroundColor(Color.green)
                            //                        .padding(.horizontal,20)
                            //                        .multilineTextAlignment(.center)
                            //                }
                            //                if let appleError = bookingDetailsVM.appleError {
                            //                    ScrollView(showsIndicators: false) {
                            //                        HStack {
                            //                            Spacer()
                            //                            Text(verbatim:appleError)
                            //                                .font(Fonts.smallRegular())
                            //                                .foregroundColor(Color.red)
                            //                                .padding(.horizontal,20)
                            //                                .multilineTextAlignment(.center)
                            //                            Spacer()
                            //                        }
                            //                    }
                            //                    .frame(maxWidth: .infinity)
                            //                    .frame(height: 300)
                            //                }
                            HStack {
                                BackPaddedButton(color: Color.black,back: Color.white)
                                Spacer()
                            }
                            .padding(.horizontal,10)
                            let dimColor = bookingDetailsVM.submitPaymentStatus ? Color.lightGray : Color.white
                            VStack(spacing:0)  {
                                HStack {
                                    Text(verbatim:"BookingDetails".localized)
                                        .font(Fonts.smallRegular())
                                        .foregroundColor(Color.black)
                                        .padding(.horizontal,10)
                                    Spacer()
                                    HStack {
                                        FAText(text: FontAwesome.editIcon,color: dimColor)
                                            .padding(.horizontal,5)
                                        Text(verbatim:"Edit".localized)
                                            .font(Fonts.verySmallRegular())
                                            .foregroundColor(dimColor)
                                    }
                                    .onTapGesture {
                                        if !bookingDetailsVM.submitPaymentStatus {
                                            coordinator.pop(2)
                                        }
                                    }
                                    .padding(10)
                                    .background(appBlueColor)
                                    .cornerRadius(10)
                                }
                                .padding(.vertical,10)
                                VStack(alignment: .leading) {
                                    HStack {
                                        BookingGrid(title: "BookingDate", desc: item.date)
                                        BookingGrid(title: "BookingTime", desc: item.time)
                                    }
                                    HStack {
                                        BookingGrid(title: "OneVehicle", desc: item.place.car.maker)
                                        BookingGrid(title: "PlateNumber", desc: item.place.car.plate)
                                    }
                                    HStack {
                                        BookingGrid(title: "Location", desc: item.place.location,descColor: appBlueColor)
                                    }
                                }
                                .padding(.vertical,15)
                                .padding(.horizontal,20)
                                .background(Color.lightGrayMore)
                                .cornerRadius(10)
                                HStack {
                                    Text(verbatim:"ServiceDetails".localized)
                                        .font(Fonts.smallRegular())
                                        .foregroundColor(Color.black)
                                        .padding(.horizontal,10)
                                    Spacer()
                                }
                                .padding(.vertical,15)
                                VStack(alignment: .leading) {
                                    BookingList(title: "WashInnerOuter", price: item.amount.amount)
                                    //                                BookingNonList(title: "GoodSmell", desc: "FreePresent".localized)
                                    BookingList(title: "TaxesVat", price: item.amount.vat)
                                    Divider().padding(.vertical,10).frame(maxWidth: .infinity).frame(height: 3).background(Color.black)
                                    BookingList(title: "TotalAmount",titleColor: appBlueColor, price: item.amount.amountWithVat)
                                }
                                .padding(.vertical,15)
                                .padding(.horizontal,20)
                                .background(Color.lightGrayMore)
                                .cornerRadius(10)
                                InfoNoteView(title:"SweaterNote".localized)
                                    .padding(.top,10)
                                RoundedLoaderHBu(item: "PayNow", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor,vPadding: 15,showLoader:bookingDetailsVM.createBooking)
                                    .padding(.vertical,20)
                                    .onTapGesture {
                                        if !bookingDetailsVM.createBooking {
//                                            bookingDetailsVM.showPaymentPicker = true
                                            bookingDetailsVM.createBookingViaSweaterGateway()
                                        }
                                    }
//                                if bookingDetailsVM.submitPaymentStatus {
//                                    PaymentDontCloseView()
//                                }
//                                else {
                                    CancelTextView()
//                                }
                            }
                            .padding(.horizontal,20)
                        }
                    }
                }
            }
        }
//        .fullScreenCover(isPresented: $bookingDetailsVM.showPaymentPicker,onDismiss: {
//            bookingDetailsVM.showPaymentPicker = false
//        }) {
//            PaymentView(paymentManager:bookingDetailsVM)
//                .modifier(PresentationBackgroundModifier())
//        }
        .fullScreenCover(isPresented: $bookingDetailsVM.showPaymentPage,onDismiss: {
            bookingDetailsVM.showPaymentPage = false
        }) {
            ForwardView(item: TermsPrivacyItem(url: bookingDetailsVM.createBookingTapItem!.paymentLink))
                .environment(\.layoutDirection,coordinator.layoutDirection)
                .modifier(PresentationBackgroundModifier())
        }
        .toast(isPresenting: $bookingDetailsVM.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: bookingDetailsVM.toastContent)
        }
        .toast(isPresenting: $bookingDetailsVM.toastShownInfo) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: bookingDetailsVM.toastContentInfo)
        }
        //.scrollIndicators(.never)
        .background(Color.lightGrayMid)
        .navigationBarBackButtonHidden()
        .onFirstAppear {
            bookingDetailsVM.item = item
        }
    }
} 
