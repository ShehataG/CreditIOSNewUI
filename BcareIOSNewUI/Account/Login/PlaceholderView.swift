//
//  PlaceholderView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        VStack {
        }
        .frame(maxWidth: .infinity,maxHeight:.infinity)
        .background(Color(hex:"#303030")!.opacity(0.5))
    }
}

struct BackPlaceholderView: View {
    let factor:CGFloat
    var body: some View {
        VStack {
        }
        .frame(height:screenHeight * factor)
        .frame(maxWidth: .infinity)
        .background(appBlueColor)
    }
}
