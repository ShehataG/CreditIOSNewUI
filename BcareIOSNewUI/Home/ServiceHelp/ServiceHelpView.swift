//
//  ServiceHelpView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine
enum FaqType:Int {
    case wash = 0,maintenaince,mojaz,road
}
struct ServiceHelpView: View {
    @EnvironmentObject var coordinator: Coordinator
    var item:FaqType
    let result:ServiceHelpItem
    let bcareServiceNumber = "920033881"
    init(item: FaqType) {
        self.item = item
        self.result = ServiceHelpValues.getFAQ(item)
     }

    var body: some View {
        VStack {
            HStack {
                BackPaddedButton(color: Color.black,back: Color.white)
                Spacer()
                Text(verbatim:result.service)
                    .font(Fonts.mediumRegular())
                    .foregroundColor(Color.black)
                    .padding(.horizontal,10)
            }
            .padding(.horizontal,10)
            VStack {
                VStack {
                    HStack {
                        Text(verbatim:"FAQ".localized)
                            .font(Fonts.smallBold())
                            .foregroundColor(Color.black)
                            .padding(.horizontal,10)
                        Spacer()
                    }
                    .padding(.top,10)
                    VStack {
                        VStack(spacing: 0) {
                            List(result.questions,id: \.self) { item in
                                ServiceHelpList(item: item)
                                    .modifier(ListItemMode())
                            }
                            .modifier(ListMode())
                        }
                        Spacer()
                        VStack(alignment: .leading,spacing: 15) {
                            Divider().padding(.vertical,10).frame(maxWidth: .infinity).frame(height: 3).background(Color.lightGray)
                            HStack {
                                Text(verbatim:"StillNeedsHelp".localized)
                                    .font(Fonts.smallBold())
                                    .foregroundColor(Color.black)
                                    .padding(.horizontal,10)
                                Spacer()
                            }
                            HStack {
                                Text(verbatim:"ExistsAroundClock".localized)
                                    .font(Fonts.smallRegular())
                                    .foregroundColor(Color.black)
                                    .padding(.horizontal,10)
                                Spacer()
                            }
                            HStack {
                                Spacer()
//                                ServiceHelpBu(top: "Chat".localized, bottom: "WithExpert".localized, isSelected: true)
                                ServiceHelpBu(top: "CallUs".localized, bottom: bcareServiceNumber, isSelected: false)
                                    .frame(width: screenWidth * 0.5)
                                    .onTapGesture {
                                        if let url = URL(string: "tel://\(bcareServiceNumber)") {
                                            UIApplication.shared.open(url, options: [:], completionHandler:nil)
                                        }
                                    }
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal,5)
                }
                .padding(.horizontal,20)
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden()
    }
}
