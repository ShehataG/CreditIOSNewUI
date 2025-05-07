//
//  BatteryTireList.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct BatteryTireList: View {
    let item:BatteryDatum
    let selected:Bool
    let imgWid:CGFloat = isIpad ? 25.0 : 15.0
    var body: some View {
        HStack {
            VStack(alignment: .leading,spacing: 10) {
                Text(verbatim: item.title)
                    .font(Fonts.smallRegular())
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                Text(verbatim: item.estimatedTime.toString() + " " + "Minute".localized)
                    .font(Fonts.verySmallLight())
                    .foregroundColor(Color.black)
            }
            Spacer() 
            RiyalView(price: item.price, color: appBlueColor, font: Fonts.smallRegular())
            ZStack {
                Circle()
                    .strokeBorder()
                    .frame(width:imgWid + 10, height:imgWid + 10)
                 if selected {
                    Circle()
                         .fill(appOrangeColor)
                        .frame(width:imgWid,height:imgWid)
                }
            }
        }
        .padding(20)
        .modifier(BackgroundModifer())
        .padding(.top,10)
    }
}
