//
//  HelpListView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import  SwiftUI

struct HelpListView: View {
    @EnvironmentObject var coordinator: Coordinator
    let title,icon:String
    var body: some View {
        HStack {
            FAText(text: icon, color: appBlueColor)
            .padding(.leading,5)
            .padding(.trailing,10)
            Text(verbatim:title.localized)
                .font(Fonts.mediumRegular())
                .foregroundColor(Color.black)
            Spacer()
        }
    }
}
