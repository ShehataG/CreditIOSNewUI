//
//  PolicyCardView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI
import SVGKit
import WebKit

struct PolicyCardView: View {
    @EnvironmentObject var coordinator: Coordinator
    let item:PoliciesResult
    let showExpire:Bool
    let showLoading:Bool
    let insursArr = ["VehicleInsurance".localized , "MedicalInsurance".localized,"TravelInsurance".localized , "MMInsurance".localized]
    init(item: PoliciesResult, showExpire:Bool = true, showLoading:Bool = false) {
        self.item = item
        self.showExpire = showExpire
        self.showLoading = showLoading
    }
    let imgHei:CGFloat = isIpad ? 270.0 : 220.0
    let imgSmallWid:CGFloat = isIpad ? 80.0 : 60.0
    var body: some View {
        ZStack(alignment: .top) {
            Image("card")
                .resizable()
                .frame(maxWidth:.infinity)
                .frame(height: imgHei)
                .cornerRadius(20)
            VStack(spacing:0) {
                HStack {
                    HStack {
                        Circle().fill(appOrangeColor)
                            .frame(width:10,height:10)
                        Text(verbatim:insursArr[item.productID - 1])
                            .font(Fonts.verySmallRegular())
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                    if let img = SVGKImage(named:item.insuranceCompanyKey)?.uiImage {
                        Image(uiImage: img)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:imgSmallWid,height:imgSmallWid)
                    }
                }
                .padding(.horizontal,15)
                if item.productID == 1  {
                    HStack {
                        Text(verbatim: item.productType())
                            .font(Fonts.smallMedium())
                            .foregroundColor(Color.white)
                            .padding(.vertical,1)
                            .padding(.horizontal,10)
                            .background(Capsule().fill(appOrangeColor))
                            .padding(.horizontal,10)
                        Spacer()
                    }
                    .padding(.horizontal,10)
                }
                Spacer()
                HStack {
                    Text(verbatim:item.name() ?? "")
                        .font(Fonts.smallRegular())
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .padding(.horizontal,15)
                .padding(.bottom,10)
                if let cName = item.employeeCompanyName { // Show company name for medical only
                    HStack {
                        Text(verbatim:cName)
                            .font(Fonts.tooSmallRegular())
                            .foregroundColor(Color.white)
                            .padding(.top,1)
                        Spacer()
                    }
                    .padding(.horizontal,15)
                    .padding(.bottom,10)
                }
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(verbatim:"NationalIdentity".localized)
                                .font(Fonts.tooSmallRegular())
                                .foregroundColor(Color.white)
                            Text(verbatim:item.nationalID)
                                .font(Fonts.tooSmallRegular())
                                .foregroundColor(Color.white)
                                .padding(.top,1)
                        }
                        HStack {
                            Text(verbatim:"PolicyNo".localized)
                                .font(Fonts.tooSmallRegular())
                                .foregroundColor(Color.white)
                            Text(verbatim:item.policyNo)
                                .font(Fonts.tooSmallRegular())
                                .foregroundColor(Color.white)
                                .padding(.top,1)
                        }
                        if let plateInfo = item.plate() {
                            HStack {
                                Text(verbatim:"VehiclePlate".localized)
                                    .font(Fonts.tooSmallRegular())
                                    .foregroundColor(Color.white)
                                Text(verbatim:plateInfo)
                                    .font(Fonts.tooSmallRegular())
                                    .foregroundColor(Color.white)
                                    .padding(.top,1)
                            }
                        }
                    }
                    Spacer()
                    HStack {
                        VStack(alignment: .leading) {
                            if let model = item.model() {
                                HStack {
                                    Text(verbatim:"VehicleM".localized)
                                        .font(Fonts.tooSmallRegular())
                                        .foregroundColor(Color.white)
                                    Text(verbatim:model)
                                        .font(Fonts.tooSmallRegular())
                                        .foregroundColor(Color.white)
                                        .padding(.top,1)
                                }
                            }
                            HStack {
                                Text(verbatim:"EndsWithin".localized)
                                    .font(Fonts.tooSmallRegular())
                                    .foregroundColor(Color.lightGrayMid)
                                Text(verbatim:item.policyExpiryDate.substring(to: 10))
                                    .font(Fonts.tooSmallRegular())
                                    .foregroundColor(Color.white)
                                    .padding(.top,1)
                            }
                        }
                    }
                }
                .padding(.horizontal,15)
                .padding(.bottom,20)
            }
            if item.productID == 1 || item.productID == 4 { // Motor or MM
                if item.closeToExpiration() {
                    let days = item.diffDays()
                    VStack(spacing:0) {
                        HStack {
                            Spacer()
                            VStack(spacing:0) {
                                ZStack(alignment: .center) {
                                    Image("bcircle")
                                        .resizable()
                                        .frame(maxWidth:.infinity)
                                        .frame(width: 70,height: 70)
                                    Text(verbatim:"Remaining".localized + "\n" + days.toString() + "\n" + "Day".localized)
                                        .font(Fonts.tooSmallRegular())
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.center)
                                }
                                 Text(verbatim: "RenewPolicy".localized)
                                    .font(Fonts.smallMedium())
                                    .foregroundColor(Color.white)
                                    .padding(.vertical,1)
                                    .padding(.horizontal,10)
                                    .background(Capsule().fill(appOrangeColor))
                                    .padding(.horizontal,10)
                                    .padding(.top,5)
                                    .opacity(showExpire ? 1.0 : 0.0)
                             }
                        }
                        .padding(.top,imgSmallWid)
                        Spacer()
                    }
                    .frame(maxWidth:.infinity)
                    .frame(height: imgHei)
                }
            }
            if showLoading {
                LoadingView(color: .white)
                    .padding(.bottom,5)
            }
        }
        .frame(height: imgHei)
        .padding(.horizontal,20)
        .frame(maxWidth: .infinity)
    }
}
