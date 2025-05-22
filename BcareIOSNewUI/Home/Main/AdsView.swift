//
//  SplashView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//


import Foundation
import SwiftUI
import SwiftUIPager
import Combine

struct AdsView: View {
    let ads = isAr ? (1...3).map { _ in AdsItem(name: "ads1ar") } : (1...3).map { _ in AdsItem(name: "ads1en") }
    @State var currentPage = 0
    @State var page: Page = .first()
    @State var resetNow = false
    let dotSize:CGFloat = 5
    let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    let adWidth = screenWidth - 20
    var body: some View {
        ZStack(alignment:.center) {
            Pager(page: page,
                  data: Array(ads.indices),
                  id: \.self) { row in
                HStack {
                    Image(ads[row].name)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: adWidth,height: adWidth * 360 / 1029)
                        .cornerRadius(15)
                }
                .onSwipe(perform: { direction in
                    if direction == .left {
                        let res = currentPage + 1
                        if res < ads.count {
                            swipeValue(res)
                        }
                       
                    }
                    else if direction == .right {
                        let res = currentPage - 1
                        if res >= 0 {
                            swipeValue(res)
                        }
                       
                    }
                })
            }
           .disableDragging()
           .frame(width: adWidth,height: adWidth * 360 / 1029)
            VStack {
                Spacer()
                HStack(spacing:3) {
                    ForEach(Array(0..<ads.count),id:\.self) { row in
                        if row == currentPage {
                            Circle()
                                .fill(Color.lightGrayMid)
                                .frame(width:dotSize,height:dotSize)
                        }
                        else {
                            Circle()
                                .fill(Color.lightGrayMid.opacity(0.5))
                                .frame(width:dotSize,height:dotSize)
                        }
                    }
                }
                .padding(.bottom,10)
            }
        }
        .environment(\.layoutDirection,.leftToRight)
        .background(Color.white)
        .padding(.vertical,30)
        .onReceive(timer) { input in
            if userEmail != "shehata.g@neomtech.com" { // lock change for me
                if resetNow {
                    resetNow = false
                    return
                }
                let res = currentPage + 1
                if res < ads.count {
                    currentPage = res
                    page = Page.withIndex(currentPage)
                }
                else {
                    currentPage = 0
                    page = Page.first()
                }
            }
        }
    }
    func swipeValue(_ res:Int) {
        currentPage = res
        page = Page.withIndex(currentPage)
        resetNow = true
    }
}
