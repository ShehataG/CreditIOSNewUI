//
//  MojazGridView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct MojazGridView: View {
    var text:String
    let icon:String
    let imgWid:CGFloat = isIpad ? 45.0 : 30.0
    var body: some View {
        VStack(spacing:10) {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imgWid, height: imgWid)
            Text(text.localized)
                .font(Fonts.verySmallRegular())
                .foregroundColor(Color.black)
        }
    }
}
