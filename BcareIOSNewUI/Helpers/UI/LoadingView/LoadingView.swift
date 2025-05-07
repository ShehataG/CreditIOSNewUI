//
//  LoadingView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/27/24.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    let color:Color
    init(color: Color = Color.lightGray) {
        self.color = color
    }
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .tint(color)
            Spacer()
        }
    }
}

struct LoadingOnlyView: View {
    let color:Color
    init(color: Color = Color.lightGray) {
        self.color = color
    }
    var body: some View {
        ProgressView()
            .tint(color)
    }
}
