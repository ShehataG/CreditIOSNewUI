//
//  MojazInfoGrid.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct MojazInfoGrid: View {
    var title:String
    let subtitle:String
    var body: some View {
        VStack(spacing:10) {
            Text(title.localized)
                .font(Fonts.verySmallRegular())
                .foregroundColor(Color.black.opacity(0.5))
            Text(subtitle)
                .font(Fonts.verySmallRegular())
                .foregroundColor(Color.black)
        }
    }
}
