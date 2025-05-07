//
//  RequestsClientList.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct RequestsClientList: View {
    let item:MojazResult
    let requestsListVM:RequestsListVM
    let imgSmallWid:CGFloat = isIpad ? 45 : 25
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 20) {
                HStack {
                    Text(verbatim:"TheVehicle".localized)
                        .font(Fonts.smallRegular())
                        .foregroundColor(Color.black)
                        .frame(minWidth: 80,alignment: .leading)
                    GrayText(text:item.vehicle.make() + " " + item.vehicle.model())
                        .font(Fonts.tooSmallLight())
                        .padding(.horizontal,30)
                    Spacer()
                    let url = Bundle.main.url(forResource: item.vehicle.makeCode.addZeros, withExtension: "svg")!
                    SVGImage(url:url,size: CGSize(width: imgSmallWid,height: imgSmallWid))
                        .frame(width: imgSmallWid,height: imgSmallWid)
                        .padding(5)
                }
                HStack {
                   Text(verbatim:"SequenceNumber".localized)
                       .font(Fonts.smallRegular())
                       .foregroundColor(Color.black)
                       .frame(minWidth: 80,alignment: .leading)
                    GrayText(text:item.vehicle.sequenceNumber)
                       .font(Fonts.tooSmallLight())
                       .padding(.horizontal,30)
                   Spacer()
               }
                HStack {
                    Text(verbatim:"CreatedDate".localized)
                        .font(Fonts.smallRegular())
                        .foregroundColor(Color.black)
                        .frame(minWidth: 80,alignment: .leading)
                    GrayText(text:item.createdDate ?? "")
                        .font(Fonts.tooSmallLight())
                        .padding(.horizontal,30)
                    Spacer()
                }
             }
            .padding(.horizontal,10)
             Text(verbatim:"DownloadReport".localized)
                .font(Fonts.tooSmallLight())
                .foregroundColor(Color.white)
                .frame(width: screenWidth * 0.5)
                .padding(.vertical,15)
                .background(appOrangeColor)
                .cornerRadius(10)
                .onTapGesture {
                    requestsListVM.downloadFile(item.referenceID)
                }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.top,10)
    }
}
