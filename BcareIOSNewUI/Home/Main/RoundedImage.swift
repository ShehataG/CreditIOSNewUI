//
//  RoundedImage.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//


import Foundation
import SwiftUI
import SwiftUIPager

struct RoundedImage: View {
    let name:String
    let imgWid:CGFloat = isIpad ? 25 : 20
    var body: some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: imgWid,height: imgWid)
            .padding(7)
            .background(Color.white)
            .clipShape(Circle())
    }
}
