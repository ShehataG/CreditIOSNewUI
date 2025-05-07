//
//  PaymentDontCloseView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct PaymentDontCloseView: View {
    var body: some View {
        HStack(alignment: .center) {
            FAText(text: FontAwesome.warningIcon,color: Color(hex:"#ffcc00")!)
            Text(verbatim: "PleaseDontClose".localized)
                .font(Fonts.verySmallBold())
        }
        .padding(.vertical,15)
    }
}
