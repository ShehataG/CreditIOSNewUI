//
//  SpreadItemsView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct SpreadItemsView: View {
    let items:[CompareItem]
    var body: some View {
        HStack {
            ForEach(items.indices, id: \.self) { index in
                TitleSubView(item:items[index])
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
