//
//  WareefDiscountView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct WareefDiscountView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.presentationMode) var presentationMode
    let item:WareefCategoryDatumItem
    let showWareefCard:Bool
    let itemWidth = (screenWidth * 0.7 - 10) * 0.5
    let imgWid:CGFloat = isIpad ? 30.0 : 20.0
    @State var toastShownInfo = false
    @State var toastContentInfo = ""
    var body: some View {
        ZStack(alignment: .center) {
            PlaceholderView()
            VStack(spacing:0) {
                HStack {
                    Image("close")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imgWid,height: imgWid)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .padding(.horizontal,20)
                    Spacer()
                }
                .padding(.top,15)
                let discounts = item.itemDiscounts.first!
                let details = discounts.waeefDicscountItemsDetails
                Image(base64String: item.imageBytes)!
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:screenWidth * 0.3,height: 45)
                    .padding(.horizontal,7)
                    .padding(.top,5)
                Text(verbatim: "Discount".localized + " " + discounts.descountValue)
                        .font(Fonts.smallBold())
                        .foregroundColor(Color.white)
                        .padding(.vertical,15)
                        .frame(width: screenWidth * 0.6)
                        .background(appGreenColor)
                        .cornerRadius(10)
                        .padding(.top,10)
                        .padding(.bottom,details.count == 0 && !discounts.isValidCode ? 20 : 0)

                VStack(alignment: .leading) {
                    ForEach(0..<details.count, id: \.self) { index in
                        if let dis = details[index].benefitDescription {
                            HStack {
                                ColoredText(text: "\(index + 1)- " + dis)
                                    .font(Fonts.tooSmallLight())
                                    .padding(.horizontal,20)
                                Spacer()
                            }
                            .padding(.bottom,5)
                        }
                    }
                }
                .padding(.top,10)
                .padding(.bottom,20)
                if showWareefCard , let wDescountCode = discounts.wDescountCode { //discounts.isValidCode && userPoliciesCount != 0 {
                    VStack {
                        Text(verbatim: "Code".localized)
                            .font(Fonts.smallBold())
                            .foregroundColor(Color.black)
                        ZStack(alignment: .center) {
                            HStack {
                                Image("copy")
                                    .resizable()
                                    .frame(width: imgWid,height: imgWid)
                                    .aspectRatio(contentMode: .fit)
                                Spacer()
                            }
                            Text(verbatim: wDescountCode)
                                .font(Fonts.smallRegular())
                                .foregroundColor(Color.black)
                        }
                        .padding(.horizontal,20)
                        .padding(.vertical,15)
                        .frame(width: screenWidth * 0.5)
                        .background(Color.lightGrayMid)
                        .cornerRadius(10)
                        .padding(.top,10)
                        .padding(.bottom,20)
                        .onTapGesture {
                            let pasteBoard = UIPasteboard.general
                            pasteBoard.string = wDescountCode
                            toastContentInfo = "doneCopying".localized
                            toastShownInfo = true
                        }
                    }
                }
//                else if !discounts.isValidCode && userPoliciesCount != 0 {
//                    WareefCodeView(text: "ShowWooref")
//                }
//                else if !discounts.isValidCode && userPoliciesCount == 0 {
//                    WareefCodeView(text: "ShowWoorefwitoutId")
//                }
            }
            .frame(width: screenWidth * 0.8)
            .background(Color.white)
            .cornerRadius(10)
        }
        .environment(\.layoutDirection, coordinator.layoutDirection)
        .toast(isPresenting: $toastShownInfo) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: toastContentInfo)
        }
    }
}
