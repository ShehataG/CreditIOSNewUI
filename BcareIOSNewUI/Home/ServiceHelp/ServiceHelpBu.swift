//
//  BookingGrid.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct ServiceHelpBu: View {
    let top: String
    let bottom: String
    let isSelected: Bool
    init(top: String, bottom: String, isSelected: Bool) {
        self.top = top
        self.bottom = bottom
        self.isSelected = isSelected
    }
    var body: some View {
        if (isSelected) {
            HStack {
                Spacer()
                FAText(text: FontAwesome.chatIcon, color: Color.lightGrayMid)
                    .padding(.horizontal,5)
                VStack(alignment: .leading) {
                    Text(verbatim: top)
                        .font(Fonts.verySmallLight())
                        .foregroundColor(Color.white)
                    Text(verbatim: bottom)
                        .font(Fonts.verySmallBold())
                        .foregroundColor(Color.white)
                }
                .padding(.vertical,5)
                Spacer()
            }
            .padding(5)
            .background(appBlueColor)
            .cornerRadius(10)
        }
        else {
            HStack(spacing: 10) {
                Spacer()
                FAText(text: FontAwesome.callIcon, color: Color.white)
                VStack(alignment: .leading) {
                    Text(verbatim: top)
                        .font(Fonts.verySmallLight())
                        .foregroundColor(Color.black)
                    Text(verbatim: bottom)
                        .font(Fonts.verySmallBold())
                        .foregroundColor(Color.black)
                }
                .padding(.vertical,5)
                Spacer()
            }
            .padding(5)
            .background(Color.lightGrayMid)
            .cornerRadius(10)
        }
    }
}
