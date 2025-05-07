//
//  OrdersClientList.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct OrdersClientList: View {
    let item:OrderDatum
    let ordersListVM:OrdersListVM
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 20) {
                HStack {
                    Text(verbatim:"TheService".localized)
                        .font(Fonts.smallRegular())
                        .foregroundColor(Color.black)
                        .frame(minWidth: 80,alignment: .leading)
                    GrayText(text:item.subService.title)
                        .font(Fonts.tooSmallLight())
                        .padding(.horizontal,30)
                    Spacer()
                    if item.status == "completed" {
                        FAText(text: FontAwesome.checkedIcon,color: Color.green)
                    }
                    else {
                        FAText(text: FontAwesome.closeIcon,color: Color.red)
                    }
                }
                HStack {
                   Text(verbatim:"BookingCode".localized)
                       .font(Fonts.smallRegular())
                       .foregroundColor(Color.black)
                       .frame(minWidth: 80,alignment: .leading)
                    GrayText(text:item.code)
                       .font(Fonts.tooSmallLight())
                       .padding(.horizontal,30)
                   Spacer()
               }
                HStack {
                    Text(verbatim:"CreatedDate".localized)
                        .font(Fonts.smallRegular())
                        .foregroundColor(Color.black)
                        .frame(minWidth: 80,alignment: .leading)
                    GrayText(text:item.createdDate)
                        .font(Fonts.tooSmallLight())
                        .padding(.horizontal,30)
                    Spacer()
                }
             }
            .padding(.horizontal,10)
            if item.status == "completed" {
                Text(verbatim:"CancelRequest".localized)
                    .font(Fonts.tooSmallLight())
                    .foregroundColor(Color.white)
                    .frame(width: screenWidth * 0.5)
                    .padding(.vertical,15)
                    .background(Color.red)
                    .cornerRadius(10)
                    .onTapGesture {
                        ordersListVM.lastOrderId = item.id
                        ordersListVM.showCancel = true
                    }
            }
            else {
                Text(verbatim:item.status)
                    .font(Fonts.tooSmallLight())
                    .foregroundColor(Color.white)
                    .frame(width: screenWidth * 0.5)
                    .padding(.vertical,15)
                    .background(appOrangeColor)
                    .cornerRadius(10)
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.top,10)
    }
}
