//
//  PolicyMedCardView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI
import SVGKit

struct PolicyMedCardView: View {
    let item:PoliciesResult
    let showExpire:Bool
    let showLoading:Bool
    init(item: PoliciesResult,showExpire:Bool = true, showLoading:Bool = false) {
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
                        Text(verbatim:"Medical insurance")
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
                Spacer()
                HStack {
                    Text(verbatim:item.nameEn ?? "")
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
                            Text(verbatim:"Membership number")
                                .font(Fonts.tooSmallRegular())
                                .foregroundColor(Color.white)
                            Text(verbatim:item.memberShipId)
                                .font(Fonts.tooSmallRegular())
                                .foregroundColor(Color.white)
                                .padding(.top,1)
                        }
                        HStack {
                            Text(verbatim:"Policy number")
                                .font(Fonts.tooSmallRegular())
                                .foregroundColor(Color.white)
                            Text(verbatim:item.policyNo)
                                .font(Fonts.tooSmallRegular())
                                .foregroundColor(Color.white)
                                .padding(.top,1)
                        }
                    }
                    Spacer()
                    if let catClass = item.categoryClass {
                        VStack {
                            Text(verbatim:"Type")
                                .font(Fonts.tooSmallRegular())
                                .foregroundColor(Color.lightGrayMid)
                            Text(verbatim:catClass)
                                .font(Fonts.tooSmallRegular())
                                .foregroundColor(Color.white)
                                .padding(.top,1)
                        }
                        .padding(.horizontal,5)
                    }
                    VStack {
                        Text(verbatim:"Ends within")
                            .font(Fonts.tooSmallRegular())
                            .foregroundColor(Color.lightGrayMid)
                        Text(verbatim:item.policyExpiryDate.substring(to: 10))
                            .font(Fonts.tooSmallRegular())
                            .foregroundColor(Color.white)
                            .padding(.top,1)
                    }
                }
                .padding(.horizontal,15)
                .padding(.bottom,20)
                .environment(\.layoutDirection, .leftToRight)
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
