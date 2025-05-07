//
//  InfoNoteView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
 
struct InfoNoteView: View {
    let title:String
    var body: some View {
        HStack(alignment: .top) {
            FAText(text: FontAwesome.helpIcon,color: appBlueColor.opacity(0.3))
            Text(verbatim:title)
                .font(Fonts.verySmallRegular())
                .foregroundColor(Color.black)
                .padding(.horizontal,5)
        }
        .padding(10)
        .background(appBlueColor.opacity(0.1))
        .cornerRadius(10)
    }
}
