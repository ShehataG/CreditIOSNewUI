//
//  CompareMainDetail.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct CompareMainDetail: View {
    let item:CompareContainerItem
    let imgWid:CGFloat = isIpad ? 60 : 40
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing:30) {
                SpreadItemsView(items: item.header)
                SpreadItemsView(items: item.top)
                SpreadItemsView(items: item.bottom)
            }
            .padding(10)
//            .background(.white)
//            .cornerRadius(20)
            .modifier(BackgroundModifer(radius: 20))
        }
    }
}
