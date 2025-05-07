//
//  BatteryView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine
import MapKit
enum EzhelhaType: Int, CaseIterable {
    case battery=6,tire=7,satha
}
struct BatteryTireView: View {
    @EnvironmentObject var coordinator: Coordinator
    let item:EzhelhaType
    let imgSize:CGFloat = isIpad ? 65 : 45
    @StateObject var batteryTireVM = BatteryTireVM()
    @State var header = ""
    init(item: EzhelhaType) {
        self.item = item 
    }
    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.5)
            VStack {
                HeaderWithBackView(text: batteryTireVM.header.linesToSpaces)
                VStack(spacing:0) {
                    if batteryTireVM.submitServicesLoading {
                        LoadingView()
                    }
                    else {
                        ScrollViewReader { proxy in
                            let services = batteryTireVM.services
                            List(services.indices,id: \.self) { row in
                                BatteryTireList(item: services[row],selected:batteryTireVM.selectedIndex == row)
                                    .modifier(ListItemMode())
                                    .onTapGesture {
                                        batteryTireVM.selectedIndex = row
                                    }
                                if row == services.count - 1 {
                                    if let address = batteryTireVM.address , let coordinate = batteryTireVM.coordinate {
                                        ServiceLocationMap(address: address, region: MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), mapId: batteryTireVM.mapId) {
                                            batteryTireVM.showLocationPicker = true
                                        }
                                        .modifier(ListItemMode())
                                        .onAppear {
                                           proxy.scrollTo("Continue")
                                         }
                                    }
                                    else {
                                        ServiceLocationView() {
                                            batteryTireVM.showLocationPicker = true
                                        }
                                        .modifier(ListItemMode())
                                    }
                                    InfoNoteView(title:"EzhelhaNote".localized)
                                        .modifier(ListItemMode())
                                        .padding(.top,10)
                                    if batteryTireVM.address == nil || batteryTireVM.selectedIndex == -1 {
                                        RoundedLoaderHBu(item: "Continue", textColor: .black, backEnableColor: Color.lightGrayMid,backDisableColor:appOrangeDarkColor,vPadding: 15,showLoader:false)
                                            .modifier(ListItemMode())
                                            .padding(.top,30)
                                    }
                                    else {
                                        RoundedLoaderHBu(item: "Continue", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor,vPadding: 15,showLoader:false)
                                            .modifier(ListItemMode())
                                            .padding(.top,30)
                                            .id("Continue")
                                            .onTapGesture {
                                                let value = BatteryTireSentItem(service: services[batteryTireVM.selectedIndex], coordinate: batteryTireVM.coordinate!)
                                                coordinator.push(value)
                                            }
                                    }
                                }
                            }
                            .modifier(ListMode())
                        }
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .padding(.vertical,10)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
            }
        }
        .background(Color.lightGrayMore)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
        .fullScreenCover(isPresented: $batteryTireVM.showLocationPicker,onDismiss: {
            batteryTireVM.showLocationPicker = false
         }) {
             PlaceView(callBack: { address,coordinate in
                 batteryTireVM.address = address
                 batteryTireVM.coordinate = coordinate
                 batteryTireVM.mapId += 1
            }).modifier(PresentationBackgroundModifier())
        }
        .toast(isPresenting: $batteryTireVM.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: batteryTireVM.toastContent)
        }
        .toast(isPresenting: $batteryTireVM.toastShownInfo) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: batteryTireVM.toastContentInfo)
        }
        .onFirstAppear {
            batteryTireVM.partnerServices(item.rawValue)
        }
    }
}
