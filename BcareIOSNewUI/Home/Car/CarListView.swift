//
//  CarListView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
 
struct CarListView: View {
    var item:String
    let imgWid:CGFloat = isIpad ? 40 : 35
    var body: some View {
        HStack {
            Image("checked")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imgWid,height: imgWid)
            Text(item.localized)
                .font(Fonts.smallLight())
                .foregroundColor(Color.black)
            Spacer()
        }
        .padding(.top,15)
    }
}
