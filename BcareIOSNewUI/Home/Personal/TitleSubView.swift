//
//  TitleSubView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct TitleSubView: View {
    let item:CompareItem
    var body: some View {
        VStack(alignment:.center,spacing:10) {
            Text(verbatim: item.title.localized)
                .font(Fonts.verySmallLight())
                .foregroundColor(Color(hex:"#4F3366")!)
                .multilineTextAlignment(.center)
            Text(verbatim: item.subTitle)
                .font(Fonts.verySmallLight())
                .foregroundColor(Color.lightGray)
                .multilineTextAlignment(.center)
        }
    }
}
