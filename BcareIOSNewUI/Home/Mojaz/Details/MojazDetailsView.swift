//
//  MojazDetailsView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine
import SVGKit

struct MojazDetailsView: View {
    @EnvironmentObject var coordinator: Coordinator
    let item:MojazResult
    let imgWid:CGFloat = isIpad ? 70 : 50
    let imgSmallWid:CGFloat = isIpad ? 50 : 30
    @StateObject var mojazDetailsVM = MojazDetailsVM()
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing:0) {
                if mojazDetailsVM.goToBookings {
                    PaymentSuccessView()
                }
                else {
                    ZStack(alignment: .top) {
                        BackPlaceholderView(factor: 0.3)
                        ScrollView(showsIndicators: false) {
                            HeaderWithBackView(text: "PurchaseDetails")
                            VStack(spacing:0) {
                                HStack {
                                    Text(verbatim:"RequestedReports".localized)
                                        .font(Fonts.mediumRegular())
                                        .foregroundColor(Color.black)
                                    Spacer()
                                }
                                VStack(alignment: .leading) {
                                    HStack {
                                        HStack {
                                            ZStack {
                                                Circle()
                                                    .strokeBorder()
                                                    .foregroundColor(Color.red)
                                                //                                        if let img = SVGKImage(named:item.vehicle.makeCode.addZeros)?.uiImage {
                                                //                                            Image(uiImage: img)
                                                //                                                .resizable()
                                                //                                                 aspectRatio(contentMode: .fit)
                                                //                                                .frame(width:imgSmallWid,height:imgSmallWid)
                                                //                                                .padding(5)
                                                //                                         }
                                                let url = Bundle.main.url(forResource: item.vehicle.makeCode.addZeros, withExtension: "svg")!
                                                SVGImage(url:url,size: CGSize(width: imgSmallWid,height: imgSmallWid))
                                                    .padding(5)
                                            }
                                            .frame(width:imgWid, height:imgWid)
                                            .padding(.leading,10)
                                            VStack {
                                                Text(verbatim:item.vehicle.make())
                                                    .font(Fonts.smallBold())
                                                    .foregroundColor(Color.black)
                                                GrayText(text:item.vehicle.model())
                                                    .font(Fonts.smallRegular())
                                            }
                                            .padding(.horizontal,3)
                                            Spacer()
                                        }
                                        .frame(maxWidth: .infinity)
                                        HStack(spacing: 0) {
                                            VStack(alignment:.leading,spacing: 0) {
                                                PlateView(number: item.vehicle.carPlate.carPlateNumberAr, text: item.vehicle.carPlate.carPlateTextAr)
                                                Divider().foregroundColor(Color.lightGray).frame(height: 1)
                                                PlateView(number: item.vehicle.carPlate.carPlateNumberEn, text: item.vehicle.carPlate.carPlateTextEn)
                                            }
                                            Divider().foregroundColor(Color.lightGray).frame(width: 1)
                                            //                                        if let img = SVGKImage(named:"ksa.svg")?.uiImage {
                                            //                                            Image(uiImage: img)
                                            //                                                .resizable()
                                            //                                                .aspectRatio(contentMode: .fit)
                                            //                                                .frame(width:10,height: 29 * 10 / 9)
                                            //                                                .padding(5)
                                            //                                        }
                                            Image("ksa")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 15,height: 364 * 15 / 118)
                                                .padding(5)
                                            //                                        let url = Bundle.main.url(forResource: "ksa", withExtension: "svg")!
                                            //                                        SVGImage(url:url,size: CGSize(width: 10,height: 29 * 10 / 9))
                                            //                                            .padding(5)
                                        }
                                        .border(Color.lightGray,width: 1)
                                        .padding(.trailing,10)
                                    }
                                    .padding(.top,10)
                                    HStack {
                                        MojazInfoGrid(title: "MadeYear", subtitle: item.vehicle.modelYear.toString())
                                        Rectangle().fill(Color.black)
                                            .frame(width: 1,height: 40)
                                            .padding(.horizontal,15)
                                        MojazInfoGrid(title: "VinOnly", subtitle: item.vehicle.chassisNumber)
                                            .frame(maxWidth: .infinity)
                                    }
                                    .padding(10)
                                    .background(Color(hex:"#F4F4FA")!)
                                    .padding(.top,10)
                                }
                                .border(Color.lightGray, width: 1)
                                .padding(.top,10)
                                VStack(spacing: 15) {
                                    HStack {
                                        Text(verbatim:"RequestSummary".localized)
                                            .font(Fonts.smallRegular())
                                            .foregroundColor(Color.black)
                                        Spacer()
                                    }
                                    .padding(.top,20)
                                    .padding(.bottom,10)
                                    let valueWithoutVat = item.amount.valueWithoutVat()
                                    CheckoutList(title: "ReportPrice".localized, price: valueWithoutVat)
                                    CheckoutList(title: "TaxesVat".localized, price: item.amount - valueWithoutVat)
                                    Divider().padding(.vertical,10).frame(maxWidth: .infinity).frame(height: 3).background(Color.black)
                                    CheckoutList(title: "TotalAmount".localized, price: item.amount,color: appBlueColor,font: Fonts.verySmallRegular())
                                }
                                .padding(.top,15)
                                RoundedLoaderHBu(item: "PayNow", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor,vPadding: 15,showLoader: mojazDetailsVM.submitPaymentStatus)
                                    .padding(.vertical,20)
                                    .onTapGesture {
                                        if !mojazDetailsVM.submitPaymentStatus {
                                            Config.amount = item.amount
                                            mojazDetailsVM.showPaymentPicker = true
                                        }
                                    }
                                if mojazDetailsVM.submitPaymentStatus {
                                    PaymentDontCloseView()
                                }
                                else {
                                    CancelTextView()
                                }
                            }
                            .padding(20)
                            .padding(.vertical,10)
                            .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
                        }
                        //.scrollIndicators(.never)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $mojazDetailsVM.showPaymentPicker,onDismiss: {
            mojazDetailsVM.showPaymentPicker = false
        }) {
            PaymentView(paymentManager:mojazDetailsVM)
                .modifier(PresentationBackgroundModifier())
        }
        .toast(isPresenting: $mojazDetailsVM.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: mojazDetailsVM.toastContent)
        }
        .toast(isPresenting: $mojazDetailsVM.toastShownInfo) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: mojazDetailsVM.toastContentInfo)
        } 
        .background(Color.lightGrayMore)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
        .onFirstAppear {
            mojazDetailsVM.item = item
        }
    }
}
