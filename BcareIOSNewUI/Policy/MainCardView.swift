//
//  MainCardView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI
import SwiftUIPager

struct MainCardView: View {
    let items:[PoliciesResult]
    let showExpire:Bool
    @State var page: Page = .first()
    @State var selection = 0
    let dotSize:CGFloat = 6
    let imgHei:CGFloat = isIpad ? 270.0 : 220.0
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    var cardClicked:((PoliciesResult)->())?
    init(items: [PoliciesResult],showExpire:Bool = true, cardClicked: ( (PoliciesResult) -> ())? = nil) {
        self.items = items
        self.showExpire = showExpire
        self.cardClicked = cardClicked
    }
    var body: some View {
        VStack(spacing: 10) {
            PageView(selection: $selection) {
                ForEach(0..<items.count, id: \.self) { row in
                    let item = items[row]
                    if item.productID == 2 {
                        PolicyMedCardView(item: item,showExpire: showExpire)
                            .tag(row)
                            .onTapGesture {
                                cardClicked?(item)
                            }
                    }
                    else {
                        PolicyCardView(item: item,showExpire: showExpire)
                            .tag(row)
                            .onTapGesture {
                                cardClicked?(item)
                            }
                    }
                }
            }
            .frame(width: screenWidth,height: imgHei)
            if items.count > 1 {
                HStack(spacing:3) {
                    ForEach(Array(0..<min(items.count,20)),id:\.self) { row in
                        if row == selection {
                            Circle()
                                .fill(appOrangeColor)
                                .frame(width:dotSize,height:dotSize)
                        }
                        else {
                            Circle()
                                .fill(Color.lightGray)
                                .frame(width:dotSize,height:dotSize)
                        }
                    }
                }
            }
        }
        .padding(.top,10)
    }
}
