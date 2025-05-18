//
//  PersonalCompareView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SVGKit


struct PersonalCompareView: View {
    @EnvironmentObject var coordinator: Coordinator
 
    var body: some View {
        VStack {
            VStack(spacing:0) {
                ZStack(alignment: .top) {
                    Image("personalmain")
                        .resizable()
                        .frame(height: screenHeight * 0.5)
                        .aspectRatio(contentMode: .fill)
                    VStack {
                        HStack {
                            BackButton(color: Color.black)
                            Spacer()
                        }
                        .padding(.top,50)
                    }
                }
                .frame(height: screenHeight * 0.5)
                VStack(spacing:20) {
                    ColoredText(text:"Vehicle".localized.linesToSpaces)
                        .font(Fonts.largeBold())
                    ColoredText(text:"PersonalDesc".localized)
                        .font(Fonts.mediumRegular())
                        .multilineTextAlignment(.center)
                    Text(verbatim:"ApplyNow".localized)
                        .font(Fonts.smallRegular())
                        .foregroundStyle(Color.white)
                        .padding(.vertical,5)
                        .padding(.horizontal,10)
                        .background(appBlueColor)
                        .clipShape(Capsule())
                }
                .padding(.horizontal,20)
                .padding(.top,20)
                Spacer()
            }
        }
        .background(Color.lightGray3)
        .navigationBarBackButtonHidden()
        .edgesIgnoringSafeArea(.top)
    }
}
