//
//  PolicyDetailsList.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct PolicyDetailsList: View {
    let title:String
    let desc:String
    let backColor:Color
    init(title: String, desc: String, backColor: Color = Color.clear) {
        self.title = title
        self.desc = desc
        self.backColor = backColor
    }
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(verbatim: title.localized)
                    .font(Fonts.tooSmallLight())
                    .foregroundColor(Color(hex: "#585151")!)
                Text(verbatim: desc)
                    .font(Fonts.tooSmallBold())
                    .foregroundColor(Color.black)
                    .padding(.vertical,5)
            }
            .padding(.horizontal,30)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical,20)
        .padding(.horizontal,10)
        .background(backColor)
    }
}
