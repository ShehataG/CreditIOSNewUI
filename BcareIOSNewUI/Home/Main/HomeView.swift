//
//  Home.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SwiftUIPager
import SanarKit
import SiriusRating

struct HomeView: View {
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.5)
            ScrollView(showsIndicators: false) {
                SharedHeaderView()
                VStack(spacing:0) {
                    VStack(spacing:0) {
                        HStack(alignment: .top) {
                            InsuraceTypeView(text: "Vehicle", icon: "vehicle")
                                .frame(maxWidth: .infinity)
                                .onTapGesture {
                                    coordinator.push(TermsPrivacyItem(url: createGl(InsuranceType.vehicle)))
                                }
                            InsuraceTypeView(text: "Medical", icon: "medical")
                                .frame(maxWidth: .infinity)
                                .onTapGesture {
                                    coordinator.push(TermsPrivacyItem(url: createGl(InsuranceType.medical)))
                                }
                            InsuraceTypeView(text: "Travel", icon: "travel")
                                .frame(maxWidth: .infinity)
                                .onTapGesture {
                                    coordinator.push(TermsPrivacyItem(url: createGl(InsuranceType.travel)))
                                }
                            InsuraceTypeView(text: "Malpractices", icon: "malpractices")
                                .frame(maxWidth: .infinity)
                                .onTapGesture {
                                    coordinator.push(TermsPrivacyItem(url: createGl(InsuranceType.malpractices)))
                                }
                        }
                        .frame(width: screenWidth * 0.9)
                        .padding(.top,10)
                        AdsView()
                        VehMedGeneralView()
                    }
                    .padding(.horizontal,10)
                }
                .padding(.top,10)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayCommon))
            }
            //.scrollIndicators(.never)
        }
        .background(Color.lightGrayCommon)
        .onFirstAppear {
            if let userInfo = sanarUserInfo {
                NotificationCenter.default.post(name: .sanarConsultNotification,object: nil,userInfo: userInfo)
                sanarUserInfo = nil
            }
        }
    }
}
