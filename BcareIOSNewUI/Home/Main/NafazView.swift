//
//  NafazView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//


import Foundation
import SwiftUI

struct NafazView: View {
    let imgWid:CGFloat = isIpad ? 80 : 60
    var body: some View {
        HStack {
            Image("nafaz")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imgWid,height: imgWid)
            Text(verbatim:"ConfirmNafaz".localized)
                .font(Fonts.smallRegular())
                .foregroundColor(Color.black)
                .padding(.leading,10)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal,20)
        .padding(.vertical,10)
        .background(Color(hex: "#00B46D26")!)
        .cornerRadiusWithBorder(radius: 10, borderColor: Color(hex: "#12B46F")!)
        .padding(.bottom,20)
    }
}
