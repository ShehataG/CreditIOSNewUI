//
//  PaymentSuccessView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct PaymentSuccessView: View {
    @EnvironmentObject var coordinator: Coordinator
    let imgWid:CGFloat = isIpad ? 150.0 : 130.0
    let imgWidLine:CGFloat = isIpad ? 70.0 : 60.0
    let showBookings:Bool
    var showBookingsCallback:(()->())?
    init(showBookings: Bool=false, showBookingsCallback: (() -> ())? = nil) {
        self.showBookings = showBookings
        self.showBookingsCallback = showBookingsCallback
    }
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            Image("paymentsuccess")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imgWid, height: imgWid)
                .padding(.top,30)
            Text(verbatim: "PaymentDone".localized)
                .font(Fonts.veryLargeRegular())
                .foregroundColor(appBlueColor.opacity(0.8))
                .padding(.top,30)
            ColoredText(text: "ThanksForBcare".localized)
                .font(Fonts.largeBold())
                .background(
                    HStack {
                        Spacer()
                        Image("bcareline")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imgWidLine, height: imgWidLine * 22 / 118)
                    }
                   .offset(y: 25)
                )
            Spacer()
            HStack(spacing: 15) {
                if showBookings {
                    ColoredText(text: "ReturnToBookings".localized)
                        .font(Fonts.verySmallRegular())
                        .padding(.vertical,15)
                        .frame(width: screenWidth * 0.45)
                        .background(Color.lightGrayMore)
                        .cornerRadius(20)
                        .onTapGesture {
                            showBookingsCallback?()
                        }
                }
                Text(verbatim: "ReturnToHome".localized)
                    .font(Fonts.verySmallRegular())
                    .foregroundColor(Color.white)
                    .padding(.vertical,15)
                    .frame(width: screenWidth * 0.45)
                    .background(appBlueColor)
                    .cornerRadius(20)
                    .onTapGesture {
                        coordinator.goToRoot()
                    }
            }
            .padding(.bottom,80)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.white)
    }
}
