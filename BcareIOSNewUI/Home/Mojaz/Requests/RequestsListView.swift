//
//  RequestsListView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine

struct RequestsListView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var lottieLoading: LottieLoading
    let items:[MojazResult]?
    @State var first = true
    let gridRows:[GridItem] = [GridItem(.flexible())]
    @StateObject var allRequestsVM = AllRequestsVM()
    @StateObject var requestsListVM = RequestsListVM()
    @State var showShareSheet = false

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HStack {
                    BackPaddedButton(color: Color.black,back: Color.white)
                    Spacer()
                    HStack {
                        Text(verbatim:"MojazRequests".localized)
                            .font(Fonts.mediumRegular())
                            .foregroundColor(Color.black) 
                    } 
                }
                .padding(.horizontal,10)
                VStack {
                    if let items = allRequestsVM.bookings , !allRequestsVM.submitLoadingRecords {
                        List(Array(items.enumerated()),id: \.element.identifier) { index,item in
                            RequestsClientList(item: item,requestsListVM: requestsListVM)
                                .modifier(ListItemMode())
                        }
                        .modifier(ListMode())
                    }
                    else {
                        LoadingView()
                    }
                    Spacer()
                    RoundedLoaderHBu(item: "RequestNewReport", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor,vPadding: 15,showLoader:false)
                        .padding(.top,20)
                        .onTapGesture {
                            coordinator.push(Destination.mojazPage)
                        }
                }
                .padding(20)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
            }
         }
        .toast(isPresenting: $allRequestsVM.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: allRequestsVM.toastContent)
        }
        .toast(isPresenting: $allRequestsVM.toastShownInfo) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: allRequestsVM.toastContentInfo)
        }
        .onChange(of: requestsListVM.submitLoadingFile, perform: { newValue in
            lottieLoading.show = newValue
        })
        .onChange(of:requestsListVM.checkDownloads, perform: { newValue in
            showShareSheet = true
         })
        .sheet(isPresented: $showShareSheet) {
            if let res = requestsListVM.downloadUrl {
                ShareSheet(activityItems: [res])
            }
        }
        .background(Color.lightGrayMid)
        .navigationBarBackButtonHidden()
        .onAppear {
            if first , let items = items {
                allRequestsVM.bookings = items
                first = false
            }
            else {
                allRequestsVM.mojazCompleteInfosByNationalId()
            }
        }
    }
}
