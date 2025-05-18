//
//  PersonalView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SVGKit


struct PersonalView: View {
    @EnvironmentObject var coordinator: Coordinator
 
    var body: some View {
        VStack {
            VStack(spacing:0) {
                ZStack(alignment: .top) {
                    Image("personalmain")
                        .resizable()
                        .frame(height: screenHeight * 0.6)
                        .aspectRatio(contentMode: .fill)
                    VStack {
                        HStack {
                            BackButton(color: Color.white)
                            Spacer()
                        }
                        .padding(.top,50)
                    }
                }
                .frame(height: screenHeight * 0.6)
                VStack(spacing:40) {
                    ColoredText(text:"Vehicle".localized.linesToSpaces)
                        .font(Fonts.largeBold())
                    ColoredText(text:"PersonalDesc".localized)
                        .font(Fonts.mediumRegular())
                        .multilineTextAlignment(.center)
                    RoundedColoredText(text:"ApplyNow") 
                        .onTapGesture {
                            coordinator.push(Destination.personallnfoPage)
                        }
                }
                .padding(.horizontal,20)
                .padding(.top,20)
            }
        }
        .background(Color.lightGray3)
        .navigationBarBackButtonHidden()
        .edgesIgnoringSafeArea(.top)
    }
}
