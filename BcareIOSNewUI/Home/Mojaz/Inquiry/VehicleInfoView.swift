//
//  VehicleInfoView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct VehicleInfoView: View {
    let imgWid:CGFloat = isIpad ? 40 : 30
    let imgBigWid:CGFloat = isIpad ? 180 : 130
    var closeCallback:(()->())?
    var vinCallback:(()->())?
    var istemaraCallback:(()->())?
      
    var body: some View {
        ZStack {
            PlaceholderView()
                .onTapGesture {
                    closeCallback?()
                }
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Image("closemojaz")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imgWid,height: imgWid)
                            .padding(.horizontal,3)
                            .onTapGesture {
                                closeCallback?()
                            }
                        Spacer()
                    }
                    Text(verbatim:"WhereToFindVehicle".localized)
                        .font(Fonts.mediumRegular())
                        .foregroundColor(Color.black)
                        .padding(.top,10)
                    //                HStack {
                    //                    ColoredText(text:"VehicleVinNumber".localized)
                    //                        .font(Fonts.smallRegular())
                    //                    Spacer()
                    //                }
                    //                .padding(.top,10)
                    //                HStack {
                    //                    VStack(alignment: .leading,spacing: 10) {
                    //                        GrayText(text:"BelowLeftFrontGlass".localized)
                    //                            .font(Fonts.smallRegular())
                    //                        GrayText(text:"InnerSideDriver".localized)
                    //                            .font(Fonts.smallRegular())
                    //                    }
                    //                    Spacer()
                    //                    Image("cartop")
                    //                        .resizable()
                    //                        .aspectRatio(contentMode: .fit)
                    //                        .frame(width: imgBigWid,height: imgBigWid * 83/109)
                    //                        .modifier(RotateModifier())
                    //                }
                    //                VehicleScanView(title: "ScanVin")
                    //                    .onTapGesture {
                    //                        vinCallback?()
                    //                    }
                    HStack {
                        ColoredText(text:"VehiclesIstemara".localized)
                            .font(Fonts.smallRegular())
                        Spacer()
                    }
                    .padding(.top,10)
                    
                    HStack(alignment: .bottom) {
                        GrayText(text:"VinNumberMojaz".localized)
                            .font(Fonts.smallRegular())
                        Image("istemara")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imgBigWid,height: imgBigWid * 76/158)
                            .modifier(RotateModifier())
                            .padding(.horizontal,30)
                        Spacer()
                    }
                    .padding(.bottom,20)
                    //                VehicleScanView(title: "ScanIstemaraBarcode")
                    //                    .padding(.bottom,20)
                    //                    .onTapGesture {
                    //                        istemaraCallback?()
                    //                    }
                }
                .padding(.vertical,10)
                .padding(.horizontal,20)
                .modifier(RoundedBackgroundModifer(color: Color.white))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
