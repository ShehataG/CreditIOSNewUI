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
import AxisTabView

struct ContentView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var homeVM = HomeVM()
    @State var selectedIndex = 0
    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init())
    @State private var radius: CGFloat = 70
    @State private var concaveDepth: CGFloat = 0.85
    @State private var color: Color = .white
    
    var body: some View {
        VStack(spacing:0) {
//            VStack(spacing:0) {
//                TabView(selection: $selectedIndex) {
//                    HomeView()
//                        .tag(0)
//                    ProductsView()
//                        .tag(1)
//                    ServicesView()
//                        .tag(2)
//                    WareefView()
//                        .tag(3)
//                    if UserManager.isLoggedIn() {
//                        ProfileView()
//                            .tag(4)
//                    }
//                }
//                HStack {
//                    TabItemView(text: "Main", icon: "home", tag: 0, selectedIndex: $selectedIndex)
//                        .frame(maxWidth: .infinity)
//                    TabItemView(text: "Products", icon: "products", tag: 1, selectedIndex: $selectedIndex)
//                        .frame(maxWidth: .infinity)
//                    TabItemView(text: "Services", icon: "services", tag: 2, selectedIndex: $selectedIndex)
//                        .frame(maxWidth: .infinity)
//                    TabItemView(text: "Wareef", icon: "wareef", tag: 3, selectedIndex: $selectedIndex)
//                        .frame(maxWidth: .infinity)
//                    if UserManager.isLoggedIn() {
//                        TabItemView(text: "MyAccount", icon: "user", tag: 4, selectedIndex: $selectedIndex)
//                            .frame(maxWidth: .infinity)
//                    }
//                }
//            }
            GeometryReader { proxy in
                AxisTabView(selection: $selection, constant: constant) { state in
                    CustomCenterStyle(state, color: color, radius: radius, depth: concaveDepth)
                } content: {
                    HomeView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 0, systemName: "home", safeArea: proxy.safeAreaInsets)
                    ProductsView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 1, systemName: "calculator", safeArea: proxy.safeAreaInsets)
                    ControlView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 2, systemName: "plus.circle.fill", safeArea: proxy.safeAreaInsets)
                    WareefView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 3, systemName: "wareef", safeArea: proxy.safeAreaInsets)
                    ProfileView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 4, systemName: "user", safeArea: proxy.safeAreaInsets)
                } onTapReceive: { selectionTap in
                    /// Imperative syntax
                    print("---------------------")
                    print("Selection : ", selectionTap)
                    print("Already selected : ", self.selection == selectionTap)
                }
            }
            .animation(.easeInOut, value: constant)
            .animation(.easeInOut, value: radius)
            .animation(.easeInOut, value: concaveDepth)
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
