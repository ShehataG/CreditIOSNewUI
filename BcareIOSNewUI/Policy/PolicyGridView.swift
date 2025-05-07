//
//  PolicyGridView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct PolicyGridView: View {
    let title:String
    let image:String
    let imgWid:CGFloat = isIpad ? 30 : 20
    let cardHeight:CGFloat = isIpad ? 80 : 60
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imgWid,height: imgWid)
                .padding(.horizontal,7)
            Text(verbatim: title.localized)
                .font(Fonts.tooSmallLight())
                .foregroundColor(appBlueColor)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: cardHeight)
        .background(Rectangle().fill(Color.white).cornerRadius(10.0).shadow(radius: 3,x: -3,y: 3))
    }
}
