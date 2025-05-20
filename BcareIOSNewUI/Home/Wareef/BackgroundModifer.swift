//
//  BackgroundModifer.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI
 
struct BackgroundModifer: ViewModifier {
    let radius:CGFloat
    init(radius: CGFloat = 10) {
        self.radius = radius
    }
    func body(content: Content) -> some View {
        content
          .background(Rectangle().fill(Color.white).cornerRadius(radius).shadow(color:Color.black.opacity(0.1),radius: 3,x: 0,y: 5))
    }
}
            
