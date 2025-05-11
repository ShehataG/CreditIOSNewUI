//
//  RoundedImage.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//


import Foundation
import SwiftUI
import SwiftUIPager

struct CreditMainLogo: View {
    let imgWid:CGFloat = isIpad ? 80 : 60
    var body: some View {
        HStack {
            Spacer()
            Image("crelogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imgWid,height: imgWid)
        }
        .padding(.horizontal,20)
    }
}
