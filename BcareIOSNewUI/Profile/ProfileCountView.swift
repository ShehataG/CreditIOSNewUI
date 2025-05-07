//
//  ProfileCountView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct ProfileCountView: View {
    let text:String
    let count:Int
    var body: some View {
        HStack {
            Text(verbatim: count.toString())
                .font(Fonts.smallRegular())
                .foregroundColor(.white)
                .padding(10)
                .background(appBlueColor)
                .clipShape(Circle())
            Text(verbatim: text.localized)
                .font(Fonts.smallLight())
                .foregroundColor(.black)
        }
        .padding(.horizontal,10)
        .background(Color.lightGrayMid)
        .cornerRadius(10.0)
    }
}
