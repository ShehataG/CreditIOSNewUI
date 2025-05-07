//
//  WareefCodeView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct WareefCodeView: View {
    let text:String
    var body: some View {
        Text(verbatim: text.localized)
            .font(Fonts.smallRegular())
            .foregroundColor(Color.black)
            .padding(.horizontal,20)
            .padding(.vertical,15)
            .frame(width: screenWidth * 0.5)
            .background(Color.lightGrayMid)
            .cornerRadius(10)
            .padding(.top,10)
            .padding(.bottom,20)
    }
}
