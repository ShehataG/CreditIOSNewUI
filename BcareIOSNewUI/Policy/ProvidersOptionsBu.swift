//
//  ProvidersOptionsBu.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct ProvidersOptionsBu: View {
    let text:String
    let img:String
    let isSelected:Bool
    let imgWidth:CGFloat = isIpad ? 30.0 : 20.0
    var body: some View {
        if isSelected {
            HStack {
                Image(img)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: imgWidth,height: imgWidth)
                Text(verbatim: text.localized)
                    .font(Fonts.verySmallMedium())
                    .foregroundColor(.white)
                    .padding(.horizontal,5)
            }
            .padding(.vertical,10)
            .padding(.horizontal,5)
            .background(appBlueColor)
            .cornerRadius(10)
        }
        else {
            HStack {
                Image(img)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(appBlueColor)
                    .frame(width: imgWidth,height: imgWidth)
                Text(verbatim: text.localized)
                    .font(Fonts.verySmallMedium())
                    .foregroundColor(.black)
                    .padding(.horizontal,5)
            }
            .padding(.vertical,10)
            .padding(.horizontal,5)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}
