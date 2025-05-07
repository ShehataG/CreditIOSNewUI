//
//  BookingGrid.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct BookingGrid: View {
    let title:String
    let desc:String
    let descColor:Color
    init(title: String, desc: String, descColor: Color = Color.black) {
        self.title = title
        self.desc = desc
        self.descColor = descColor
    }
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                GrayText(text: title.localized)
                    .font(Fonts.smallLight())
                Text(verbatim: desc)
                    .font(Fonts.tooSmallBold())
                    .foregroundColor(descColor)
                    .padding(.top,5)
            }
            Spacer()
        }
        .padding(.vertical,5)
    }
}
