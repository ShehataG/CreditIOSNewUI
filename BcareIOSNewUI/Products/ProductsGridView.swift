//
//  ProductsGridView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct ProductsGridView: View {
    var item:ProductsItem
    let itemWidth = (screenWidth * 0.7 - 10) * 0.5
    var body: some View {
        ZStack(alignment: .center) {
            Image(item.backImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: itemWidth, height: itemWidth)
            HStack {
                VStack(alignment:.leading,spacing:0) {
                    Text(verbatim: item.title)
                        .font(Fonts.smallRegular())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal,10)
                Spacer()
            } 
        }
        .cornerRadius(10)
    }
}
