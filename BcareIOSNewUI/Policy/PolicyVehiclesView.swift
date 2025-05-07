//
//  PolicyVehiclesView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine
import MapKit

struct PolicyVehiclesView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var appleCardVM = AppleCardVM()
    @StateObject var policyVehiclesVM = PolicyVehiclesVM()
    @EnvironmentObject var lottieLoading: LottieLoading
    let item:PoliciesResult
    @State var id:Int?
    @State var showShareSheet = false
    let imgWid:CGFloat = isIpad ? 30 : 20
    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.5)
            VStack(spacing:0) {
                VStack(spacing:0) {
                    HeaderWithBackView(text:"VehiclePolicy".localized)
                    MainCardView(items:[item],showExpire:false) { item in
                        lottieLoading.show = true
                        appleCardVM.getCard(item)
                    }
                    .environmentObject(lottieLoading)
                    .padding(.bottom,10)
                    VStack {
                        HStack {
                            PolicyFAView(title: "DownloadPolicy", icon: FontAwesome.downloadIcon)
                                .onTapGesture {
                                    if let _ = policyVehiclesVM.downloadUrl {
                                        showShareSheet = true
                                    }
                                    else {
                                        policyVehiclesVM.downloadFile(item)
                                    }
                                }
                            if let najmStatus = item.najmStatus() {
                                PolicyImgView(title: najmStatus, icon: "najm")
                            }
                            if item.closeToExpiration() {
                                PolicyFAView(title: "RenewPolicy", icon: FontAwesome.updateIcon)
                                    .onTapGesture {
                                        if let gl = createGl() {
                                            coordinator.push(TermsPrivacyItem(url: gl))
                                        }
                                     }
                            }
                            Spacer()
                        }
                        .padding(.horizontal,20)
                        .padding(.bottom,10)
                        VehiclesGeneralView()
                    }
                    .padding(.leading,20)
                    .padding(.top,20)
                    .modifier(RoundedBackgroundModifer(color: .white))
                }
                Spacer()
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden()
        .onChange(of: appleCardVM.submitGetCard, perform: { newValue in
            lottieLoading.show = newValue
        })
        .onChange(of: policyVehiclesVM.submitGetFile, perform: { newValue in
            lottieLoading.show = newValue
        })
        .sheet(isPresented: $appleCardVM.showPk){
            AddPassView(pass: $appleCardVM.pass)
                .colorScheme(.light)
        }
        .onChange(of:policyVehiclesVM.downloadUrl, perform: { newValue in
            if let _ = newValue {
                showShareSheet = true
            }
        })
        .sheet(isPresented: $showShareSheet) {
            if let res = policyVehiclesVM.downloadUrl {
                ShareSheet(activityItems: [res])
            }
        }
    }
    func createGl() -> String? {
        guard let value = userBeginLoginItem ,
                UserManager.isLoggedIn() ,
                let externalId = item.externalId ,
                let referenceId = item.referenceId else { return nil }
        let url = item.productID == 1 ? AppURL : MalpracticesURL
        let data = try! JSONEncoder().encode(value)
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let res = url + "?channel=ios&lang=\(langText)&version=\(version)&firebasetoken=\(FIREBASE_TOKEN ?? "")&gl=" + data.base64EncodedString() + "&eid=" + externalId + "&r=1&re=" + referenceId
        print(res)
        return res
    }
}
