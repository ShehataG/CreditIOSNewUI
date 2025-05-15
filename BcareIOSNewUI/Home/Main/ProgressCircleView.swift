//
//  HomeStatusCell.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct ProgressCircleView: View {
    var progress: Double
    let imgWid:CGFloat = isIpad ? 70 : 50
    var body: some View {
        ZStack {
            Circle()
                .stroke(appGreenColor.opacity(0.2), lineWidth: 5)
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    AngularGradient(gradient: Gradient(colors: [appGreenColor]),
                                    center: .center),
                    style: StrokeStyle(lineWidth: 5, lineCap: .round)
                )
                .rotationEffect(.degrees(isAr ? 90 : -90))
                .animation(.easeInOut, value: progress)
            ColoredGreenText(text:"\(Int(progress * 100))%")
                .font(Fonts.verySmallBold())
        }
        .frame(width: imgWid, height: imgWid)
    }
}
