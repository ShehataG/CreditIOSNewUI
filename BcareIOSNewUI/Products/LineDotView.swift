//
//  LineDotView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct LineDotView: View {
    var title:String
    var body: some View {
        HStack {
            Circle().fill(appOrangeColor)
                .frame(width:10,height:10)
            ColoredText(text:title.localized)
                .font(Fonts.mediumSemiBold())
                .padding(.horizontal,5)
                .background(
                    appBlueColor.opacity(0.24)
                       .frame(height: 1)
                       .offset(y: 20)
                )
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(20)
    }
}
