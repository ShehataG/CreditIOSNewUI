//
//  ServiceLocationMap.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

struct ServiceLocationMap: View {
    let address:String
    let region:MKCoordinateRegion
    let mapId:Int
    let imgPinWid:CGFloat = isIpad ? 30.0 : 20.0
    var callBack:(()->())?
    @State var dragEnded = 0

    init(address: String, region: MKCoordinateRegion,mapId:Int, callBack: (() -> ())? = nil) {
        self.address = address
        self.region = region
        self.mapId = mapId
        self.callBack = callBack
    }
    var body: some View {
        VStack {
            HStack {
                Text(verbatim: "YourAddress".localized)
                    .font(Fonts.smallRegular())
                    .foregroundColor(Color.black)
                Spacer()
                Text(verbatim: FontAwesome.arrowDownIcon)
                    .font(Fonts.fontAwesome15_20())
                    .foregroundColor(appBlueColor)
            }
            ZStack(alignment: .center) {
//                AppleStaticMapView(mapRegion: region, showsUserLocation: false)
                GoogleStaticMapView(coordinate: region.center)
                    .frame(maxWidth: .infinity)
                    .frame(height:150)
                    .cornerRadius(10)
                    .colorScheme(.light)
                    .disabled(true)
                    .id(mapId)
                Image("locationpin")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imgPinWid,height: imgPinWid)
            }
            HStack {
                Text(verbatim: address)
                    .font(Fonts.smallRegular())
                    .foregroundColor(Color.black)
                Spacer()
                ColoredText(text: "Change".localized)
                    .font(Fonts.smallRegular())
                    .foregroundColor(Color.black)
                    .padding(.leading,3)
                    .onTapGesture {
                        callBack?()
                    }
            }
            .padding(.top,10)
        }
        .padding(20)
        .modifier(BackgroundModifer()) 
        .padding(.top,10) 
    }
}
