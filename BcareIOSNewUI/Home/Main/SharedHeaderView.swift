//
//  VehiclesGeneralView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SanarKit

struct SharedHeaderView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var homeVM:HomeVM
    @EnvironmentObject var lottieLoading: LottieLoading
    @StateObject var appleCardVM = AppleCardVM()

    var body: some View {
        VStack(spacing:0) {
            TopHeaderView()
            if homeVM.policies.count != 0 {
                MainCardView(items:homeVM.policies) { item in
                    if [1,2].contains(item.productID) {
                        coordinator.push(item)
                    }
                    else {
                        appleCardVM.getCard(item)
                    }
                }
                .environmentObject(lottieLoading)
            }
            else {
                ManyHeaderView()
            }
        }
        .onChange(of: appleCardVM.submitGetCard, perform: { newValue in
            lottieLoading.show = newValue
        })
        .sheet(isPresented: $appleCardVM.showPk){
            AddPassView(pass: $appleCardVM.pass)
                .colorScheme(.light)
        }
    }
}
