//
//  SplashPageView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//


import Foundation
import SwiftUI
 
struct SplashPageView: View {
    let item:SplashItem
    var body: some View {
        VStack {
            VStack{
                Image(item.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:screenWidth * 0.75)
                    .frame(height: 200)
            }
            .frame(height: screenHeight * 0.65 / 2)
            VStack {
                if isAr {
                    let all = item.title.components(separatedBy: " ")
                    let first = all.first!
                    let second = all[1]
                    let third = all[2...].joined(separator: " ")
                    HStack(spacing: 0) {
                        ColoredText(text: first)
                            .font(Fonts.largeLight())
                            .padding(.horizontal ,3)
                        ColoredGreenText(text: second)
                            .font(Fonts.largeBold())
                        ColoredText(text: third)
                            .font(Fonts.largeLight())
                            .padding(.horizontal ,3)
                    }
                    .padding(.top ,50)
                }
                else {
                    ColoredText(text: item.title)
                        .font(Fonts.largeLight())
                        .padding(.top ,50)
                }
                GrayText(text:item.desc)
                    .font(Fonts.verySmallLight())
                    .padding(.top ,5)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            .frame(height: screenHeight * 0.65 / 2)
        }
    }
}
