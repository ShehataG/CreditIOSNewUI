//
//  HomeProgressCell.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SanarKit


struct InsuranceProgressItem {
    let title:String
    let type:InsuranceOtherType
    let progress:Double
    let status:String
}

struct HomeProgressCell: View {
    @EnvironmentObject var coordinator: Coordinator
    let item:InsuranceProgressItem
    let types = ["Vehicle","Medical","Travel","Malpractices"]
    let imgWid:CGFloat = isIpad ? 40 : 30
    let wid:CGFloat = isIpad ? 0.1 : 0.2

    var body: some View {
        VStack  {
            HStack  {
                ColoredText(text:item.title)
                    .font(Fonts.mediumRegular())
                Spacer()
                ColoredGreenText(text:"ShowAll".localized)
                    .font(Fonts.smallLight())
            }
            .padding(10) 
            VStack  {
                HStack  {
                    VStack(alignment: .center) {
                        ProgressCircleView(progress: item.progress)
                    }
                    .frame(maxHeight: .infinity)
                    .frame(width: screenWidth * wid)
                    .background(Color(hex:"#9295A338"))
                    .cornerRadius(20)
                    .padding(.trailing,10)
                    HStack(alignment: .center) {
                        VStack(alignment: .leading,spacing: 10) {
                            ColoredGreenText(text:types[item.type.rawValue].localized.linesToSpaces)
                                .font(Fonts.mediumRegular())
                            Text(verbatim:item.status)
                                .font(Fonts.verySmallRegular())
                                .foregroundStyle(Color.white)
                                .padding(.vertical,5)
                                .padding(.horizontal,15)
                                .background(Color(hex:"#FFC778"))
                                .clipShape(Capsule())
                        }
                        Spacer()
                        FAColoredText(text: FontAwesome.backRevIcon)
                            .padding(.trailing,10)
                            .onTapGesture {
                            }
                    }
                    .padding(.vertical,10)
                }
            }
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(20)
            .padding(.top,5)
        }
    }
}
