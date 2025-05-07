//
//  RequestProgressView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct RequestProgressView: View {
    let title:String
    let subTitle:String
    let action:String?
    let isChecked:Bool
    let hasLine:Bool
    let imgWidth:CGFloat = isIpad ? 35.0 : 25.0
    @State var size: CGSize = .zero
    var body: some View {
        VStack {
            HStack {
                Image(isChecked ? "requestprogon" : "requeststatusoff")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imgWidth,height: imgWidth)
                Text(verbatim: title.localized)
                    .font(Fonts.smallBold())
                    .foregroundColor(.black)
                    .padding(.horizontal,5)
                Spacer()
            }
            HStack(alignment: .top) {
                 VStack(alignment: .leading) {
                    if hasLine {
                        VStack {
                        }
                        .frame(width: 1)
                        .frame(height: size.height)
                        .background(Color(hex:"#F9A52D")!)
                    }
                }
                .frame(width: imgWidth)
                VStack(alignment: .leading) {
                    Text(verbatim: subTitle)
                        .font(Fonts.smallLight())
                        .foregroundColor(Color.sevenLightGray)
                        .modifier(MultiLine(alignment: .leading))
                        .padding(.horizontal,5)
                    if let action = action {
                        Text(verbatim: action.localized)
                            .font(Fonts.verySmallMedium())
                            .foregroundColor(appBlueColor)
                            .padding(.vertical,5)
                            .padding(.horizontal,10)
                            .background(Capsule().fill(Color(hex:"#C6E9FF")!))
                    }
                }
                Spacer()
            }
            .padding(.bottom,10)
            .saveSize(in: $size)
        }
    }
}
