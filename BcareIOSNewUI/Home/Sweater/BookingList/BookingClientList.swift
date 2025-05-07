//
//  BookingClientList.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct BookingClientList: View {
    let item:BookingsClientItem
    let bookingListVM:BookingListVM
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 20) {
                HStack {
                    Text(verbatim:"TheVehicle".localized)
                        .font(Fonts.smallRegular())
                        .foregroundColor(Color.black)
                        .frame(minWidth: 80,alignment: .leading)
                    GrayText(text:item.brand + " " + item.model)
                        .font(Fonts.tooSmallLight())
                        .padding(.horizontal,30)
                    Spacer()
                    if item.status == "Accepted" {
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
                    GrayText(text:item.bookingId.toString())
                       .font(Fonts.tooSmallLight())
                       .padding(.horizontal,30)
                   Spacer()
               }
                 HStack {
                    Text(verbatim:"ServiceTime".localized)
                        .font(Fonts.smallRegular())
                        .foregroundColor(Color.black)
                        .frame(minWidth: 80,alignment: .leading)
                     GrayText(text:item.date  + " " + item.startTime)
                        .font(Fonts.tooSmallLight())
                        .padding(.horizontal,30)
                    Spacer()
                }
             }
            .padding(.horizontal,10)
            if item.status == "Accepted" {
                Text(verbatim:"CancelRequest".localized)
                    .font(Fonts.tooSmallLight())
                    .foregroundColor(Color.white)
                    .frame(width: screenWidth * 0.5)
                    .padding(.vertical,15)
                    .background(Color.red)
                    .cornerRadius(10)
                    .onTapGesture {
                        bookingListVM.lastBookingId = item.bookingId
                        bookingListVM.showCancel = true
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
