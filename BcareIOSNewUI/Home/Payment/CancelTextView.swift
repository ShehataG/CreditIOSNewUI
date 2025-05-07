//
//  CancelTextView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct CancelTextView: View {
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        ColoredText(text:"Cancel".localized)
            .font(Fonts.smallSemiBold())
            .onTapGesture {
                coordinator.goToRoot()
            }
    }
}
