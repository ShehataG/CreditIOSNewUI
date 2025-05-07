//
//  MedicalMenuList.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct MedicalMenuList: View {
    let item:MedicalMenuItem
    let backColor:Color
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(verbatim: item.name)
                    .font(Fonts.tooSmallBold())
                    .foregroundColor(Color(hex: "#585151")!)
                Text(verbatim: item.place)
                    .font(Fonts.tooSmallLight())
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
