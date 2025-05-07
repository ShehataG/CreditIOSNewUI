//
//  PaymentList.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
 
struct PaymentList: View {
    let title:String
    let images:[String]
    let showLoader:Bool
    let imgWid:CGFloat = isIpad ? 50.0 : 40.0
    var body: some View {
        VStack {
            HStack {
                Text(verbatim:title.localized)
                    .font(Fonts.smallRegular())
                    .foregroundColor(Color.black)
                Spacer()
            }
            HStack(spacing: 10) {
                ForEach(images.indices,id: \.self) { row in
                    Image(images[row])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imgWid,height: imgWid)
                }
                Spacer()
                HStack {
                    if showLoader {
                        LoadingOnlyView()
                    }
                    FAText(text: FontAwesome.backRevIcon,color: Color.black,font: Fonts.fontAwesome15_20())
                        .padding(.horizontal,5)
                }
            }
            .padding(.vertical,5)
            .padding(.horizontal,10)
            .background(Color.lightGrayMid)
            .padding(.vertical,5)
        }
        .padding(.top,5)
    }
}
