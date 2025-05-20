//
//  RoundedBackgroundModifer.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct RoundedBackgroundModifer: ViewModifier {
    let color:Color
    let radius:CGFloat
    init(color: Color, radius: CGFloat = 30) {
        self.color = color
        self.radius = radius
    }
    func body(content: Content) -> some View {
         content
            .background(color)
            .cornerRadius(radius, corners: [.topLeft, .topRight])
//            .background {
//                UnevenRoundedRectangle(cornerRadii:.init(topLeading: 30.0,topTrailing: 30.0),style: .continuous)
//                    .foregroundColor(color)
//            }
       
    }
}

struct RoundedFullBackgroundModifer: ViewModifier {
    let color:Color
    let radius:CGFloat
    init(color: Color, radius: CGFloat = 30) {
        self.color = color
        self.radius = radius
    }
    func body(content: Content) -> some View {
         content
            .background(color)
            .cornerRadius(radius)
       
    }
}
