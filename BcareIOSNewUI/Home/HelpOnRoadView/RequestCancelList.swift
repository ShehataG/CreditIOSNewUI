//
//  RequestCancelList.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct RequestCancelList: View {
    let title:String
    let isChecked:Bool
    let hasLine:Bool
    let imgWidth:CGFloat = isIpad ? 35.0 : 25.0
    var body: some View {
        VStack {
            HStack {
                Text(verbatim: title.localized)
                    .font(Fonts.smallRegular())
                    .foregroundColor(.black)
                    .padding(.vertical,12)
                Spacer()
                if isChecked {
                    Image("requestprogon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imgWidth,height: imgWidth)
                }
            }
            if hasLine {
                VStack {
                }.frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .background(Color(hex:"#DFDFDF"))
            }
        }
        .background(Color.white)
    }
}
