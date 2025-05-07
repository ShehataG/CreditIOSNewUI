//
//  BookGridView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct BookGridView: View {
    var item:AvailableDaysItem
    let isSelected:Bool
    let textWidth:CGFloat = isIpad ? 50 : 40
    var body: some View {
        let result = item.date.dateDayNum
        if isSelected {
            VStack(spacing: 10) {
                GrayText(text:result.0)
                    .font(Fonts.tooSmallLight())
                Text(verbatim:result.1)
                    .font(Fonts.tooSmallBold())
                    .foregroundColor(Color.white)
                    .frame(width: textWidth,height: textWidth)
                    .background(appBlueColor)
                    .clipShape(Circle())
            }
            .frame(maxWidth: .infinity)
        }
        else {
            VStack(spacing: 10) {
                GrayText(text:result.0)
                    .font(Fonts.tooSmallLight())
                Text(verbatim:result.1)
                    .font(Fonts.tooSmallBold())
                    .foregroundColor(Color.black)
                    .frame(width: textWidth,height: textWidth)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
