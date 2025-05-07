//
//  RequestBottomBu.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct RequestBottomBu: View {
    let title:String
    let image:String
    let isSelected:Bool
    let imgWidth:CGFloat = isIpad ? 35.0 : 25.0
    var body: some View {
        if isSelected {
            HStack {
                Image(image + "on")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imgWidth,height: imgWidth)
                Text(verbatim: title.localized)
                    .font(Fonts.verySmallRegular())
                    .foregroundColor(appBlueColor)
                    .padding(.horizontal,5)
            }
            .padding(.vertical,15)
            .padding(.horizontal,20)
            .frame(maxWidth: .infinity)
            .background(Capsule().fill(Color.white))
        }
        else {
            HStack {
                Image(image + "off")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imgWidth,height: imgWidth)
                Text(verbatim: title.localized)
                    .font(Fonts.verySmallRegular())
                    .foregroundColor(.white)
                    .padding(.horizontal,5)
            }
            .padding(.vertical,15)
            .padding(.horizontal,20)
            .frame(maxWidth: .infinity)
            .background(Capsule().fill(appBlueColor))
        }
    }
}
