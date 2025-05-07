//
//  MedicalProvidersView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine
import MapKit
import GoogleMaps

struct MedicalProvidersView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var policyDetailsVM = PolicyDetailsVM()
    @StateObject var locationAccessor = LocationAccessor()
    @State var selected = 0
    let imgWidth:CGFloat = isIpad ? 30.0 : 20.0
    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.3)
            VStack {
                HStack {
                    BackButton()
                    Spacer()
                    Text(verbatim:"MedicalServiceProviders".localized)
                        .font(Fonts.mediumRegular())
                        .foregroundColor(Color.white)
                        .padding(.horizontal,10)
                        .padding(.bottom,15)
                }
                .padding(.horizontal,10)
                VStack {
                        HStack {
                            ProvidersOptionsBu(text: "All", img: "dots", isSelected: selected == 0)
                                .onTapGesture {
                                    selected = 0
                                }
                            ProvidersOptionsBu(text: "Hospitals", img: "hospital", isSelected: selected == 1)
                                .onTapGesture {
                                    selected = 1
                                }
                            ProvidersOptionsImageBu(normalImg: "bcare", selectedImg: "logowh", isSelected: selected == 2)
                                .onTapGesture {
                                    selected = 2
                                }
                            Spacer()
                        }
                        .padding(.horizontal,30)
                        ZStack {
                             //GoogleMapView(coordinate: locationAccessor.region.center)
                             Map(coordinateRegion: $locationAccessor.region, showsUserLocation: true)
                             .frame(maxWidth: .infinity,maxHeight: .infinity)
                             .colorScheme(.light)
                             .padding(.top,20)
                            VStack {
                                Spacer()
                                HStack {
                                    Text(verbatim: "ShowList".localized)
                                        .font(Fonts.smallMedium())
                                        .frame(height: imgWidth)
                                        .foregroundColor(.white)
                                        .padding(.horizontal,7)
                                        .padding(.vertical,12)
                                        .background(appBlueColor)
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            coordinator.push(Destination.medicalMenuPage)
                                        }
                                    Spacer()
                                    Image("loccenter")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: imgWidth,height: imgWidth)
                                        .padding(.horizontal,12)
                                        .padding(.vertical,12)
                                        .background(appBlueColor)
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            locationAccessor.center()
                                        }
                                }
                                .padding(.horizontal,30)
                                .padding(.bottom,60)
                            }
                    }
                }
                .padding(.top,30)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .modifier(RoundedBackgroundModifer(color: Color(hex: "#F2F4F6")!))
                Spacer()
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden()
        .edgesIgnoringSafeArea(.bottom)
    }
}
