//
//  OrdersListView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine

struct OrdersListView: View {
    @EnvironmentObject var coordinator: Coordinator
    let item:OrderSentItem?
    @State var selected = 0
    @State var first = true
    let gridRows:[GridItem] = [GridItem(.flexible())]
    @State var showSearch = false
    @StateObject var ordersListVM = OrdersListVM()
    @StateObject var allOrdersVM = AllOrdersVM()
    @State var showHelp = false
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
                        showHelp = true
                    }
                }
                .padding(.horizontal,10)
                VStack {
                    if let items = allOrdersVM.orders , !allOrdersVM.submitLoadingOrders {
                        List(Array(items.enumerated()),id: \.element.identifier) { index,item in
                            OrdersClientList(item: item,ordersListVM: ordersListVM)
                                .modifier(ListItemMode())
                        }
                        .modifier(ListMode())
                    }
                    else {
                        LoadingView()
                    }
                    Spacer()
                    if allOrdersVM.disableAddBooking {
                        RoundedLoaderHBu(item: "AddService", textColor: .black, backEnableColor: Color.lightGray,backDisableColor:appOrangeDarkColor,vPadding: 15,showLoader:false)
                            .padding(.top,20)
                            .onTapGesture {
                                allOrdersVM.showCurrentOrder()
                            }
                    }
                    else {
                        RoundedLoaderHBu(item: "AddService", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor,vPadding: 15,showLoader:false)
                            .padding(.top,20)
                            .onTapGesture {
                                if let type = item?.type {
                                    coordinator.push(type)
                                    allOrdersVM.disableAddBooking = true
                                }
                            }
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
            }
         }
        .toast(isPresenting: $ordersListVM.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: ordersListVM.toastContent)
        }
        .toast(isPresenting: $ordersListVM.toastShownInfo) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: ordersListVM.toastContentInfo)
        }
        .toast(isPresenting: $allOrdersVM.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: allOrdersVM.toastContent)
        }
        .toast(isPresenting: $allOrdersVM.toastShownInfo) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: allOrdersVM.toastContentInfo)
        }
        .onChange(of: ordersListVM.goBack, perform: { _ in
            coordinator.pop()
        })
        .fullScreenCover(isPresented: $showHelp,onDismiss: {
            showHelp = false
         }) {
             HelpView()
                 .modifier(PresentationBackgroundModifier())
        }
        .background(Color.lightGrayMid)
        .navigationBarBackButtonHidden()
        .onAppear {
            if first , let item = item {
                allOrdersVM.orders = item.items
                allOrdersVM.checkOrderStatus()
                first = false
            }
            else {
                allOrdersVM.getOrders()
            }
        }
    }
}
