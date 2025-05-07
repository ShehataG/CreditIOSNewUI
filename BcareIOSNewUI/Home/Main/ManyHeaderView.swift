//
//  VehiclesGeneralView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SanarKit

struct ManyHeaderView: View {
     var body: some View {
        HStack {
            VStack(alignment: .leading,spacing:10) {
                Text(verbatim:"CompareInsur".localized)
                    .font(Fonts.mediumRegular())
                    .foregroundColor(Color.white)
                    .padding(.horizontal,10)
                Text(verbatim:"OnePlace".localized)
                    .font(Fonts.verySmallLight())
                    .foregroundColor(Color.white.opacity(0.7))
                    .frame(width: screenWidth * 0.6)
                    .padding(.horizontal,15)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: true, vertical: false)
            }
            .frame(width: screenWidth * 0.6)
            Spacer()
            Image("many")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90,height: 90)
        }
        .padding(.horizontal,20)
        .padding(.top,10)
    }
}
