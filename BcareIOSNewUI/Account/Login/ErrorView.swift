//
//  ErrorView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    let text:String
    var body: some View {
        HStack {
            Text(verbatim: text)
                .font(Fonts.tooSmallRegular())
                .foregroundColor(.red)
            Spacer()
        }
        .padding(.horizontal,15)
    }
}
 
struct ErrorLocalizedView: View {
    let text:String
    var body: some View {
        HStack {
            Text(verbatim: text.localized)
                .font(Fonts.tooSmallRegular())
                .foregroundColor(.red)
            Spacer()
        }
        .padding(.horizontal,15)
    }
}
 
struct ErrorLocalizedCenterView: View {
    let text:String
    var body: some View {
        HStack {
            Spacer()
            Text(verbatim: text.localized)
                .font(Fonts.tooSmallRegular())
                .foregroundColor(.red)
            Spacer()
        }
        .padding(.horizontal,15)
    }
}
