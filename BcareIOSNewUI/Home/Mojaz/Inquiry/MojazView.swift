//
//  MojazView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct MojazView: View {
    @EnvironmentObject var coordinator: Coordinator
    let imgWid:CGFloat = isIpad ? 70 : 50
    let imgSmallWid:CGFloat = isIpad ? 30 : 20
    @StateObject var mojazVM = MojazVM()
    @State var showVehicleInfo = false
    @State var showVinCamera = false
    @State var showIstemaraCamera = false
    @State private var scannedCode: String?
    @State var isOn = false
    @State var showYearPicker = false
    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.3)
            ScrollView(showsIndicators: false) {
                HeaderWithBackView(text: "Mojaz")
                VStack(spacing:0) {
                    HStack {
                        Rectangle().fill(Color(hex:"#BE1E2D")!)
                            .frame(width: 4,height: 30)
                            .cornerRadius(2)
                        Text(verbatim:"MojazReport".localized)
                            .font(Fonts.largeRegular())
                            .foregroundColor(Color.black)
                        Image("moreinfo")
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .frame(width: imgSmallWid,height: imgSmallWid)
                          .padding(.horizontal,5)
                          .onTapGesture {
                              showVehicleInfo = true
                          }
                        Spacer()
                        Image("mojazHeader")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imgWid,height: imgWid)
                        
                    }
                    VStack(spacing:0) {
//                        HStack {
//                            Text(verbatim:"VinNumber".localized)
//                                .font(Fonts.smallRegular())
//                                .foregroundColor(Color.black)
//                            Image("moreinfo")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: imgSmallWid,height: imgSmallWid)
//                                .padding(.horizontal,3)
//                                .onTapGesture {
//                                    showVehicleInfo = true
//                                }
//                            Spacer()
//                        }
                        TextInputView(placeholder: "SequenceNumber", value: $mojazVM.vin, errorMessage: mojazVM.vinErrorText, type: .sequence, keyboardType: .numberPad, topPadding: 0)
                        TextInputView(placeholder: "PhoneNumberX", value: $mojazVM.phone, errorMessage: mojazVM.phoneErrorText, type: .phone, keyboardType: .numberPad, topPadding: 20)
                            .modifier(LimitModifer(pin: $mojazVM.phone, limit: 10))
                        YInputView(placeholder: "ModelYear", value: $mojazVM.modelYear, showYearPicker: $showYearPicker, errorMessage: mojazVM.modelYearErrorText, type: .birthYear,topPadding: 20)
                    }
                    .padding(.vertical,20)
                    .padding(.horizontal,20)
                    .modifier(BackgroundModifer())
                    .padding(.top,20)
                    RoundedLoaderHBu(item: "GetReport", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor,vPadding: 15,showLoader:mojazVM.submitReportLoading)
                        .padding(.top,20)
                        .onTapGesture {
                            mojazVM.getReport()
                        }
                    HStack {
                        VStack(alignment: .leading,spacing: 20) {
                            Text(verbatim:"ReportContains".localized)
                                .font(Fonts.smallRegular())
                                .foregroundColor(Color.black)
                            Text(verbatim:"MojazReportContains".localized)
                                .font(Fonts.verySmallLight())
                                .foregroundColor(Color(hex:"#727272")!)
                        }
                        .padding(.horizontal,10)
                        Spacer()
                    }
                    .padding(.top,20)
                    VStack(spacing: 20) {
                        HStack {
                            Spacer()
                            MojazGridView(text: "VehicleInformation".localized, icon: "mojazdetail1")
                            Spacer()
                            MojazGridView(text: "VehicleRecords".localized, icon: "mojazdetail2")
                            Spacer()
                            MojazGridView(text: "OdometerReadings".localized, icon: "mojazdetail3")
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            MojazGridView(text: "RepairHistory".localized, icon: "mojazdetail4")
                            Spacer()
                            MojazGridView(text: "RecordedAccidents".localized, icon: "mojazdetail5")
                            Spacer()
                        }
                    }
                    .padding(.top,20)
                    .padding(.bottom,30)
//                    VStack {
//                        ColoredText(text:"ViewSampleReport".localized)
//                            .font(Fonts.smallRegular())
//                    }
//                    .padding(.vertical,12)
//                    .frame(maxWidth: .infinity)
//                    .cornerRadiusWithBorder(radius: 5, borderLineWidth: 1, borderColor: appBlueColor)
//                    .padding(.vertical,30)
                    Spacer()
                }
                .padding(20)
                .padding(.vertical,10)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
            }
            //.scrollIndicators(.never)
            if showVehicleInfo {
                VehicleInfoView(closeCallback: {
                  showVehicleInfo = false
                },vinCallback: {
                    showVinCamera = true
                },istemaraCallback: {
                    showIstemaraCamera = true
                })
            }
        }
        .background(Color.lightGrayMore)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
        .onChange(of:mojazVM.showDetails, perform: { newValue in
            if newValue {
                coordinator.push(mojazVM.mojazResult!)
                mojazVM.showDetails = false
            }
        })
//        .sheet(isPresented: $showVinCamera) {
//            CreditCardScannerView(isAr:false) { cardNumber in
//                scannedCode = cardNumber
//                print("ScannedCode:- ",scannedCode)
//            }
//        }
//        .sheet(isPresented: $showIstemaraCamera) {
//            CreditCardScannerView(isAr:true) { cardNumber in
//                scannedCode = cardNumber
//                print("ScannedCode:- ",scannedCode)
//            }
//        }
        .fullScreenCover(isPresented: $showYearPicker,onDismiss: {
            showYearPicker = false
         }) { 
             YearPicker(title:"ModelYear".localized,isHigri: false, sentYear:$mojazVM.modelYear,fromNow: true)
                 .modifier(PresentationBackgroundModifier())
        }
        .toast(isPresenting: $mojazVM.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: mojazVM.toastContent)
        }
        .toast(isPresenting: $mojazVM.toastShownInfo) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: mojazVM.toastContentInfo)
        }
    }
}
