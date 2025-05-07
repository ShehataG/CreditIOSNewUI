//
//  PureProgressView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 7/28/24.
//

import Foundation
import SwiftUI

struct PureProgressView: View {
    let color:Color
    init(color: Color = Color.lightGray) {
        self.color = color
    }
    var body: some View {
        ProgressView()
            .tint(color)
    }
}
