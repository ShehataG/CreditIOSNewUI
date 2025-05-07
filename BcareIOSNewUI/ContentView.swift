//
//  ContentView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import SwiftUI
import AppTrackingTransparency
import AdSupport
import AdjustSdk

struct ContentView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var homeVM = HomeVM()
    @State var selectedIndex = 0
    var body: some View {
        VStack(spacing:0) {
            VStack(spacing:0) {
                TabView(selection: $selectedIndex) {
                    HomeView()
                        .tag(0)
                    ProductsView()
                        .tag(1)
                    ServicesView()
                        .tag(2)
                    WareefView()
                        .tag(3)
                    if UserManager.isLoggedIn() {
                        ProfileView()
                            .tag(4)
                    }
                }
                HStack {
                    TabItemView(text: "Main", icon: "home", tag: 0, selectedIndex: $selectedIndex)
                        .frame(maxWidth: .infinity)
                    TabItemView(text: "Products", icon: "products", tag: 1, selectedIndex: $selectedIndex)
                        .frame(maxWidth: .infinity)
                    TabItemView(text: "Services", icon: "services", tag: 2, selectedIndex: $selectedIndex)
                        .frame(maxWidth: .infinity)
                    TabItemView(text: "Wareef", icon: "wareef", tag: 3, selectedIndex: $selectedIndex)
                        .frame(maxWidth: .infinity)
                    if UserManager.isLoggedIn() {
                        TabItemView(text: "MyAccount", icon: "user", tag: 4, selectedIndex: $selectedIndex)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden()
        .onOpenURL(perform:handleURL)
        .environmentObject(homeVM)
        .onReceive(.logoutAuthNotification) { _ in
            coordinator.reset()
        }
        .onReceive(.reloadPoliciesNotification) { _ in
            Task {
                await homeVM.getAllUserActivePolicies()
            }
        }
        .onReceive(.changeTabNotification) { notification in
            selectedIndex = notification.object as! Int
        }
        .onFirstAppear {
            isAppOpened = true
            Adjust.trackEvent(ADJEvent(eventToken: "ik8401"))
            requestIDFA()
        }
    }
    func handleURL(_ url: URL) {
        if url.scheme?.localizedCaseInsensitiveCompare(Config.urlScheme) == .orderedSame {
            NotificationCenter.default.post(name: .hyperpayNotification, object: nil)
        }
    }
    func requestIDFA() {
        Task {
            let _ = await ATTrackingManager.requestTrackingAuthorization()
        }
    }
}
