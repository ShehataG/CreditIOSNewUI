//
//  VehiclesGeneralView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SanarKit

struct TopHeaderView: View {
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        HStack  {
            if UserManager.isLoggedIn() {
                HStack(spacing: 0) {
                    RoundedImage(name: "circleUser")
                    VStack(alignment: .leading,spacing: 2)  {
                        Text(verbatim:"Welcome".localized)
                            .font(Fonts.verySmallRegular())
                            .foregroundColor(Color.white)
                        Text(verbatim:UserManager.usernameFirst()!)
                            .font(Fonts.verySmallSemiBold())
                            .foregroundColor(Color.white)
                            .lineLimit(1)
                    }
                    .padding(.horizontal,5)
                }
                .onTapGesture {
                    NotificationCenter.default.post(name: .changeTabNotification, object: 4)
                }
            }
            else  {
                HStack(spacing: 0) {
                    RoundedImage(name: "circleUser")
                    Text(verbatim:"Login".localized)
                        .font(Fonts.tooSmallRegular())
                        .foregroundColor(Color.white)
                        .padding(.horizontal,5)
                }
                .onTapGesture {
                    coordinator.push(Destination.loginPage)
                }
            }
            Spacer()
            HStack(spacing:3) {
                RoundedImage(name: "circleLang")
                    .onTapGesture {
                        coordinator.changeLang()
                    }
            }
        }
        .padding(.horizontal,20)
    }
}
