//
//  BookingListView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine

struct BookingListView: View {
    @EnvironmentObject var coordinator: Coordinator
    let items:[BookingsClientItem]?
    @State var selected = 0
    @State var first = true
    let gridRows:[GridItem] = [GridItem(.flexible())]
    @StateObject var bookingListVM = BookingListVM()
    @StateObject var allBookigsVM = AllBookigsVM()
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
                VStack {
                    if let items = allBookigsVM.bookings , !allBookigsVM.submitLoadingBookings {
                        List(Array(items.enumerated()),id: \.element.identifier) { index,item in
                            BookingClientList(item: item,bookingListVM: bookingListVM)
                                .modifier(ListItemMode())
                        }
                        .modifier(ListMode())
                    }
                    else {
                        LoadingView()
                    }
                    Spacer()
                    RoundedLoaderHBu(item: "AddBooking", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor,vPadding: 15,showLoader:false)
                        .padding(.top,20)
                        .onTapGesture {
                            coordinator.push(CarServiceType.wash)
                        }
                }
                .padding(20)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
            } 
         }
        .toast(isPresenting: $bookingListVM.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: bookingListVM.toastContent)
        }
        .toast(isPresenting: $bookingListVM.toastShownInfo) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: bookingListVM.toastContentInfo)
        }
        .onChange(of: bookingListVM.goBack, perform: { _ in
            coordinator.pop()
        })
        .fullScreenCover(isPresented: $bookingListVM.showCancel,onDismiss: {
        }) {
            CancelBookingView(cancelManager: bookingListVM)
                .modifier(PresentationBackgroundModifier())
        }
        .background(Color.lightGrayMid)
        .navigationBarBackButtonHidden()
        .onAppear {
            if first , let items = items {
                allBookigsVM.bookings = items
                first = false
            }
            else {
                allBookigsVM.getBookingsPerClient()
            }
        }
    }
}
