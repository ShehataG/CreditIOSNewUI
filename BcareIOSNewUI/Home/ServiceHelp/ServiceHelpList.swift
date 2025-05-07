//
//  BookingGrid.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct ServiceHelpList: View {
    let item: ServiceQuestionItem
    @State private var isExpanded:Bool
    init(item: ServiceQuestionItem) {
        self.item = item
        self.isExpanded = item.isExpanded
    }
    var body: some View {
        VStack {
            if (isExpanded) {
                HStack {
                    FAText(text: FontAwesome.minusIcon, color: appBlueColor)
                    Text(verbatim: item.question)
                            .font(Fonts.mediumLight())
                            .foregroundColor(Color.black)
                    Spacer()
                }
                .onTapGesture {
                    isExpanded.toggle()
                    item.isExpanded.toggle()
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text(verbatim: item.answer)
                            .font(Fonts.smallLight())
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                    .padding(5)
                 }
                .padding(10)
                .background(Color.lightGrayMid)
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
            }
            else {
                HStack {
                    FAText(text: FontAwesome.plusIcon, color: appBlueColor)
                    Text(verbatim: item.question)
                            .font(Fonts.mediumLight())
                            .foregroundColor(Color.black)
                    Spacer()
                }
                .onTapGesture {
                    isExpanded.toggle()
                    item.isExpanded.toggle()
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.top,10)
    }
}
