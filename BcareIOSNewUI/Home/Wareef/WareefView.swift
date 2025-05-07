//
//  WareefView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import PassKit

struct WareefView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var wareefVM = WareefVM()
    @State var id:Int?
    @State var showBack = false
    @State var showDiscountView = false
    @StateObject var appleCardVM = AppleCardVM()
    let gridRows:[GridItem] = [GridItem(.flexible())]
    let imgMainWid:CGFloat = isIpad ? 120.0 : 100.0
    let gridColumns = [GridItem(.adaptive(minimum: (screenWidth * 0.7 - 10) * 0.5))]
    let gridColumnsOther = [GridItem(.adaptive(minimum: (screenWidth * 0.85 - 30) * 0.25))]
    let imgArrowWid:CGFloat = isIpad ? 50.0 : 40.0
    let images:[Int:String] = [4:"health",5:"carserv",6:"rashqa",7:"shop",8:"hotel",9:"education",10:"resturant",11:"family"]
    let imgWid:CGFloat = isIpad ? 40 : 30
    let itemWidth = (screenWidth * 0.7 - 10) * 0.5

    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: UserManager.isLoggedIn() ? 0.5 : 0.3)
            ScrollView(showsIndicators: false) {
                VStack(spacing:0) {
                    TopHeaderView()
                    if UserManager.isLoggedIn() , wareefVM.showWareefCard {
                        WareefCardView(showLoading: wareefVM.wareefLoading,expireDate:wareefVM.expireDate!)
                            .onTapGesture {
                                appleCardVM.getCard(PoliciesResult(policyExpiryDate: wareefVM.expireDate,nationalID: userNationalId, productID: 5))
                            }
                    }
                    else {
                        ManyHeaderView()
                    }
                }
                let arr = wareefVM.mainItems
                VStack(spacing:0) {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                ColoredText(text: "WareefProgram".localized)
                                    .font(Fonts.veryLargeRegular())
                                    .frame(height: imgArrowWid)
                                if showBack {
                                    Spacer()
                                    Image(isAr ? "arrowl" : "arrowr")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: imgArrowWid,height: imgArrowWid)
                                        .onTapGesture {
                                            showBack = false
                                        }
                                }
                            }
                            ColoredText(text: "WareefProgramDesc".localized)
                                .font(Fonts.verySmallRegular())
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.vertical,5)
                        }
                        .padding(.horizontal,30)
                        .padding(.bottom,arr.isEmpty ? 30 : 0)
                        .background(Color.lightGrayCommon)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,20)
                    .padding(.horizontal,10)
                    if showBack {
                        let name = arr.first(where: { $0.id == id })!.name
                        HStack {
                            Image(images[id!]!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:imgWid,height:imgWid)
                                .padding(.horizontal,7)
                            Text(verbatim: name)
                                .font(Fonts.verySmallLight())
                                .foregroundColor(appBlueColor)
                        }
                        .padding(.vertical,10)
                        .frame(width: screenWidth * 0.8)
                        .modifier(BackgroundModifer())
                        if wareefVM.submitSubLoading {
                            LoadingView()
                            .frame(height: 75)
                            .padding(.vertical,30)
                        }
                        else {
                            let data = wareefVM.wareefCache[id!] ?? []
                            ScrollViewReader { proxy in
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHGrid(rows:gridRows,alignment:.bottom,spacing: 10) {
                                        ForEach(data.indices,id: \.self) { row in
                                            WareefSelelctedGridView(imageBytes:data[row].imageBytes)
                                                .tag(row)
                                                .onTapGesture {
                                                    wareefVM.subIndex = row
                                                    showDiscountView = true
                                                }
                                        }
                                    }
                                    .frame(height: 75)
                                    .padding(.vertical,30)
                                    .padding(.horizontal,10)
                                }
                                .padding(.leading,20)
                                .onAppear {
                                    proxy.scrollTo(0)
                                }
                            }
                        }
                        VStack {
                        }
                        .frame(width: screenWidth * 0.8, height: 1)
                        .background(appBlueColor)
                        .padding(.vertical,10)
                        HStack {
                            Spacer()
                            let other = arr.filter { $0.id != id }
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyVGrid(columns: gridColumnsOther,alignment: .center,spacing: 5) {
                                    ForEach(other.indices,id: \.self) { row in
                                        let item = other[row]
                                        WareefOtherGridView(item: item,image: images[item.id]!)
                                            .onTapGesture {
                                                id = item.id
                                            }
                                    }
                                }
                                .frame(width: screenWidth * 0.85)
                                .padding(.vertical,30)
                                .padding(.horizontal,10)
                            }
                            .frame(width: screenWidth * 0.85 + 20)
                            .padding(.leading,10)
                            Spacer()
                        }
                    }
                    else {
                        if wareefVM.submitMainLoading {
                           LoadingView()
                                .frame(height: screenHeight * 0.5)
                        }
                        else {
                            ScrollView {
                                LazyVGrid(columns: gridColumns,spacing: 10) {
                                    ForEach(arr.indices,id: \.self) { row in
                                        let item = arr[row]
                                        WareefMainGridView(item: item,image:images[item.id]!)
                                            .onTapGesture {
                                                id = item.id
                                                showBack = true
                                            }
                                    }
                                }
                                .frame(width: screenWidth * 0.75)
                                .padding(10)
                            }
                        }
                    }
                }
                .padding(.top,10)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayCommon))
            }
            //.scrollIndicators(.never)
            .onChange(of: id, perform: { newValue in
                if let index = newValue {
                    if wareefVM.wareefCache[index] == nil {
                        wareefVM.loadCategory(index)
                    }
                }
             })
        }
        .fullScreenCover(isPresented: $showDiscountView,onDismiss: {
            wareefVM.subIndex = nil
         }) {
             WareefDiscountView(item: wareefVM.wareefCache[id!]![wareefVM.subIndex!],showWareefCard:wareefVM.showWareefCard)
                 .modifier(PresentationBackgroundModifier())
        }
        .background(Color.lightGrayCommon)
        .sheet(isPresented: $appleCardVM.showPk){
           AddPassView(pass: $appleCardVM.pass)
             .colorScheme(.light)
        }
        .onFirstAppear {
           wareefVM.start()
        }
    }
}
