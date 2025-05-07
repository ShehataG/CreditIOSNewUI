//
//  ProfileFollowersView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct ProfileFollowersView: View {
    let top:String
    let bottom:Int
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(verbatim: top.localized)
                    .font(Fonts.verySmallRegular())
                    .foregroundColor(Color.black)
                HStack {
                    Text(verbatim: bottom.toString())
                        .font(Fonts.tooSmallLight())
                        .foregroundColor(appBlueColor)
                        .padding(.horizontal,5)
                    Text(verbatim: "Followers".localized)
                        .font(Fonts.tooSmallLight())
                        .foregroundColor(appBlueColor)
                }
                .padding(.top,3)
            }
            .padding(.leading,50)
            .padding(.vertical,20)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Rectangle().fill(Color.white).cornerRadius(10.0).shadow(radius: 3,x: -3,y: 3))
    }
}
