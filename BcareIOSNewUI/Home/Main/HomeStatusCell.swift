//
//  HomeStatusCell.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SanarKit
 
enum InsuranceOtherType:Int {
    case personal = 0,realState,rent,credit
}

struct InsuranceStatusItem {
    let title:String
    let type:InsuranceOtherType
    let number:Int
    let status:String
    let reason:String
}

struct HomeStatusCell: View {
    @EnvironmentObject var coordinator: Coordinator
    let item:InsuranceStatusItem
    let types = ["Vehicle","Medical","Travel","Malpractices"]
    let images = ["vehiclesmall","medicalsmall","travelsmall","malpracticessmall"]
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
                        Image(images[item.type.rawValue])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imgWid,height: imgWid)
                    }
                    .frame(maxHeight: .infinity)
                    .frame(width: screenWidth * wid)
                    .background(Color(hex:"#9295A338"))
                    .cornerRadius(20)
                    .padding(.trailing,10)
                    HStack(alignment: .center) {
                        VStack(spacing: 10) {
                            ColoredGreenText(text:types[item.type.rawValue].localized.linesToSpaces)
                                .font(Fonts.mediumRegular())
                            GrayText(text:"RequestN".localized + " : " + item.number.toString())
                                .font(Fonts.smallRegular())
                            Text(verbatim:item.reason)
                                .font(Fonts.verySmallRegular())
                                .foregroundStyle(Color.white)
                                .padding(.vertical,5)
                                .padding(.horizontal,10)
                                .background(appBlueColor)
                                .clipShape(Capsule())
                        }
                        Spacer()
                        Text(verbatim:item.status)
                            .font(Fonts.mediumRegular())
                            .foregroundStyle(Color.white)
                            .padding(.vertical,5)
                            .padding(.horizontal,10)
                            .background(Color(hex:"#C40000"))
                            .clipShape(Capsule())
                            .padding(.trailing,10)
                    }
                    .padding(.vertical,10)
                }
            }
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(20)
        }
        .padding(.top,15)
    }
}
