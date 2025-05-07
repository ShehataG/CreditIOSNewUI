//
//  RadioView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct RadioView: View {
    let items:[String]
    @Binding var selected:RadioButton
    var body: some View {
        VStack(spacing: 20) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                RadioItemView(title: item, isSelected: index == selected.rawValue)
                    .onTapGesture {
                        selected = RadioButton(rawValue: index)!
                    }
            }
        }
    }
}
 
struct RadioItemView: View {
    let title:String
    let isSelected:Bool
    var body: some View {
        HStack {
            Circle()
                .fill(isSelected ? appOrangeColor : Color.white)
              .padding(4)
              .overlay(
                 Circle()
                    .stroke(Color.lightGray, lineWidth: 1)
               )
              .frame(width: 20, height: 20)
            Text(title)
                  .font(Fonts.smallRegular())
                  .foregroundColor(appBlueColor)
            Spacer()
        }
        .padding(.horizontal,10)
    }
}

enum RadioButton:Int {
     case email = 0
     case phone
}
