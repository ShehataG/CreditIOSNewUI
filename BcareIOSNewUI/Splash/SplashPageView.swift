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
                ColoredText(text: item.title)
                    .font(Fonts.largeLight())
                    .padding(.top ,50)
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
