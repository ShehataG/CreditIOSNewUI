//
//  VehicleScanView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct VehicleScanView: View {
    let title:String
    let imgWid:CGFloat = isIpad ? 30 : 20
    var body: some View {
        HStack {
            Image("barcode")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imgWid,height: imgWid)
            ColoredText(text: title.localized)
                .font(Fonts.smallRegular())
                .padding(.horizontal,5)
        }
        .padding(.vertical,12)
        .frame(maxWidth: .infinity)
        .cornerRadiusWithBorder(radius: 5, borderLineWidth: 2, borderColor: appBlueColor)
        .padding(.vertical,30)
    }
}
