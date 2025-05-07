//
//  BookingView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine

struct BookingView: View {
    @EnvironmentObject var coordinator: Coordinator
    let item:CarLocationItem
    @State var once = true
    let imgWidth:CGFloat = isIpad ? 30.0 : 20.0
    let mainGridHei:CGFloat = isIpad ? 90.0 : 70.0
    let imgArrowWid:CGFloat = isIpad ? 60.0 : 50.0
    @StateObject var bookingVM = BookingVM()
    let gridRows:[GridItem] = [GridItem(.flexible())]
    @State var showSearch = false
    @State var showNoBikers = false
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HStack {
                    BackPaddedButton(color: Color.black,back: Color.white)
                    Spacer()
                    HStack {
                        Text(verbatim:"Help".localized)
                            .font(Fonts.mediumRegular())
                            .foregroundColor(Color.black)
                         FAText(text: FontAwesome.chatIcon, color: Color.black)
                            .padding(.leading,5)
                            .padding(.trailing,10)
                    }
                    .onTapGesture {
                        coordinator.push(FaqType.wash)
                    }
                }
                .padding(.horizontal,10)
                if item.mainItems == nil {
                    LoadingView(color: Color.black)
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                }
                else
                if item.mainItems.isEmpty {
                    VStack {
                        Spacer()
                        VStack {
                            FAColoredText(text: FontAwesome.faceDownIcon,font: Fonts.fontAwesome40_50())
                            Text(verbatim:"ThereIsNoServiceSweater".localized)
                                .font(Fonts.mediumRegular())
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                        Text(verbatim: "ReturnToHome".localized)
                            .font(Fonts.verySmallRegular())
                            .foregroundColor(Color.white)
                            .padding(.vertical,15)
                            .frame(maxWidth: .infinity)
                            .background(appBlueColor)
                            .cornerRadius(20)
                            .onTapGesture {
                                coordinator.goToRoot()
                            }
                    }
                    .padding(.horizontal,20)
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                }
                else {    
                    let current = item.mainItems[bookingVM.currentMainIndex]
                    VStack {
                        HStack {
                            Text(verbatim:"ChooseTimeDate".localized)
                                .font(Fonts.mediumRegular())
                                .foregroundColor(Color.black)
                                .padding(.horizontal,10)
                            Spacer()
                        }
                        .padding(.top,10)
                        VStack {
                            let first = current.date
                            HStack {
                                Text(verbatim:first)
                                    .font(Fonts.verySmallBold())
                                    .foregroundColor(Color.black)
                                Spacer()
                                if item.mainItems.count > 1 {
                                    HStack(spacing: 15) {
                                        if bookingVM.currentMainIndex > 0 {
                                            Text(verbatim: FontAwesome.backIcon)
                                                .font(Fonts.fontAwesome20_30())
                                                .foregroundColor(appBlueColor)
                                                .onTapGesture {
                                                    bookingVM.currentSlotIndex = nil
                                                    bookingVM.currentSubIndex = nil
                                                    bookingVM.currentMainIndex -= 1
                                                    bookingVM.time = "ChooseTime".localized
                                                }
                                        }
                                        else {
                                            GrayText(text: FontAwesome.backIcon)
                                                .font(Fonts.fontAwesome20_30())
                                        }
                                        if bookingVM.currentMainIndex < item.mainItems.count - 1 {
                                            Text(verbatim: FontAwesome.backRevIcon)
                                                .font(Fonts.fontAwesome20_30())
                                                .foregroundColor(appBlueColor)
                                                .onTapGesture {
                                                    bookingVM.currentSlotIndex = nil
                                                    bookingVM.currentSubIndex = nil
                                                    bookingVM.currentMainIndex += 1
                                                    bookingVM.time = "ChooseTime".localized
                                                }
                                        }
                                        else {
                                            GrayText(text: FontAwesome.backRevIcon)
                                                .font(Fonts.fontAwesome20_30())
                                        }
                                    }
                                }
                            }
                            .padding(.top,10)
                            HStack {
                                let arr = current.items
                                ScrollViewReader { proxy in
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        LazyHGrid(rows:gridRows,alignment:.bottom,spacing: 10) {
                                            ForEach(arr.indices,id: \.self) { row in
                                                BookGridView(item: arr[row], isSelected: bookingVM.currentSubIndex == row)
                                                    .onTapGesture {
                                                        bookingVM.currentSlotIndex = nil
                                                        bookingVM.currentSubIndex = row
                                                        bookingVM.time = "ChooseTime".localized
                                                        let slots = item.mainItems[bookingVM.currentMainIndex].items[bookingVM.currentSubIndex!].slots
                                                            showNoBikers = slots.isEmpty
                                                     }
                                            }
                                        }
                                        .frame(height: mainGridHei)
                                    }
                                    .frame(height: mainGridHei)
                                    .onAppear {
                                        proxy.scrollTo(0)
                                    }
                                }
                            }
                            .padding(.vertical,10)
                        }
                        .padding(.vertical,10)
                        .padding(.horizontal,15)
                        .background(Rectangle().fill(Color.white).cornerRadius(10.0).shadow(radius: 3,x: -3,y: 3))
                        .padding(.top,10)
                        VStack {
                            HStack {
                                GrayText(text:"Time".localized)
                                    .font(Fonts.tooSmallLight())
                                    .padding(.top,5)
                                Spacer()
                            }
                            HStack {
                                Text(verbatim:bookingVM.time)
                                    .font(Fonts.verySmallRegular())
                                    .foregroundColor(Color.black)
                                    .padding(.horizontal,10)
                                Spacer()
                                Text(verbatim: FontAwesome.arrowDownIcon)
                                    .font(Fonts.fontAwesome15_20())
                                    .foregroundColor(Color(hex: "#001A72")!)
                                   
                            }
                            .padding(.top,5)
                            .padding(.bottom,20)
                        }
                        .padding(.horizontal,20)
                        .background(Rectangle().fill(Color.white).cornerRadius(10.0).shadow(radius: 3,x: -3,y: 3))
                        .padding(.top,10)
                        .onTapGesture {
                            if bookingVM.currentSubIndex != nil {
                                let slots = item.mainItems[bookingVM.currentMainIndex].items[bookingVM.currentSubIndex!].slots
                                if !slots.isEmpty {
                                    showSearch = true
                                }
                            }
                        }
                        if showNoBikers {
                            HStack {
                                FAColoredText(text: FontAwesome.faceDownIcon)
                                Text(verbatim:"NoBikersAvailable".localized)
                                    .font(Fonts.smallBold())
//                                    .symbolRenderingMode(.monochrome)
                                    .foregroundColor(appBlueColor)
                                    .padding(.horizontal,5)
                                    .multilineTextAlignment(.center)
                                Spacer()
                            }
                            .padding(10)
                            .background(appBlueColor.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.top,20)
                        }
                        Spacer()
                        VStack {
                            if let res = bookingVM.amount?.amountWithVat {
                                HStack {
                                    Text(verbatim:"TotalAmount".localized)
                                        .font(Fonts.mediumRegular())
                                        .foregroundColor(Color.black)
                                        .padding(.horizontal,10)
                                    Spacer()
                                }
                                .padding(.top,10)
                                HStack(spacing: 3) {
                                    RiyalView(price: res.toString(), color: appBlueColor, font: Fonts.largeBold())
                                    Spacer()
                                }
                                .padding(20)
                                .background(Color.white)
                                .cornerRadius(10)
                                .padding(.top,10)
                                let color = bookingVM.currentSubIndex == nil || bookingVM.currentSlotIndex == nil ? Color.lightGray : appBlueColor
                                RoundedLoaderHBu(item: "Revision", textColor: .white, backEnableColor: color,backDisableColor:appOrangeDarkColor,vPadding: 20,showLoader:false)
                                    .padding(.top,10)
                                    .onTapGesture {
                                        if bookingVM.currentSubIndex != nil && bookingVM.currentSlotIndex != nil , let amount = bookingVM.amount {
                                            let date = current.items[bookingVM.currentSubIndex!].date
                                            let value = BookingDetailsSentItem(place: item, time: bookingVM.time, date: date,amount: amount)
                                            coordinator.push(value)
                                        }
                                    }
                            }
                            else {
                                HStack {
                                    Spacer()
                                    LoadingOnlyView()
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(.horizontal,20)
                }
            }
            if showSearch {
                ZStack {
                    PlaceholderView()
                    VStack {
                        Spacer()
                        VStack {
                            HStack  {
                                Spacer()
                                Image("closebacked")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: imgArrowWid,height: imgArrowWid)
                                    .onTapGesture {
                                        showSearch = false
                                        bookingVM.search = ""
                                    }
                            }
                            CarSearchlnputView(placeholder: "Search", value: $bookingVM.search, type: .search, topPadding: 10)
                            let arr = item.mainItems[bookingVM.currentMainIndex].items[bookingVM.currentSubIndex!].slots
                            let filtered = bookingVM.search == "" ? arr : arr.filter { $0.startTime.contains(bookingVM.search) }
                            List(filtered.indices,id: \.self) { row in
                                VinSeachList(title: filtered[row].startTime, hasLine: row != filtered.count - 1)
                                    .modifier(ListItemMode())
                                    .onTapGesture {
                                        bookingVM.currentSlotIndex = row
                                        bookingVM.time = filtered[row].startTime
                                        showSearch = false
                                        bookingVM.search = ""
                                    }
                            }
                            .modifier(ListMode())
                            .frame(height: screenHeight * 0.25)
                            .padding(.horizontal,20)
                            .padding(.vertical,10)
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.top,5)
                        }
                        .padding(.bottom,30)
                        .padding(20)
                        .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        .background(Color.lightGrayMid)
        .navigationBarBackButtonHidden()
        .onAppear {
//            if once {
//                bookingVM.availableDays(item.coordinate)
//                once = false
//            }
        }
    }
}
