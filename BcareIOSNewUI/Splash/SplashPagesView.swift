//
//  SplashPagesView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//


import Foundation
import SwiftUI

struct SplashPagesView: View {
    @EnvironmentObject var coordinator: Coordinator
    let items = [
        SplashItem(image: "welcome", title: "WelcomeBoard".localized, desc: "WelcomeBoardDesc".localized),
        SplashItem(image: "speed", title: "Speed".localized, desc: "SpeedDesc".localized),
        SplashItem(image: "number", title: "Number".localized, desc: "NumberDesc".localized)
    ]
    let dotSize:CGFloat = 6
    let dotSelectedSize:CGFloat = 12
    @State var selection = 0
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                PageView(selection: $selection) {
                    ForEach(0..<3, id: \.self) { row in
                        SplashPageView(item: items[row])
                            .tag(row)
                            .frame(width: screenWidth - 30,height: screenHeight * 0.65)
                    }
                }
                  .frame(width: screenWidth,height: screenHeight * 0.65)
                HStack(spacing:7) {
                    ForEach(Array(0..<3),id:\.self) { row in
                        if row == selection {
                            Circle()
                                .fill(appGreenColor)
                                .frame(width:dotSelectedSize,height:dotSelectedSize)
                        }
                        else {
                            Circle()
                                .fill(Color.lightGray)
                                .frame(width:dotSize,height:dotSize)
                        }
                    }
                }
            }
            RoundedColoredBu(item: selection == 2 ? "StartNow" : "Next", width: 0.35)
                .onTapGesture {
                    let value = selection + 1
                    if  value <= 2 {
                        selection = value
                    }
                    else {
                        // Go to main app
                        goToHome()
                    }
                }
            GrayText(text: "Skip".localized)
                .font(Fonts.mediumRegular())
                .padding(.top ,20)
                .onTapGesture {
                    goToHome()
                }
           Spacer()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.white)
        .navigationBarBackButtonHidden()
    }
    func goToHome()  {
        splashPagesShowed = true
        // Go to main app
        coordinator.goToRoot()
    }
}
