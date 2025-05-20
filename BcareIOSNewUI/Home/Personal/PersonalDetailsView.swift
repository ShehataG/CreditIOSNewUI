//
//  PersonalDetailsView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SVGKit


struct PersonalDetailsView: View {
    @EnvironmentObject var coordinator: Coordinator
//    let item:CompareContainerItem
    @StateObject var personalDetailsVM = PersonalDetailsVM()
    let imgWid:CGFloat = isIpad ? 80 : 60
    let imgRedWid:CGFloat = isIpad ? 50 : 40

    var body: some View {
        VStack {
            HStack {
                BackButton(color: Color.black)
                Spacer()
            }
            ScrollView(showsIndicators: false) {
                VStack(spacing:0) {
                    Image("bankbelad")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imgWid,height: imgWid)
                        .padding(.horizontal,30)
                        .modifier(RoundedBackgroundModifer(color: appBlueColor))
                    if let item = personalDetailsVM.item {
                        CompareMainDetail(item: item)
                    }
                    VStack(spacing:20) {
                        HStack {
                            ColoredText(text: "FinanceAmount".localized)
                                .font(Fonts.largeRegular())
                            RiyalView(price: 80000.decimals(2), color: appBlueColor, font: Fonts.largeRegular())
                        }
                        ColoredGreenText(text: "IncludingAnnualProfit".localized)
                            .font(Fonts.verySmallRegular())
                    }
                    .padding(.top,30)
                    VStack {
                        HStack {
                            CheckView(isChecked: $personalDetailsVM.cond1,isError: $personalDetailsVM.cond1Error)
                            Text(verbatim: "TermsConditionsCredit".localized)
                                .font(Fonts.verySmallLight())
                                .foregroundStyle(Color(hex:"#666666")!)
                            Spacer()
                        }
                        HStack {
                            CheckView(isChecked: $personalDetailsVM.cond2,isError: $personalDetailsVM.cond2Error)
                            Text(verbatim: "TermsConditionsFinancing".localized)
                                .font(Fonts.verySmallLight())
                                .foregroundStyle(Color(hex:"#666666")!)
                            Spacer()
                        }
                        HStack {
                            Text(verbatim: "AnyDeclaration".localized)
                                .font(Fonts.tooSmallRegular())
                                .foregroundStyle(Color.red)
                                .padding(.horizontal,imgRedWid)
                            Spacer()
                        }
                        RoundedColoredText(text:"Agree")
                            .padding(.vertical,40)
                            .onTapGesture {
                                coordinator.push(Destination.personalRingPage)
                            }
                    }
                    .padding(.vertical,40)
                }
                .padding(.horizontal,20)
            }
            Spacer()
        }
        .background(Color.lightGray3)
        .navigationBarBackButtonHidden()
//        .edgesIgnoringSafeArea(.top)
    }
}
 
