//
//  PersonalRingView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct PersonalRingView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var personalRingVM = PersonalRingVM()
//    let item:CompareContainerItem
    let imgWid:CGFloat = isIpad ? 350 : 250
    let name = "شحاته"
    let bank = "البلاد"
    var body: some View {
        VStack {
            HStack {
                BackButton(color: Color.black)
                Spacer()
            }
            Spacer()
            VStack(spacing:0) {
                VStack(spacing:0) {
                    Image("ring")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imgWid,height: imgWid)
                    VStack {
                        HStack(spacing: 0) {
                            ColoredText(text: "WelcomeB".localized)
                                .font(Fonts.mediumBold())
                                .padding(.horizontal,5)
                            ColoredGreenText(text: name)
                                .font(Fonts.mediumBold())
                        }
                        ColoredText(text: String(format: "YourPersonaApplication".localized, bank))
                            .font(Fonts.mediumBold())
                            .multilineTextAlignment(.center)
                    }
                    .padding(.vertical,40)
                }
                .padding(.horizontal,20)
                .padding(.top,20)
//                .modifier(RoundedFullBackgroundModifer(color: .white,radius: 20))
                .modifier(BackgroundModifer(radius: 20))
                RoundedColoredText(text:"Done")
                    .padding(.vertical,40)
                    .onTapGesture {
                        coordinator.goToRoot()
                    }
            }
            .padding(.horizontal,20)
            Spacer()
        }
        .background(Color.lightGray3)
        .navigationBarBackButtonHidden()
//        .edgesIgnoringSafeArea(.top)
    }
}
