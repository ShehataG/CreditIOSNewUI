//
//  ProfileRoundedView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct ProfileRoundedView: View {
    let text:String
    var body: some View {
        Text(verbatim: text.localized)
            .font(Fonts.smallLight())
            .foregroundColor(.black)
            .padding(.horizontal,10)
            .frame(maxHeight: .infinity)
            .background(Color.lightGrayMid)
            .cornerRadius(10.0)
    }
}
