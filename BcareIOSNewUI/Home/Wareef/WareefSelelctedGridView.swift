//
//  WareefSelelctedGridView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI
import WebKit

struct WareefSelelctedGridView: View {
    let imageBytes:String
    let imgWid:CGFloat = isIpad ? 40 : 30
    let itemWidth = screenWidth * 0.3
    var body: some View {
        VStack {
            Image(base64String: imageBytes)!
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:screenWidth * 0.3,height: 45)
                .padding(.horizontal,7)
        }
        .frame(width: screenWidth * 0.35,height: 75)
        .background(Rectangle().fill(Color.white).cornerRadius(10.0).shadow(color:Color.black.opacity(0.1),radius: 3,x: 0,y: 5))
    }
}
