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
                    .font(Fonts.veryLargeBold())
                    .foregroundColor(Color.white)
                    .padding(.horizontal,10)
                Text(verbatim:"OnePlace".localized)
                    .font(Fonts.smallLight())
                    .foregroundColor(Color.white.opacity(0.7))
//                    .frame(width: screenWidth * 0.6)
                    .padding(.horizontal,20)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: true, vertical: false)
            }
//            .frame(width: screenWidth * 0.6)
            Spacer()
        }
        .padding(.horizontal,20)
        .padding(.vertical,20)
    }
}
