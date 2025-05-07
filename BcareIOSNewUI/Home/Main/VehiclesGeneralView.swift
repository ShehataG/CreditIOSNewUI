//
//  VehiclesGeneralView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SanarKit

struct VehiclesGeneralView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var lottieLoading: LottieLoading
    @EnvironmentObject var servicesStatusVM: ServicesStatusVM
    let gridRows:[GridItem] = [GridItem(.flexible())]
    let mainHeight:CGFloat = Constants.hGridHeight * 121 / 114
    @StateObject var allBookigsVM = AllBookigsVM()
    @StateObject var allOrdersVM = AllOrdersVM()
    @StateObject var allRequestsVM = AllRequestsVM()
    var body: some View {
        if servicesStatusVM.done {
            let vehicleItems = servicesStatusVM.vehicleItems
            if !vehicleItems.isEmpty {
                VStack(spacing:0) {
                    HStack {
                        Text(verbatim:"VehicleServices".localized)
                            .font(Fonts.mediumRegular())
                            .foregroundColor(Color.black)
                            .padding(.horizontal,10)
                        Spacer()
                    }
                    .padding(.top,5)
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows:gridRows,alignment:.bottom,spacing: 10) {
                                ForEach(vehicleItems.indices,id: \.self) { row in
                                    let item = vehicleItems[row]
                                    MainTypeView(item: item)
                                        .tag(row)
                                        .onTapGesture {
                                            if !UserManager.isLoggedIn() {
                                                coordinator.push(Destination.loginPage)
                                                return
                                            }
                                            if item.key == "sweater" {
                                                allBookigsVM.getBookingsPerClient()
                                            }
                                            else if item.key == "mojaz" {
                                                allRequestsVM.mojazCompleteInfosByNationalId()
                                            }
                                            else if item.key == "ezhelhaBattery" {
                                                allOrdersVM.getOrders(EzhelhaType.battery)
                                            }
                                            else if item.key == "ezhelhaTire" {
                                                allOrdersVM.getOrders(EzhelhaType.tire)
                                            }
                                        }
                                }
                            }
                            .frame(height: mainHeight)
                        }
                        .frame(height: mainHeight)
                        .padding(.vertical,20)
                        .onAppear {
                            proxy.scrollTo(0)
                        }
                    }
                }
                .onChange(of: allBookigsVM.checkBookings, perform: { newValue in
                    if let res = allBookigsVM.bookings , res.count > 0 {
                        coordinator.push(res)
                    }
                    else {
                        coordinator.push(CarServiceType.wash)
                    }
                })
                .onChange(of: allOrdersVM.checkOrders, perform: { newValue in
                    if let res = allOrdersVM.orders , res.count > 0 {
                        coordinator.push(OrderSentItem(type: allOrdersVM.currentItem!, items: res))
                    }
                    else {
                        coordinator.push(allOrdersVM.currentItem!)
                    }
                })
                .onChange(of: allRequestsVM.checkBookings, perform: { newValue in
                    if let res = allRequestsVM.bookings , res.count > 0 {
                        coordinator.push(res)
                    }
                    else {
                        coordinator.push(Destination.mojazPage)
                    }
                })
                .onChange(of: allBookigsVM.submitLoadingBookings || allOrdersVM.submitLoadingOrders || allRequestsVM.submitLoadingRecords, perform: { newValue in
                    lottieLoading.show = newValue
                })
                .toast(isPresenting: $allBookigsVM.toastShown) {
                    AlertToast(displayMode: .hud, type: .error(Color.red), title: allBookigsVM.toastContent)
                }
                .toast(isPresenting: $allBookigsVM.toastShownInfo) {
                    AlertToast(displayMode: .hud, type: .complete(Color.green), title: allBookigsVM.toastContentInfo)
                }
                .toast(isPresenting: $allOrdersVM.toastShown) {
                    AlertToast(displayMode: .hud, type: .error(Color.red), title: allOrdersVM.toastContent)
                }
                .toast(isPresenting: $allOrdersVM.toastShownInfo) {
                    AlertToast(displayMode: .hud, type: .complete(Color.green), title: allOrdersVM.toastContentInfo)
                }
                .toast(isPresenting: $allRequestsVM.toastShown) {
                    AlertToast(displayMode: .hud, type: .error(Color.red), title: allRequestsVM.toastContent)
                }
                .toast(isPresenting: $allRequestsVM.toastShownInfo) {
                    AlertToast(displayMode: .hud, type: .complete(Color.green), title: allRequestsVM.toastContentInfo)
                }
            }
        }
        else {
            if noNetwork() {
                NetworkView() {
                    Task {
                        await servicesStatusVM.getConfigs()
                    }
                }
            }
            else {
                LoadingView()
            }
        }
    }
}
