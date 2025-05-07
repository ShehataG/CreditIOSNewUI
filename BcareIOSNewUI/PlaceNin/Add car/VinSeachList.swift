//
//  VinSeachList.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct VinSeachList: View {
    let title:String
    let hasLine:Bool
    let imgWidth:CGFloat = isIpad ? 35.0 : 25.0
    var body: some View {
        VStack {
            HStack {
                Text(verbatim: title)
                    .font(Fonts.tooSmallLight())
                    .foregroundColor(.black)
                    .padding(.vertical,3)
                Spacer()
            }
            if hasLine {
                VStack {
                }.frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .background(Color(hex:"#DFDFDF"))
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}
