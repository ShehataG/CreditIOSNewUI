//
//  PolicyMedicalView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine
import MapKit

struct PolicyMedicalView: View {
    @EnvironmentObject var coordinator: Coordinator
    let gridRows:[GridItem] = [GridItem(.flexible())]
    @StateObject var appleCardVM = AppleCardVM()
    @EnvironmentObject var lottieLoading: LottieLoading
    let item:PoliciesResult

    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.3)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    VStack(spacing:0) {
                        HeaderWithBackView(text:"MedicalPolicy".localized)
                        MainCardView(items:[item]) { item in
                           lottieLoading.show = true
                           appleCardVM.getCard(item)
                        }
                        .environmentObject(lottieLoading)
                        .padding(.bottom,10)
                        Spacer()
                    }
                    .background(appBlueColor)
                    VStack(spacing: 0) {
                        ZStack(alignment: .topLeading) {
                            VStack {
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height:40)
                            .background(appBlueColor)
                            VStack {
                                HStack {
                                    PolicyGridView(title: "PolicyDetails", image: "pdetails")
                                        .frame(width: screenWidth * 0.5)
                                        .onTapGesture {
                                            coordinator.push(PolicyDetailsSentItem(item : item))
                                        }
                                    Spacer()
//                                    PolicyGridView(title: "PolicyBenefits", image: "pbenefits")
                                }
                                .padding(.top,10)
//                                HStack {
//                                    PolicyGridView(title: "HealthServiceProviders", image: "pin")
//                                        .onTapGesture {
//                                            coordinator.push(Destination.medicalProvidersPage)
//                                        }
//                                    PolicyGridView(title: "PolicyUses", image: "puses")
//                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal,20)
                        }
                        VStack {
                            MedicalGeneralView(topHeader: 35)
                        }
                        .padding(.horizontal,10)
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background(Color.lightGrayMore)
                }
            }
            //.scrollIndicators(.never)
        }
        .background(Color.lightGrayMore)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
        .onChange(of: appleCardVM.submitGetCard, perform: { newValue in
            lottieLoading.show = newValue
        })
        .sheet(isPresented: $appleCardVM.showPk){
            AddPassView(pass: $appleCardVM.pass)
                .colorScheme(.light)
         }
    }
}
