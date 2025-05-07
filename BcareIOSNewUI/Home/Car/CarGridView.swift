//
//  CarGridView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
 
struct CarGridView: View {
    let item:GridDatum
    var body: some View {
        VStack {
            VStack {
                Spacer()
                Text(item.title)
                    .font(Fonts.verySmallBold())
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(5)
                Spacer()
            }
            .frame(height: 60)
            Text(item.subtitle)
                .font(Fonts.verySmallLight())
                .foregroundColor(Color.black)
                .padding(.horizontal,10)
                .padding(.vertical,30)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(6)
            Spacer()
         }
        .frame(width: screenWidth * 0.35)
        .background(Color.white)
        .cornerRadius(15)
    }
}
