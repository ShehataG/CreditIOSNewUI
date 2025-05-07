//
//  MedicalGeneralView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SanarKit

struct MedicalGeneralView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var servicesStatusVM: ServicesStatusVM
    @EnvironmentObject var sanarVM: SanarVM
    @State var toastShown = false
    @State var toastContent = ""
    let gridRows:[GridItem] = [GridItem(.flexible())]
    let mainHeight:CGFloat = Constants.hGridHeight * 121 / 114
    let topHeader:CGFloat
    init(topHeader: CGFloat = 0) {
        self.topHeader = topHeader
    }
    var body: some View {
        if servicesStatusVM.done {
            let medicalItems = servicesStatusVM.medicalItems
            if !medicalItems.isEmpty {
                VStack(spacing:0) {
                    HStack {
                        Text(verbatim:"MedicalServices".localized)
                            .font(Fonts.mediumRegular())
                            .foregroundColor(Color.black)
                            .padding(.horizontal,10)
                        Spacer()
                    }
                    .padding(.top,5 + topHeader)
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows:gridRows,alignment:.bottom,spacing: 10) {
                                ForEach(medicalItems.indices,id: \.self) { row in
                                    MainTypeView(item: medicalItems[row])
                                        .tag(row)
                                        .onTapGesture {
                                            if !UserManager.isLoggedIn() {
                                                coordinator.push(Destination.loginPage)
                                                return
                                            }
                                            if !sanarVM.isSanarConnected {
                                                toastContent = "ProblemConnectingSanar".localized
                                                toastShown = true
                                                return
                                            }
                                            if row == 0 {
                                                sanarVM.isService = true
                                            }
                                            else if row == 1 {
                                                sanarVM.isBooking = true
                                            }
                                        }
                                }
                            }
                            .frame(height: mainHeight)
                        }
                        .frame(height: mainHeight)
                        .padding(.vertical,20)
                        .toast(isPresenting: $toastShown) {
                            AlertToast(displayMode: .hud, type: .error(Color.red), title: toastContent)
                        }
                        .onFirstAppear {
                            sanarVM.start()
                        }
                        .onReceive(.sanarConnectNotification) { _ in
                            sanarVM.start()
                        }
                        .onReceive(.sanarDisconnectNotification) { _ in
                            sanarVM.disconnect()
                        }
                        .onReceive(.sanarLangNotification) { _ in
                            sanarVM.disconnect()
                        }
                        .onAppear {
                            proxy.scrollTo(0)
                        }
                    }
                }
            }
        }
        else {
            if noNetwork() {
                NetworkView() {
                    Task {
                        await servicesStatusVM.getConfigs()
                    }
                }
            }
            else {
                LoadingView()
            }
        }
    }
}
