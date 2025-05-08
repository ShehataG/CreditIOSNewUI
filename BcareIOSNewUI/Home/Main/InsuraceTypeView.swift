//
//  InsuraceTypeView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct InsuraceTypeView: View {
    var text:String
    let icon:String
    let lines:Int
    init(text: String, icon: String, lines:Int = 2) {
        self.text = text
        self.icon = icon
        self.lines = lines
    }
    let imgWid:CGFloat = isIpad ? 70.0 : 50.0
    var body: some View {
        VStack(spacing:0) {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imgWid, height: imgWid)
            GrayText(text:text.localized)
                .font(Fonts.tooSmallBold())
                .padding(.top,10)
                .multilineTextAlignment(.center)
                .lineLimit(lines)
        }
    }
}
