//
//  PlaceNinView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine
import MapKit
import GoogleMaps

enum CarServiceType:Int {
    case wash = 0,maintenaince,mojaz,road
}
struct PlaceNinView: View {
    @EnvironmentObject var coordinator: Coordinator
    let item:CarServiceType
    @Environment(\.presentationMode) var presentationMode
    let imgWid:CGFloat = isIpad ? 40.0 : 30.0
    let imgPinWid:CGFloat = isIpad ? 50.0 : 40.0
    @StateObject var placeNin = PlaceNinVM()
    @StateObject var locationGeo = LocationGeo()
    @AppStorage("almTermDone1") var almTerms:Bool = false

    @State var showVehiclePicker = false
    @State var shouldRefresh = true
    @State var dragEnded = 0
    var body: some View {
        ZStack(alignment: .top) {
           BackPlaceholderView(factor: 0.5)
            VStack {
                HStack {
                    Button {
                    } label: {
                        FAText(text: FontAwesome.backIcon)
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }
                            .padding(.horizontal,20)
                            .padding(.vertical,10)
                    }
                    Spacer()
                }
                VStack {
                    HStack(alignment: .top) {
                        Text(verbatim:"WhatsCar".localized)
                            .font(Fonts.smallRegular())
                            .foregroundColor(Color.black)
                            .padding(.top,5)
                        Spacer()
                    }
                    .padding(.horizontal,20)
                    .padding(.top,20)
                    VStack {
                        HStack {
                            GrayText(text:"TheVehicle".localized)
                                .font(Fonts.tooSmallLight())
                                .padding(.top,5)
                            Spacer()
                        }
                        HStack {
                            if placeNin.submitLoading {
                                PureProgressView()
                                Spacer()
                            }
                            else {
                                HStack {
                                    Text(verbatim:placeNin.currentVehicle)
                                        .font(Fonts.verySmallRegular())
                                        .foregroundColor(Color.black)
                                        .padding(.horizontal,10)
                                    Spacer()
                                    if placeNin.vehicles.count > 1 {
                                        Text(verbatim: FontAwesome.arrowDownIcon)
                                            .font(Fonts.fontAwesome15_20())
                                            .foregroundColor(Color(hex: "#001A72")!)
                                    }
                                }
                                .onTapGesture {
                                    if placeNin.vehicles.count > 1 {
                                        showVehiclePicker = true
                                    }
                                }
                            }
                        }
                        .padding(.top,5)
                        .padding(.bottom,20)
                    }
                    .padding(.horizontal,20)
                    .background(Rectangle().fill(Color.white).cornerRadius(10.0).shadow(radius: 3,x: -3,y: 3))
                    .padding(.horizontal,20)
                    .padding(.top,10)
                    HStack {
                        Text(verbatim:"AddNewCarWithPlus".localized)
                            .font(Fonts.verySmallLight())
                            .foregroundColor(appBlueColor)
                            .padding(.horizontal,10)
                            .onTapGesture {
                                shouldRefresh = true
                                coordinator.push(Destination.AddCarPage)
                            }
                        Spacer()
                    }
                    .padding(.horizontal,20)
                    .padding(.vertical,5)
                    HStack {
                        Text(verbatim:"SelectLocation".localized)
                            .font(Fonts.smallRegular())
                            .foregroundColor(.black)
                            .padding(.horizontal,10)
                        Spacer()
                    }
                    .padding(.horizontal,20)
                    .padding(.vertical,5)
                    ZStack(alignment: .center) {
//                        GoogleMapView(coordinate: locationGeo.region.center)
//                        Map(coordinateRegion: $locationGeo.region, showsUserLocation: true)
                        VStack {
                            ZStack(alignment: .center) {
                                GoogleMapView(coordinate: $locationGeo.coordinate, dragEnded: $dragEnded)
                                //                            AppleMapView(mapRegion: $locationGeo.region, dragEnded: $dragEnded, showsUserLocation: true)
                                    .padding(.top,50)
                                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                                    .id(locationGeo.mapId)
                                    .colorScheme(.light)
                                    .onChange(of:dragEnded, perform: { _ in
                                        locationGeo.getPhysicalAddress(coordinate: locationGeo.coordinate)
                                    })
                                Image("locationpin")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: imgPinWid,height: imgPinWid)
                            }
                            VStack {
                                if !almTerms {
                                    HStack(alignment:.center,spacing:10) {
                                        Spacer()
                                        ZStack {
                                            Spacer()
                                                .frame(width:imgWid, height:imgWid)
                                                .background(placeNin.termsDone ? appBlueColor : Color.white)
                                                .cornerRadiusWithBorder(radius: 5,borderColor: appBlueColor)
                                            if placeNin.termsDone {
                                                FAText(text: FontAwesome.correctIcon,color: Color.white,font: Fonts.fontAwesome20_30())
                                            }
                                        }
                                        .padding(.leading,5)
                                        .onTapGesture {
                                            placeNin.termsDone.toggle()
                                        }
                                        Text(verbatim:"AgreeToServiceProviders".localized)
                                            .font(Fonts.tooSmallLight())
                                            .foregroundColor(Color.black)
                                        Spacer()
                                    }
                                    .padding(.bottom,10)
                                }
                                
                                if placeNin.vehicles.isEmpty || locationGeo.userAddress == "" || (!almTerms && !placeNin.termsDone) || locationGeo.locationError {
                                    RoundedLoaderHBu(item: "Next", textColor: .black, backEnableColor: Color.lightGrayMid,backDisableColor:appOrangeDarkColor,vPadding: 15,showLoader:false)
                                        .padding(.horizontal,30)
                                }
                                else {
                                    RoundedLoaderHBu(item: "Next", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor,vPadding: 15,showLoader:placeNin.submitLoadingAvailable)
                                        .padding(.horizontal,30)
                                        .onTapGesture {
                                            placeNin.availableDays(locationGeo.coordinate)
                                        }
                                }
                            }
                            .padding(.top,10)
                            .padding(.bottom,30)
                        }
                        VStack {
                            VStack {
                                HStack {
                                    GrayText(text:"SelectLocation".localized)
                                        .font(Fonts.tooSmallLight())
                                        .padding(.top,5)
                                    Spacer()
                                }
                                HStack { 
                                    if locationGeo.userAddress == "" || locationGeo.locationError {
                                        PureProgressView()
                                    }
                                    else {
                                        Text(verbatim:locationGeo.userAddress)
                                            .font(Fonts.verySmallRegular())
                                            .foregroundColor(Color.black)
                                            .padding(.horizontal,10)
                                    }
                                    Spacer()
                                    Button {
                                    } label: {
                                        Image("pin")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: imgWid,height: imgWid)
                                    }
                                }
                                .padding(.top,5)
                                .padding(.bottom,20)
                            }
                            .padding(.horizontal,20)
                            .background(Rectangle().fill(Color.white).cornerRadius(10.0).shadow(radius: 3,x: -3,y: 3))
                            .padding(.horizontal,20)
                            .padding(.top,10)
                            Spacer()
                        }
                    }
                 }
                .frame(maxWidth: .infinity)
                .padding(.vertical,10)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
            }
        }
        .toast(isPresenting: $placeNin.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: placeNin.toastContent)
        }
        .toast(isPresenting: $locationGeo.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: locationGeo.toastContent)
        }
        .toast(isPresenting: $placeNin.toastShownInfo) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: placeNin.toastContentInfo)
        }
        .fullScreenCover(isPresented: $showVehiclePicker,onDismiss: {
            showVehiclePicker = false
         }) {
             VehiclePicker(vehicles: placeNin.vehicles.map {$0.formatted()}, selected: $placeNin.currentVehicle, selecVehicle: $placeNin.current)
                 .modifier(PresentationBackgroundModifier())
        }
        .onChange(of: placeNin.goToSlots, perform: { newValue in
            let current = placeNin.vehicles[placeNin.current]
            let value = CarLocationItem(car: current,mainItems: placeNin.mainItems!, coordinate: locationGeo.coordinate, location: locationGeo.userAddress, serviceType: item)
            coordinator.push(value)
            almTerms = true

        })
        .background(Color.lightGrayMore)
        .navigationBarBackButtonHidden()
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            if shouldRefresh {
                placeNin.getOwnerVehicles()
                shouldRefresh = false
            }
        }
    }
}
