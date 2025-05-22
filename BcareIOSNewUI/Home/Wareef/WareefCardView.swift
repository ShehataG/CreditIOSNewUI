//
//  WareefCardView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct WareefCardView: View {
    let showLoading:Bool
    let imgHei:CGFloat = isIpad ? 270.0 : 220.0
    let imgSmallWid:CGFloat = isIpad ? 90.0 : 70.0
    let expireDate:String
    var body: some View {
        ZStack(alignment: .top) {
            Image("card")
                .resizable()
                .frame(maxWidth:.infinity)
                .frame(height: imgHei)
                .cornerRadius(20)
            VStack(spacing: 0) {
                HStack(alignment: .top) {
                    Text(verbatim:"بي كير")
                        .font(Fonts.smallBold())
                        .foregroundColor(Color.white)
                    Spacer()
                    Image("crelogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imgSmallWid ,height: imgSmallWid * 29 / 71)
                }
                .padding(.top,30)
                .padding(.horizontal,15)
                HStack {
                    Text(verbatim:"WareefCard".localized)
                        .font(Fonts.smallMedium())
                        .foregroundColor(Color.white)
                        .padding(.vertical,1)
                        .padding(.horizontal,5)
                        .background(Capsule().fill(appOrangeColor))
                    Spacer()
                }
                .padding(.horizontal,15)
                Spacer()
                HStack {
                    Text(verbatim:UserManager.usernameFull() ?? "")
                        .font(Fonts.smallRegular())
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .padding(.horizontal,15)
                .padding(.bottom,10)
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading,spacing: 5) {
                        HStack {
                            Text(verbatim:"CustomerNumber".localized + " :")
                                .font(Fonts.verySmallRegular())
                                .foregroundColor(Color.white)
                            Text(verbatim:userNationalId ?? "")
                                .font(Fonts.verySmallBold())
                                .foregroundColor(Color.white)
                                .padding(.horizontal,5)
                        }
                        HStack {
                            Text(verbatim:"ExpiryDate".localized + " :")
                                .font(Fonts.verySmallRegular())
                                .foregroundColor(Color.white)
                            Text(verbatim:expireDate)
                                .font(Fonts.verySmallBold())
                                .foregroundColor(Color.white)
                                .padding(.horizontal,5)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal,15)
                .padding(.bottom,20)
            }
            if showLoading {
                LoadingView(color: .white)
                    .padding(.bottom,5)
            }
        }
        .frame(height: imgHei)
        .padding(.horizontal,20)
        .frame(maxWidth: .infinity)
        .padding(.top,10)
//        VStack { }
//            .foregroundColor(Color.clear)
//            .frame(width:6,height:6)
    } 
}
