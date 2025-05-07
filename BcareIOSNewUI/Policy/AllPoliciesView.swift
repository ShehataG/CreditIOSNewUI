//
//  AllPoliciesView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine
import MapKit

struct AllPoliciesView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var lottieLoading: LottieLoading
    @StateObject var homeVM = HomeVM()
    @StateObject var appleCardVM = AppleCardVM()
    let imgHei:CGFloat = isIpad ? 270.0 : 220.0
    var body: some View {
        VStack(spacing:0) {
            HeaderWithBackView(text:"YourPolicies".localized)
            let all = homeVM.policies
            List(all.indices,id:\.self) { row in
                let item = all[row]
                if item.productID == 2 {
                    PolicyMedCardView(item: item)
                        .frame(width: screenWidth,height: imgHei)
                        .padding(.top,10)
                        .tag(row)
                        .modifier(ListItemMode())
                        .onTapGesture {
                            if [1,2].contains(item.productID) {
                                coordinator.push(item)
                            }
                            else {
                                appleCardVM.getCard(item)
                            }
                        }
                }
                else {
                    PolicyCardView(item: item)
                        .frame(width: screenWidth,height: imgHei)
                        .padding(.top,10)
                        .tag(row)
                        .modifier(ListItemMode())
                        .onTapGesture {
                            if [1,2].contains(item.productID) {
                                coordinator.push(item)
                            }
                            else {
                                appleCardVM.getCard(item)
                            }
                        }
                }
                
            }
            .modifier(ListMode())
            
        }
        .onChange(of: appleCardVM.submitGetCard, perform: { newValue in
            lottieLoading.show = newValue
        })
        .sheet(isPresented: $appleCardVM.showPk){
            AddPassView(pass: $appleCardVM.pass)
                .colorScheme(.light)
        }
        .background(appBlueColor)
        .navigationBarBackButtonHidden()
    }
}
