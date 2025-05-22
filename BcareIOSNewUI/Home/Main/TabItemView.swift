//
//  TabItemView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI


struct TabItemView: View {
    @Binding var selection: Int
    let tag: Int
    let systemName: String
    let title:String
    @State private var y: CGFloat = 0
    let imgWidth:CGFloat = isIpad ? 35 : 25
    
    var body: some View {
        VStack(alignment: .center,spacing: 0) {
            if systemName == "plus.circle.fill" {
                if selection == tag {
                    ZStack {
                        Image("closetab")
                            .resizable()
                            .scaledToFit()
                            .frame(width: imgWidth, height: imgWidth)
                    }
                    .frame(width: 65, height: 65)
                    .background(appGreenColor)
                    .clipShape(Circle())
                    .background(Circle().stroke(Color.white,lineWidth:4))
                }
                else {
                    Text(verbatim: "ApplyNow".localized)
                        .font(Fonts.tooSmallBold())
                        .frame(width: 65, height: 65)
                        .foregroundStyle(Color.white)
                        .background(appGreenColor)
                        .clipShape(Circle())
                        .background(Circle().stroke(Color.white,lineWidth:4))
                }
            }
            else {
                if selection == tag {
                    Image(systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(appBlueColor)
                        .frame(width:imgWidth, height: imgWidth)
                    Text(verbatim: title.localized)
                        .foregroundStyle(appBlueColor)
                        .font(Fonts.tooSmallRegular())
                }
                else {
                    Image(systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.lightGray)
                        .frame(width:imgWidth, height: imgWidth)
                    Text(verbatim: title.localized)
                        .foregroundStyle(Color.lightGray)
                        .font(Fonts.tooSmallRegular())
                }
            }
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            selection = tag
        }
    }
}
 
