//
//  ManualVinBu.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct ManualVinBu: View {
    let title:String
    let textColor:Color
    let isSelected:Bool
    var body: some View {
        if isSelected {
            Text(verbatim: title.localized)
                .font(Fonts.smallRegular())
                .foregroundColor(.white)
                .padding(.vertical,15)
                .padding(.horizontal,20)
                .frame(maxWidth: .infinity)
                .background(appBlueColor)
                .cornerRadius(10)
        }
        else {
            Text(verbatim: title.localized)
                .font(Fonts.smallRegular())
                .foregroundColor(appBlueColor)
                .padding(.vertical,15)
                .padding(.horizontal,20)
                .frame(maxWidth: .infinity)
        }
    }
}
