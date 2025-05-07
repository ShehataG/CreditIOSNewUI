//
//  PlateView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct PlateView: View {
    var number:String
    let text:String
    let textWid:CGFloat = isIpad ? 55 : 45
    var body: some View {
        HStack(spacing:5) {
            Text(verbatim:number)
                .font(Fonts.smallRegular())
                .foregroundColor(Color.black)
                .lineLimit(1)
                .frame(width: textWid,alignment: .center)
            Divider().foregroundColor(Color.lightGray).frame(width: 1)
            Text(verbatim:text)
                .font(Fonts.smallRegular())
                .foregroundColor(Color.black)
                .lineLimit(1)
                .frame(width: textWid,alignment: .center)
         }
        .frame(maxWidth: .infinity)
    }
}
