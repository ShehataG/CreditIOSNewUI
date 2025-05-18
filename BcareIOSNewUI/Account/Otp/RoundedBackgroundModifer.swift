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
    func body(content: Content) -> some View {
         content
            .background(color)
            .cornerRadius(30, corners: [.topLeft, .topRight])
//            .background {
//                UnevenRoundedRectangle(cornerRadii:.init(topLeading: 30.0,topTrailing: 30.0),style: .continuous)
//                    .foregroundColor(color)
//            }
       
    }
}

struct RoundedFullBackgroundModifer: ViewModifier {
    let color:Color
    func body(content: Content) -> some View {
         content
            .background(color)
            .cornerRadius(30)
       
    }
}
