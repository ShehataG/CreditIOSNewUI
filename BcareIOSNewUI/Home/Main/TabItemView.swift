//
//  TabItemView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct TabItemView: View {
    var text:String
    let icon:String
    let tag:Int
    @Binding var selectedIndex:Int
    let imgWidth:CGFloat = isIpad ? 35 : 25
    var body: some View {
        VStack(spacing:0) {
            if selectedIndex == tag {
                Image(icon)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imgWidth, height: imgWidth)
                    .foregroundColor(appBlueColor)
                ColoredText(text:text.localized)
                    .font(Fonts.tooSmallRegular())
                    .padding(.top,3)
            }
            else {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imgWidth, height: imgWidth)
                GrayText(text:text.localized)
                    .font(Fonts.tooSmallRegular())
                    .padding(.top,3)
            }
        }
        .padding(.vertical,10)
        .onTapGesture {
            selectedIndex = tag
        }
    }
}
