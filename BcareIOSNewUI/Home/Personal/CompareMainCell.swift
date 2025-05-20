//
//  CompareMainCell.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct CompareMainCell: View {
    @EnvironmentObject var coordinator: Coordinator
    let item:CompareContainerItem
    let isLast:Bool
    let imgWid:CGFloat = isIpad ? 60 : 40
    @State var isExpanded:Bool
    init(item: CompareContainerItem,isLast:Bool) {
        self.item = item
        self.isLast = isLast
        self.isExpanded = item.isExpanded
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack(alignment: .center) {
                    Image("bankbelad")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imgWid,height: imgWid)
                        .padding(.horizontal,5)
                    SpreadItemsView(items: item.header)
                    RoundedColoredText(text: "ChooseOne",color:appGreenColor)
                        .onTapGesture {
                            coordinator.push(Destination.personalDetailsPage)
                        }
                }
                if isExpanded {
                    Divider().frame(maxWidth: .infinity).frame(height: 1).background(Color.lightGray).padding(.horizontal,10)
                    VStack(spacing: 10) {
                        SpreadItemsView(items: item.top)
                        SpreadItemsView(items: item.bottom)
                    }
                    .padding(.top,15)
                }
            }
            .padding(.vertical,isExpanded ? 10 : 20)
            .padding(.horizontal,10)
//            .background(.white)
            .modifier(BackgroundModifer(radius: 20))
//            .cornerRadius(20)
            .padding(.top,10)
            ArrowDirView(isExpanded: isExpanded)
                .offset(y:10)
                .onTapGesture {
                    item.isExpanded = !item.isExpanded
                    isExpanded = item.isExpanded
                }
        }
        .padding(.top,10)
        .padding(.bottom,isLast ? 10 : 0)
    }
}
