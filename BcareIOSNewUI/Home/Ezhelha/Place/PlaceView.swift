//
//  PlaceView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine
import MapKit

struct PlaceView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.presentationMode) var presentationMode
    let imgWid:CGFloat = isIpad ? 40.0 : 30.0
    let imgPinWid:CGFloat = isIpad ? 50.0 : 40.0
    @StateObject var locationGeo = LocationGeo()
    @State var dragEnded = 0
    var callBack:((String,CLLocationCoordinate2D)->())?
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
                    ZStack(alignment: .center) {
//                        GoogleMapView(coordinate: locationGeo.region.center)
//                        Map(coordinateRegion: $locationGeo.region, showsUserLocation: true)
                        ZStack(alignment: .center) {
//                            AppleMapView(mapRegion: $locationGeo.region, dragEnded: $dragEnded, showsUserLocation: true)
                            GoogleMapView(coordinate: $locationGeo.coordinate, dragEnded: $dragEnded)
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
                        VStack {
                            Spacer()
                            if locationGeo.userAddress == "" || locationGeo.locationError {
                                RoundedBu(item: "ConfirmAddress", textColor: Color.black, backColor: Color.lightGrayMid,font: Fonts.smallRegular(), width: 0.4, vPadding: 20)
                            }
                            else {
                                RoundedBu(item: "ConfirmAddress", textColor: Color.white, backColor: appBlueColor,font: Fonts.smallRegular(), width: 0.4, vPadding: 20)
                                    .onTapGesture {
                                        callBack?(locationGeo.userAddress,locationGeo.coordinate)
                                        presentationMode.wrappedValue.dismiss()
                                    }
                            }
                           
                        }
                        .padding(.bottom,30)
                    }
                 }
                .frame(maxWidth: .infinity)
                .padding(.vertical,10)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
            }
        }
        .toast(isPresenting: $locationGeo.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: locationGeo.toastContent)
        }
        .environment(\.layoutDirection, coordinator.layoutDirection)
        .background(Color.lightGrayMore)
        .navigationBarBackButtonHidden()
        .edgesIgnoringSafeArea(.bottom)  
    }
}
